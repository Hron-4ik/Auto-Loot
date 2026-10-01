
local DEBUG_MODE = false

local function Log(msg)
    Ext.Utils.Print("[AutoLoot] " .. tostring(msg))
end

local function Dbg(msg)
    if DEBUG_MODE then
        Ext.Utils.Print("[AutoLoot-DBG] " .. tostring(msg))
    end
end

Log("=== v9.34 SCRIPT LOADED (DEBUG_MODE=" .. tostring(DEBUG_MODE) .. ") ===")

local SKILL_NORMAL   = "Shout_AutoLoot_Normal"
local SKILL_STEAL    = "Shout_AutoLoot_Steal"
local STATUS_NORMAL  = "AUTOLOOT_NORMAL"
local STATUS_STEAL   = "AUTOLOOT_STEAL"
local STATUS_SNEAK   = "SNEAKING"


local MODE_OFF    = 0
local MODE_NORMAL = 1
local MODE_STEAL  = 2

local NULL_GUID = "NULL_00000000-0000-0000-0000-000000000000"

local STEALTH_WINDOW  = 800
local TOGGLE_DEBOUNCE = 700
local LastSkillUse    = {}
local LastToggleUse   = {}

local PendingChecks = {}
local function ScheduleCheck(delayMs, callback)
    table.insert(PendingChecks, {
        at = Ext.Utils.MonotonicTime() + delayMs,
        fn = callback
    })
end

Ext.Events.Tick:Subscribe(function()
    if #PendingChecks == 0 then return end
    local now = Ext.Utils.MonotonicTime()
    local i = 1
    while i <= #PendingChecks do
        local entry = PendingChecks[i]
        if now >= entry.at then
            table.remove(PendingChecks, i)
            pcall(entry.fn)
        else
            i = i + 1
        end
    end
end)

local AutoLoot = {
    State            = {},
    LastScan         = {},
    OpenedContainers = {},
    SkillsGranted    = {},
    CachedPlayers    = nil,
    Radius           = 15.0,
    ScanInterval     = 750
}

local DeadGuids     = {}
local DEAD_GUID_TTL = 60000

local function IsDeadGuid(guid)
    local t = DeadGuids[guid]
    if not t then return false end
    if (Ext.Utils.MonotonicTime() - t) > DEAD_GUID_TTL then
        DeadGuids[guid] = nil
        return false
    end
    return true
end

local function MarkDeadGuid(guid)
    DeadGuids[guid] = Ext.Utils.MonotonicTime()
end


local function IsNullGuid(g)
    return not g or g == "" or g == NULL_GUID
end

local function RefreshPlayerCache()
    local list = {}
    local ok, guids = pcall(Ext.Entity.GetAllCharacterGuids)
    if ok and guids then
        for _, g in pairs(guids) do
            local isP = false
            pcall(function() isP = (Osi.CharacterIsPlayer(g) == 1) end)
            if isP then table.insert(list, g) end
        end
    end
    AutoLoot.CachedPlayers = list
    return #list > 0
end

local function GetCachedPlayers()
    return AutoLoot.CachedPlayers or {}
end

local function SafeGetItemEntity(guid)
    if not guid or guid == "" then return nil end
    if IsDeadGuid(guid) then return nil end
    local ok, tmpl = pcall(Osi.GetTemplate, guid)
    if not ok or not tmpl or tmpl == "" then
        MarkDeadGuid(guid); return nil
    end
    local ok2, entity = pcall(Ext.Entity.GetItem, guid)
    if not ok2 or not entity then
        MarkDeadGuid(guid); return nil
    end
    return entity
end

local function SafeGetCharacterEntity(guid)
    if not guid or guid == "" then return nil end
    if IsDeadGuid(guid) then return nil end
    local ok, entity = pcall(Ext.Entity.GetCharacter, guid)
    if not ok or not entity then
        MarkDeadGuid(guid); return nil
    end
    return entity
end


local function ApplyStatusSafe(target, statusName, duration, force)
    if not target or not statusName then return end
    local ok, err = pcall(function()
        Osi.ApplyStatus(target, statusName, duration, force)
    end)
    Dbg("ApplyStatus " .. statusName .. " ok=" .. tostring(ok) .. " " .. tostring(err))
end

local function RemoveStatusSafe(target, statusName)
    if not target or not statusName then return end
    local ok, err = pcall(function()
        Osi.RemoveStatus(target, statusName)
    end)
    Dbg("RemoveStatus " .. statusName .. " ok=" .. tostring(ok) .. " " .. tostring(err))
end

local function IsSneaking(charGuid)
    return Osi.HasActiveStatus(charGuid, STATUS_SNEAK) == 1
end

local function RestoreSneaking(charGuid)
    Dbg("RestoreSneaking для " .. tostring(charGuid))
    pcall(function()
        Osi.ApplyStatus(charGuid, STATUS_SNEAK, -1.0, 0)
    end)
end

local function TryRestoreSneakOnce(charGuid)
    LastSkillUse[charGuid] = nil
    if IsSneaking(charGuid) then return end
    RestoreSneaking(charGuid)
end

local AffectedNpcs = {}

local function CrimeSuppress(charGuid)
    Dbg("CrimeSuppress для " .. tostring(charGuid))
    pcall(function() Osi.CharacterDisableAllCrimes(charGuid) end)

    local px, py, pz = Osi.GetPosition(charGuid)
    if not px then return end
    local ok, chars = pcall(Ext.Entity.GetCharacterGuidsAroundPosition, px, py, pz, 25.0)
    if not ok or not chars then return end
    local count = 0
    for _, guid in pairs(chars) do
        if guid and guid ~= charGuid and not AffectedNpcs[guid] then
            pcall(function() Osi.CharacterDisableAllCrimes(guid) end)
            AffectedNpcs[guid] = true
            count = count + 1
        end
    end
    Dbg("CrimeSuppress: отключено у " .. count .. " NPC")
end

local function CrimeRestoreAll()
    local count = 0
    for guid, _ in pairs(AffectedNpcs) do
        pcall(function() Osi.CharacterEnableAllCrimes(guid) end)
        count = count + 1
    end
    Dbg("CrimeRestoreAll: восстановлено у " .. count .. " NPC")
    AffectedNpcs = {}
end

local function CrimePurge(charGuid)
    pcall(function()
        if Osi.CharacterCanIgnoreActiveCrimes
           and Osi.CharacterCanIgnoreActiveCrimes(charGuid) == 1 then
            Osi.CharacterIgnoreActiveCrimes(charGuid)
            Dbg("CrimePurge: снято преступление с " .. tostring(charGuid))
        end
    end)
end

local function GetLuckyCharmLevel(charGuid)
    local level = 0
    local charObj = SafeGetCharacterEntity(charGuid)
    if charObj and charObj.Stats then
        local raw = charObj.Stats.Luck
        if type(raw) == "number" and raw > 0 then level = raw end
    end
    return level
end

local function GetLuckTableName(charGuid)
    local lvl = GetLuckyCharmLevel(charGuid)
    if lvl <= 0 then return nil end
    return "Luck" .. lvl
end

local BANNED_STAT_PREFIXES = {
    "Gen_Door", "Gen_Wood", "Gen_Stone", "Gen_LightSource", "DEC_",
    "Gen_Container", "Gen_Wood_Indestructible",
    "LTS_", "HAR_",
    "Chair_", "Stool_", "Bench_", "Furniture_", "Table_",
    "Shelf_", "Cupboard_", "Wardrobe_", "Sarcophagus", "Grave_",
    "Tomb_", "Painting_", "Candle_", "Candelab", "Chandelier",
    "Brazier", "Campfire", "Fireplace", "Anvil", "Forge", "Loom"
}

local BANNED_STAT_KEYWORDS = {
    "chair", "stool", "bench", "table_", "_table",
    "bed_", "_bed", "cot", "hammock", "bunk",
    "candelab", "chandelier", "brazier", "campfire", "fireplace",
    "anvil", "forge", "loom", "whetstone", "cauldron",
    "painting", "tapestry", "rug", "carpet",
    "vase", "pot_", "_pot", "urn", "amphora",
    "furniture", "shelf", "cupboard", "wardrobe", "cabinet",
    "bookcase", "dresser", "nightstand", "drawer",
    "sign", "banner", "lantern_", "torch_", "candle_",
    "statue", "monument", "pillar", "column",
    "fence", "gate", "door", "window",
    "crate_", "_crate", "barrel_", "_barrel",
    "sack_", "_sack", "basket",
    "citz_stool", "citz_bench", "citz_table", "citz_chair",
    "poor_chair", "poor_stool", "poor_bench",
    "rich_table", "rich_chair",
    "camping_tent", "ship_interior_lantern",
    "lightsource", "light_source"
}

local UTILITY_KEYWORDS = {
    "key", "magnifyingglass", "magnifying_glass", "shovel",
    "bedroll", "sleepingbag", "sleeping_bag", "sleeping bag",
    "tent", "camping", "lockpick", "trapkit", "trap_kit",
    "repair", "shaft", "craft_", "hammer", "pickaxe",
    "fishing",
    "bucket", "rope"
}

local function IsUtilityItem(sIdLower)
    for _, kw in ipairs(UTILITY_KEYWORDS) do
        if sIdLower:find(kw, 1, true) then return true end
    end
    return false
end

local function IsBannedFurniture(sId, tmplStr)
    if not sId or sId == "" then return false end
    local sIdLower  = sId:lower()
    local tmplLower = tostring(tmplStr or ""):lower()

    for _, kw in ipairs(UTILITY_KEYWORDS) do
        if sIdLower:find(kw, 1, true) then return false end
    end
    for _, prefix in ipairs(BANNED_STAT_PREFIXES) do
        if sId:find("^" .. prefix) then return true end
    end
    local combined = sIdLower .. " " .. tmplLower
    for _, kw in ipairs(BANNED_STAT_KEYWORDS) do
        if combined:find(kw, 1, true) then return true end
    end
    return false
end

local function IsFoodOrDrink(sIdLower)
    if sIdLower:find("^con_food_") then return true end
    if sIdLower:find("^con_drink_") then return true end
    if sIdLower:find("^con_potion_") then return true end
    if sIdLower:find("^con_ingredient_") then return true end
    if sIdLower:find("^food_") then return true end
    return false
end

local function IsValidPickupItem(guid, charGuid, mode, isFromContainer)
    if not guid or guid == "" then return false end

    local tmpl = Osi.GetTemplate(guid)
    if Osi.ItemIsDestroyed(guid) == 1 then return false end

    if Osi.ItemIsContainer(guid) == 1 and not isFromContainer then return false end
    if not isFromContainer and Osi.ItemIsInInventory(guid) == 1 then return false end

    local item = SafeGetItemEntity(guid)
    if not item then
        if isFromContainer then return Osi.ItemIsStoryItem(guid) ~= 1 end
        return false
    end

    local sId       = tostring(item.StatsId or "")
    local sIdLower  = sId:lower()
    local tmplLower = tostring(tmpl or ""):lower()

    if sIdLower:find("gold", 1, true)
       or tmplLower:find("gold", 1, true)
       or sIdLower:find("currency", 1, true) then
        return true
    end

    local isUtility = IsUtilityItem(sIdLower)
    local isFood    = IsFoodOrDrink(sIdLower)

    local owner = Osi.ItemGetOwner(guid)
    if not IsNullGuid(owner) and owner == charGuid then return false end

    if isFromContainer then
        if Osi.ItemIsStoryItem(guid) == 1 and not isUtility and not isFood then
            return false
        end
        return true
    end

    if Osi.ItemIsStoryItem(guid) == 1 and not isUtility and not isFood then
        return false
    end

    if not isUtility and not isFood then
        if sId == "" or IsBannedFurniture(sId, tmpl) then return false end
    end

    if mode == MODE_NORMAL then
        if not IsNullGuid(owner) and owner ~= charGuid then
            if Osi.CharacterIsDead(owner) ~= 1 then return false end
        end
    end

    return true
end

local function CollectItem(itemGuid, charGuid, mode)
    local clearOwner = (mode == MODE_STEAL) and 1 or 0
    local amount = Osi.ItemGetAmount(itemGuid) or 1
    if amount <= 0 then amount = 1 end

    local item = SafeGetItemEntity(itemGuid)
    if not item then return false end

    local target = charGuid

    local inInvBefore = Osi.ItemIsInInventory(itemGuid)
    pcall(function()
        Osi.ItemToInventory(itemGuid, target, amount, 0, clearOwner)
    end)
    local inInvAfter = Osi.ItemIsInInventory(itemGuid)

    return (inInvBefore == 0 and inInvAfter == 1)
end

local function GetContainerContents(entityGuid, isCharacter)
    local result, seen = {}, {}
    local function addItems(list)
        if not list then return end
        for _, g in pairs(list) do
            if g and g ~= "" and not seen[g] then
                seen[g] = true
                table.insert(result, g)
            end
        end
    end
    pcall(function()
        local obj
        if isCharacter then obj = SafeGetCharacterEntity(entityGuid)
        else obj = SafeGetItemEntity(entityGuid) end
        if obj and obj.GetInventoryItems then addItems(obj:GetInventoryItems()) end
    end)
    return result
end

local function ExtractFromContainer(containerGuid, charGuid, mode)
    local count = 0
    local contents = GetContainerContents(containerGuid, false)
    for _, childGuid in ipairs(contents) do
        if IsValidPickupItem(childGuid, charGuid, mode, true) then
            if CollectItem(childGuid, charGuid, mode) then
                count = count + 1
            end
        end
    end
    return count
end

local function ExtractFromCharacter(targetGuid, charGuid, mode)
    local count = 0
    for _, childGuid in ipairs(GetContainerContents(targetGuid, true)) do
        if IsValidPickupItem(childGuid, charGuid, mode, true) then
            if CollectItem(childGuid, charGuid, mode) then
                count = count + 1
            end
        end
    end
    return count
end

local function IterateEntitiesNear(px, py, pz, radius, callback)
    local okChars, chars = pcall(Ext.Entity.GetCharacterGuidsAroundPosition, px, py, pz, radius)
    if okChars and chars then
        for _, guid in pairs(chars) do
            callback(guid, { isCharacter = true })
        end
    end
    local okItems, items = pcall(Ext.Entity.GetItemGuidsAroundPosition, px, py, pz, radius)
    if okItems and items then
        for _, guid in pairs(items) do
            if not IsDeadGuid(guid) then
                local isContainer = Osi.ItemIsContainer(guid) == 1
                callback(guid, { isItem = true, isContainer = isContainer })
            end
        end
    end
end

local function RunScan(charGuid)
    local mode = AutoLoot.State[charGuid] or MODE_OFF
    if mode == MODE_OFF then return end
    if Osi.CharacterIsInCombat(charGuid) == 1 then return end
    if Osi.CharacterIsDead(charGuid) == 1 then return end

    if mode == MODE_STEAL then
        CrimeSuppress(charGuid)
    end

    local px, py, pz = Osi.GetPosition(charGuid)
    if not px or not py or not pz then return end

    local lootedCount = 0
    local processed = {}

    IterateEntitiesNear(px, py, pz, AutoLoot.Radius, function(guid, info)
        if processed[guid] then return end
        processed[guid] = true
    
        if info.isContainer then
            local canLoot = true
            if mode == MODE_NORMAL then
                local owner = Osi.ItemGetOwner(guid)
                if not IsNullGuid(owner) and owner ~= charGuid then
                    if Osi.CharacterIsDead(owner) ~= 1 then canLoot = false end
                end
            end
            if canLoot then
                if not AutoLoot.OpenedContainers[guid] then
                    AutoLoot.OpenedContainers[guid] = true
                    if mode == MODE_STEAL then
                        local isLocked = false
                        pcall(function() isLocked = Osi.ItemIsLocked(guid) == 1 end)
                        if isLocked then
                            pcall(function() Osi.ItemUnLock(guid) end)
                        end
                    end
                    pcall(function() Osi.ItemOpen(guid) end)

                    local luckTable = GetLuckTableName(charGuid)
                    if luckTable then
                        pcall(function()
                            Osi.GenerateTreasure(guid, luckTable, -1, charGuid)
                        end)
                        Dbg("Lucky Charm lv." .. GetLuckyCharmLevel(charGuid))
                    end
                end
                lootedCount = lootedCount
                    + ExtractFromContainer(guid, charGuid, mode)
            end
        end

        if info.isCharacter and Osi.CharacterIsDead(guid) == 1 then
            lootedCount = lootedCount
                + ExtractFromCharacter(guid, charGuid, mode)
        end

        if info.isItem and not info.isContainer then
            if IsValidPickupItem(guid, charGuid, mode, false) then
                if CollectItem(guid, charGuid, mode) then
                    lootedCount = lootedCount + 1
                end
            end
        end
    end)

    if mode == MODE_STEAL then CrimePurge(charGuid) end

    if lootedCount > 0 then
        if DEBUG_MODE then
            Dbg("SCAN собрал " .. lootedCount .. " предметов")
        end
    end
end

local function SetAuraMode(charGuid, targetMode)
    Dbg("SetAuraMode target=" .. tostring(targetMode))

    local ok, err = pcall(function()
        local currentMode = AutoLoot.State[charGuid] or MODE_OFF

        if currentMode == targetMode then
            AutoLoot.State[charGuid] = MODE_OFF
            RemoveStatusSafe(charGuid, STATUS_NORMAL)
            RemoveStatusSafe(charGuid, STATUS_STEAL)
            CrimeRestoreAll()
            pcall(function() Osi.CharacterEnableAllCrimes(charGuid) end)
            Log(charGuid .. " -> ВЫКЛ")
            return
        end

        AutoLoot.State[charGuid] = targetMode
        RemoveStatusSafe(charGuid, STATUS_NORMAL)
        RemoveStatusSafe(charGuid, STATUS_STEAL)
        AutoLoot.OpenedContainers = {}

        if targetMode == MODE_NORMAL then
            CrimeRestoreAll()
            pcall(function() Osi.CharacterEnableAllCrimes(charGuid) end)
            ApplyStatusSafe(charGuid, STATUS_NORMAL, -1.0, 1)
        else
            CrimeSuppress(charGuid)
            ApplyStatusSafe(charGuid, STATUS_STEAL, -1.0, 1)
        end
    end)
    if not ok then
        Log("SetAuraMode error: " .. tostring(err))
        return
    end
    pcall(RunScan, charGuid)

    ScheduleCheck(600, function()
        if targetMode ~= MODE_OFF then
            local s = Osi.HasActiveStatus(charGuid, STATUS_STEAL)
            local n = Osi.HasActiveStatus(charGuid, STATUS_NORMAL)
            Dbg("VERIFY-600ms NORMAL=" .. tostring(n) .. " STEAL=" .. tostring(s))
        end
    end)
end

local function GrantSkillsToPlayer(charGuid)
    if not charGuid or charGuid == "" then return false end
    if AutoLoot.SkillsGranted[charGuid] then return true end

    local hasN = Osi.CharacterHasSkill(charGuid, SKILL_NORMAL)
    local hasS = Osi.CharacterHasSkill(charGuid, SKILL_STEAL)

    if hasN == 0 then Osi.CharacterAddSkill(charGuid, SKILL_NORMAL, 0) end
    if hasS == 0 then Osi.CharacterAddSkill(charGuid, SKILL_STEAL, 0) end

    local okN = Osi.CharacterHasSkill(charGuid, SKILL_NORMAL) == 1
    local okS = Osi.CharacterHasSkill(charGuid, SKILL_STEAL) == 1

    if okN and okS then
        AutoLoot.SkillsGranted[charGuid] = true
        Dbg("Skills granted to " .. tostring(charGuid))
        return true
    end
    return false
end

local function SetupPlayer(charGuid)
    Dbg("SetupPlayer " .. tostring(charGuid))

    if DEBUG_MODE then
        local ok1, r1 = pcall(function() return Ext.Stats.Get(STATUS_NORMAL) end)
        local ok2, r2 = pcall(function() return Ext.Stats.Get(STATUS_STEAL) end)
        Dbg("Stats NORMAL ok=" .. tostring(ok1) .. " ret=" .. tostring(r1))
        Dbg("Stats STEAL  ok=" .. tostring(ok2) .. " ret=" .. tostring(r2))
    end

    if not GrantSkillsToPlayer(charGuid) then return end

    if Osi.HasActiveStatus(charGuid, STATUS_NORMAL) == 1 then
        AutoLoot.State[charGuid] = MODE_NORMAL
        pcall(function() Osi.CharacterEnableAllCrimes(charGuid) end)
    elseif Osi.HasActiveStatus(charGuid, STATUS_STEAL) == 1 then
        AutoLoot.State[charGuid] = MODE_STEAL
        CrimeSuppress(charGuid)
        RemoveStatusSafe(charGuid, STATUS_STEAL)
        ApplyStatusSafe(charGuid, STATUS_STEAL, -1.0, 1)
    else
        AutoLoot.State[charGuid] = MODE_OFF
        pcall(function() Osi.CharacterEnableAllCrimes(charGuid) end)
    end
end

local function SyncAllPlayers()
    Dbg("SyncAllPlayers")
    AutoLoot.OpenedContainers = {}
    AutoLoot.LastScan         = {}
    AffectedNpcs              = {}

    if not RefreshPlayerCache() then
        Log("SyncAllPlayers: кэш игроков пуст")
        return
    end

    local players = GetCachedPlayers()
    local n = 0
    for _, guid in ipairs(players) do
        n = n + 1
        SetupPlayer(guid)
    end
    Log("SyncAllPlayers: processed " .. n .. " player(s)")
end

Ext.Osiris.RegisterListener("CharacterUsedSkill", 4, "after", function(charGuid, skillId, _, _)
    if skillId ~= SKILL_NORMAL and skillId ~= SKILL_STEAL then return end

    local now = Ext.Utils.MonotonicTime()
    local last = LastToggleUse[charGuid] or 0
    if (now - last) < TOGGLE_DEBOUNCE then
        Dbg("SKILL debounced " .. skillId)
        return
    end
    LastToggleUse[charGuid] = now
    LastSkillUse[charGuid] = now

    Dbg("SKILL trigger " .. skillId)

    if skillId == SKILL_NORMAL then
        SetAuraMode(charGuid, MODE_NORMAL)
        Log(charGuid .. " -> ОБЫЧНЫЙ")
    elseif skillId == SKILL_STEAL then
        SetAuraMode(charGuid, MODE_STEAL)
        Log(charGuid .. " -> КРАЖА")
    end
end)

Ext.Osiris.RegisterListener("StatusRemoved", 3, "after",
    function(charGuid, statusId, _)
        if statusId ~= STATUS_SNEAK then return end
        local lastUse = LastSkillUse[charGuid]
        if not lastUse then return end
        if (Ext.Utils.MonotonicTime() - lastUse) > STEALTH_WINDOW then
            LastSkillUse[charGuid] = nil
            return
        end
        TryRestoreSneakOnce(charGuid)
    end)

Ext.Events.Tick:Subscribe(function()
    local now = Ext.Utils.MonotonicTime()
    for charGuid, lastUse in pairs(LastSkillUse) do
        if (now - lastUse) > STEALTH_WINDOW then
            LastSkillUse[charGuid] = nil
        end
    end
end)

Ext.Osiris.RegisterListener("CharacterDied", 1, "after", function(charGuid)
    if AutoLoot.State[charGuid] and AutoLoot.State[charGuid] ~= MODE_OFF then
        AutoLoot.State[charGuid] = MODE_OFF
        RemoveStatusSafe(charGuid, STATUS_NORMAL)
        RemoveStatusSafe(charGuid, STATUS_STEAL)
        CrimeRestoreAll()
    end
end)

Ext.Osiris.RegisterListener("SavegameLoaded",        4, "after", function() SyncAllPlayers() end)
Ext.Osiris.RegisterListener("RegionStarted",         1, "after", function() SyncAllPlayers() end)
Ext.Osiris.RegisterListener("SessionLoaded",         1, "after", function() SyncAllPlayers() end)
Ext.Osiris.RegisterListener("GameStarted",           1, "after", function() SyncAllPlayers() end)
Ext.Osiris.RegisterListener("CharacterCreationDone", 1, "after", function() SyncAllPlayers() end)

local lastSkillPoll = 0
Ext.Events.Tick:Subscribe(function()
    local now = Ext.Utils.MonotonicTime()
    if (now - lastSkillPoll) < 2000 then return end
    lastSkillPoll = now

    if not AutoLoot.CachedPlayers or #AutoLoot.CachedPlayers == 0 then
        pcall(RefreshPlayerCache)
    end

    local players = GetCachedPlayers()
    for _, guid in ipairs(players) do
        if guid and not AutoLoot.SkillsGranted[guid] then
            if GrantSkillsToPlayer(guid) then
                if not AutoLoot.State[guid] then SetupPlayer(guid) end
            end
        end
    end
end)

Ext.Events.Tick:Subscribe(function()
    local now = Ext.Utils.MonotonicTime()
    for charGuid, mode in pairs(AutoLoot.State) do
        if mode ~= MODE_OFF then
            local last = AutoLoot.LastScan[charGuid] or 0
            if (now - last) >= AutoLoot.ScanInterval then
                AutoLoot.LastScan[charGuid] = now
                local ok, err = pcall(RunScan, charGuid)
                if not ok then Log("RunScan error: " .. tostring(err)) end
            end
        end
    end
end)

Log("=== v9.34 INIT COMPLETE ===")
