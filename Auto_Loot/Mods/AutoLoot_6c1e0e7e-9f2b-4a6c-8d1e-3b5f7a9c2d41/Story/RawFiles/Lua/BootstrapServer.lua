-- ============================================================================
--  AutoLoot v9.67
--  Automatic loot collection for Divinity: Original Sin 2 - Definitive Edition
-- ============================================================================
--
--  HOW TO CONFIGURE
--  -----------------
--  Edit the values below, save this file, then reload the save in-game.
--  All settings are plain numbers/booleans/strings - just change what you need.
--
-- ============================================================================

local CONFIG = {

    -- Радиус сканирования в метрах. Больше = собирает дальше.
    RADIUS = 15.0,

    -- Подбирать полезные бочки (вода, масло, яд, пиво, туман смерти, слизь и т.п.)
    PICKUP_USEFUL_BARRELS = true,

    -- Подбирать переносимые контейнеры (мешки, корзины, ящики целиком)
    PICKUP_PORTABLE_CONTAINERS = false,

    -- Обыскивать трупы
    PROCESS_CORPSES_AS_ITEMS = false,

    -- Вскрывать замки в обычном режиме (не в режиме кражи)
    UNLOCK_IN_NORMAL_MODE = false,

    -- Разрешить обыск чужих контейнеров в обычном режиме (не в режиме кражи)
    ALLOW_OWNED_CONTAINERS_IN_NORMAL = false,

    -- Минимальная редкость предмета для подбора из мира (не из контейнеров).
    -- Доступно: Common, Uncommon, Rare, Epic, Legendary, Divine, Unique
    MIN_RARITY_TO_PICKUP = "Common",

    -- Писать в лог информацию о редких находках
    NOTIFY_VALUABLE_ITEMS = false,

    -- ============ ПРОДВИНУТЫЕ НАСТРОЙКИ (обычно трогать не нужно) ============

    DEBUG_MODE = false, DEBUG_SCAN = false, DEBUG_CRIME = false, DEBUG_SKILL = false,
    DEBUG_LUCK = false, DEBUG_DIAG = false, DEBUG_FILTER = false, DEBUG_HOOK = false,

    SCAN_INTERVAL = 750, SCAN_INTERVAL_CONTAINER = 750,
    SCAN_INTERVAL_ITEM = 1500, SCAN_INTERVAL_CORPSE = 1500,
    USE_SPLIT_SCAN = true,

    STEALTH_WINDOW = 800,
    TOGGLE_DEBOUNCE = 3000,
    CRIME_SUPPRESS_INTERVAL = 5000,
    LUCK_CACHE_TTL = 2000, OPENED_CONTAINER_TTL = 300000, DEAD_GUID_TTL = 60000,

    HOOK_DEBOUNCE = 50,
    HOOK_RETRY_DELAYS = { 0, 100, 300, 750, 1500, 3000, 5000, 8000, 12000, 18000 },
    OPEN_RECHECK_DELAY = 250,

    UNCOLLECTABLE_TTL = 300000,
    LEVEL_CONTAINER_REFRESH_INTERVAL = 30000,
    SKIP_IF_TREASURE_GENERATED = true,

    VALIDATE_LUCK_TABLES = true, SKIP_DURING_ANIMATION = true,
    MIN_RARITY_FOR_NOTIFY = "Rare",
    RARITY_RANK = { Common=0, Uncommon=1, Rare=2, Epic=3, Legendary=4, Divine=5, Unique=6 },

    WHITELIST_KEYWORDS = { "pot", "painting", "torn_painting", "flask", "bottle", "egg" },

    ALLOW_STORY_FROM_CONTAINERS = true, CONTAINER_FALLBACK_CHECK = true,
    PICKUP_PICKABLE_CONTAINERS = false,

    USEFUL_BARREL_KEYWORDS = {
        "water", "oil", "poison", "beer",
        "deathfog", "death_fog", "death", "fog",
        "ooze", "slime", "mud", "sap", "acid", "venom", "toxic",
    },
    USEFUL_BARREL_IGNORE_STORY = true,

    PORTABLE_PICKUP_WHITELIST = {},
    PORTABLE_PICKUP_BLACKLIST = {
        "sack", "grain", "burlap", "hay", "straw",
        "woodpile", "wood_pile", "haybale", "hay_bale",
        "tinder", "firewood",
    },

    NEARBY_CONTAINER_RADIUS = 4.0,
    EMPTY_RECHECK_ATTEMPTS = 8,
    EMPTY_RECHECK_TTL = 300000,

    PERSISTENT_EMPTY_TEMPLATES = {
        "CONT_Grain_Sack_A", "CONT_Barrel_A", "CONT_Crate", "CONT_Crate_Metal",
        "FUR_Wood", "FUR_Woodpile", "CONT_Woodpile", "Woodpile",
    },

    NEARBY_TEMPLATE_HINTS = {
        "henhouse","bookcase","bookrow","cupboard","shelf","chest","wardrobe",
        "cabinet","bookshelf","vase","urn","amphora","vas_","_vas","cont_vas",
    },
    CONTAINER_TEMPLATE_HINTS = {
        "crate","barrel","chest","vase","urn","amphora","basket",
        "wardrobe","cabinet","cupboard","drawer","bookcase","bookshelf",
        "fur_bar","fur_chest","fur_vase","fur_crate",
        "fur_desk","fur_dresser","fur_coffin","fur_sack_pile","fur_skull_pile",
        "fur_tree_stump","fur_fish_rack","fur_row_of_books","fur_bookrow",
        "fur_ornate_chest","fur_well_worn_chest","fur_simple_chest",
        "book_ric","book_row","book_shelf",
    },

    BANNED_STAT_PREFIXES = {
        "Gen_Door","Gen_Wood","Gen_Stone","Gen_LightSource","DEC_",
        "Gen_Container","Gen_Wood_Indestructible","LTS_","HAR_",
        "Chair_","Stool_","Bench_","Furniture_","Table_",
        "Shelf_","Cupboard_","Wardrobe_","Sarcophagus","Grave_",
        "Tomb_","Candle_","Candelab","Chandelier",
        "Brazier","Campfire","Fireplace","Anvil","Forge","Loom"
    },
    BANNED_STAT_KEYWORDS = {
        "chair","stool","bench","table_","_table","bed_","_bed","cot","hammock","bunk",
        "candelab","chandelier","brazier","campfire","fireplace","anvil","forge","loom",
        "whetstone","cauldron","furniture","shelf","cupboard","wardrobe","cabinet",
        "bookcase","dresser","nightstand","drawer","sign","banner","lantern_","torch_",
        "candle_","statue","monument","pillar","column","fence","gate","door","window",
        "crate_","_crate","barrel_","_barrel","sack_","_sack","basket",
        "citz_stool","citz_bench","citz_table","citz_chair",
        "poor_chair","poor_stool","poor_bench","rich_table","rich_chair",
        "camping_tent","ship_interior_lantern","lightsource","light_source"
    },
    UTILITY_KEYWORDS = {
        "key","magnifyingglass","magnifying_glass","shovel","bedroll","sleepingbag",
        "sleeping_bag","sleeping bag","tent","camping","lockpick","trapkit","trap_kit",
        "repair","shaft","craft_","hammer","pickaxe","fishing","bucket","rope"
    },

    PERSIST_OPENED_CONTAINERS = true, PERSIST_INTERVAL = 30000,
    PERSIST_FILE = "AutoLoot_Persistent.json",

    LOG_TO_FILE = false, LOG_FILE = "AutoLoot_Log.txt",
    LOG_FLUSH_INTERVAL = 10000, LOG_FILE_MAX_LINES = 1000, LOG_FILE_BUFFER_LINES = 5000,

    AUTO_DUMP_NEARBY = false, AUTO_DUMP_INTERVAL = 5000,
}

local LogBuffer = {}
local function PushBuffer(line)
    if not CONFIG.LOG_TO_FILE then return end
    table.insert(LogBuffer, line)
    if #LogBuffer > CONFIG.LOG_FILE_BUFFER_LINES then table.remove(LogBuffer, 1) end
end
local function Log(msg) local l = "[AutoLoot] " .. tostring(msg); Ext.Utils.Print(l); PushBuffer(l) end
local function Short(g) if not g then return "?" end return string.sub(tostring(g), 1, 8) end
local function FlushLogToFile()
    if not CONFIG.LOG_TO_FILE or #LogBuffer == 0 then return end
    if #LogBuffer > CONFIG.LOG_FILE_MAX_LINES then
        local s = #LogBuffer - CONFIG.LOG_FILE_MAX_LINES + 1
        local t = {}; for i = s, #LogBuffer do table.insert(t, LogBuffer[i]) end
        LogBuffer = t
    end
    pcall(function() Ext.IO.SaveFile(CONFIG.LOG_FILE, table.concat(LogBuffer, "\n")) end)
end

Log("=== v9.67 SCRIPT LOADED ===")

local SKILL_NORMAL="Shout_AutoLoot_Normal"; local SKILL_STEAL="Shout_AutoLoot_Steal"
local STATUS_NORMAL="AUTOLOOT_NORMAL"; local STATUS_STEAL="AUTOLOOT_STEAL"; local STATUS_SNEAK="SNEAKING"
local MODE_OFF=0; local MODE_NORMAL=1; local MODE_STEAL=2
local NULL_GUID = "NULL_00000000-0000-0000-0000-000000000000"

local PendingChecks = {}
local function ScheduleCheck(delayMs, cb) table.insert(PendingChecks, { at = Ext.Utils.MonotonicTime() + delayMs, fn = cb }) end
Ext.Events.Tick:Subscribe(function()
    if #PendingChecks == 0 then return end
    local now = Ext.Utils.MonotonicTime(); local i = 1
    while i <= #PendingChecks do
        local e = PendingChecks[i]
        if now >= e.at then table.remove(PendingChecks, i); pcall(e.fn) else i = i + 1 end
    end
end)

local AutoLoot = {
    State = {}, LastScan = {}, LastScanContainer = {}, LastScanItem = {}, LastScanCorpse = {},
    OpenedContainers = {}, SkillsGranted = {}, CachedPlayers = nil,
}
local DeadGuids = {}; local LuckCache = {}; local LuckTableCache = {}
local LastCrimeSuppress = {}; local AffectedNpcs = {}
local LastSkillUse = {}; local LastToggleUse = {}
local ContainerAttempts = {}; local EmptyContainers = {}
local ProcessedCharGuidsThisScan = {}; local LastHookProcess = {}; local LuckyCharmRolled = {}
local UncollectableItems = {}
local LevelContainers = {}; local LevelContainersReady = false
local lastLevelContainerRefresh = 0

local GenerateFullTreasure

local UUID_PATTERN = "([0-9a-fA-F]+%-[0-9a-fA-F]+%-[0-9a-fA-F]+%-[0-9a-fA-F]+%-[0-9a-fA-F]+)$"
local NormalizeCache = {}
local function NormalizeGuid(cg)
    if not cg or cg == "" then return cg end
    local cached = NormalizeCache[cg]
    if cached then return cached end
    local g = tostring(cg)
    if #g == 36 and g:match("^[0-9a-fA-F]+%-") then
        NormalizeCache[cg] = g
        return g
    end
    local uuid = g:match(UUID_PATTERN)
    if uuid then
        NormalizeCache[cg] = uuid
        return uuid
    end
    NormalizeCache[cg] = g
    return g
end

local function ExtractTemplateUuid(tmplName)
    if not tmplName or tmplName == "" then return nil end
    return tostring(tmplName):match(UUID_PATTERN)
end

local function IsUncollectable(g)
    local t = UncollectableItems[g]; if not t then return false end
    if (Ext.Utils.MonotonicTime() - t) > CONFIG.UNCOLLECTABLE_TTL then UncollectableItems[g] = nil; return false end
    return true
end
local function MarkUncollectable(g) UncollectableItems[g] = Ext.Utils.MonotonicTime() end

local function IsPersistentEmptyTemplate(guid)
    local tmpl = tostring(Osi.GetTemplate(guid) or "")
    if tmpl == "" then return false end
    for _, t in ipairs(CONFIG.PERSISTENT_EMPTY_TEMPLATES) do
        if tmpl == t then return true end
    end
    return false
end

local function SaveOpenedContainers()
    if not CONFIG.PERSIST_OPENED_CONTAINERS then return end
    local list = {}; for g, _ in pairs(AutoLoot.OpenedContainers) do table.insert(list, g) end
    local ok, json = pcall(function() return Ext.Json.Stringify({ version = 1, guids = list }) end)
    if not ok or not json then return end
    pcall(function() Ext.IO.SaveFile(CONFIG.PERSIST_FILE, json) end)
end
local function LoadOpenedContainers()
    if not CONFIG.PERSIST_OPENED_CONTAINERS then return end
    local ok, content = pcall(function() return Ext.IO.LoadFile(CONFIG.PERSIST_FILE) end)
    if not ok or not content or content == "" then return end
    local okP, data = pcall(function() return Ext.Json.Parse(content) end)
    if not okP or type(data) ~= "table" or type(data.guids) ~= "table" then return end
    local now = Ext.Utils.MonotonicTime()
    for _, g in ipairs(data.guids) do
        if type(g) == "string" and g ~= "" then AutoLoot.OpenedContainers[g] = now end
    end
end

local function IsNullGuid(g) return not g or g == "" or g == NULL_GUID end
local function IsDeadGuid(g)
    local t = DeadGuids[g]; if not t then return false end
    if (Ext.Utils.MonotonicTime() - t) > CONFIG.DEAD_GUID_TTL then DeadGuids[g] = nil; return false end
    return true
end
local function MarkDeadGuid(g) DeadGuids[g] = Ext.Utils.MonotonicTime() end

local function RefreshPlayerCache()
    local list = {}
    local ok, guids = pcall(Ext.Entity.GetAllCharacterGuids)
    if ok and guids then
        for _, g in pairs(guids) do
            local isP = false; pcall(function() isP = (Osi.CharacterIsPlayer(g) == 1) end)
            if isP then table.insert(list, g) end
        end
    end
    AutoLoot.CachedPlayers = list; return #list > 0
end
local function GetCachedPlayers() return AutoLoot.CachedPlayers or {} end
local function GetAnyActivePlayerGuid()
    pcall(RefreshPlayerCache)
    for _, g in ipairs(GetCachedPlayers()) do local m = AutoLoot.State[g]; if m and m ~= MODE_OFF then return g end end
    for g, m in pairs(AutoLoot.State) do if m and m ~= MODE_OFF then return g end end
    return nil
end

local function IsItemProxy(e)
    if not e then return false end
    local ok, s = pcall(function() return e.StatsId end)
    if not ok then return false end
    if type(s) ~= "string" or s == "" then return false end
    return true
end

local function GetContainerEntity(cg)
    if not cg or cg == "" then return nil, nil end
    local ok, it = pcall(Ext.Entity.GetItem, cg)
    if ok and it then return it, "item" end
    local ok2, go = pcall(Ext.Entity.GetGameObject, cg)
    if ok2 and go then return go, "go" end
    local norm = NormalizeGuid(cg)
    if norm ~= cg then
        local ok3, it2 = pcall(Ext.Entity.GetItem, norm)
        if ok3 and it2 then return it2, "item.norm" end
        local ok4, go2 = pcall(Ext.Entity.GetGameObject, norm)
        if ok4 and go2 then return go2, "go.norm" end
    end
    return nil, nil
end

local function GetContainerItemCount(cg)
    local ent = GetContainerEntity(cg)
    if ent and ent.GetInventoryItems then
        local ok, list = pcall(function() return ent:GetInventoryItems() end)
        if ok and type(list) == "table" and #list > 0 then return #list, list end
    end
    local norm = NormalizeGuid(cg)
    local ok, inv = pcall(function() return Osi.GetInventoryItems(norm) end)
    if ok and type(inv) == "table" and #inv > 0 then return #inv, inv end
    local ok2, inv2 = pcall(function() return Osi.GetInventoryItems(cg) end)
    if ok2 and type(inv2) == "table" then return #inv2, inv2 end
    return 0, {}
end

local function MarkContainerKnown(cg)
    local ent = GetContainerEntity(cg)
    if not ent then return false end
    local okA = pcall(function() ent.Known = true end)
    local okB = pcall(function() ent.IsContainer = true end)
    return okA or okB
end

local function SafeGetItemEntity(g)
    if not g or g == "" then return nil end
    if IsDeadGuid(g) then return nil end
    local ok, tmpl = pcall(Osi.GetTemplate, g)
    if not ok or not tmpl or tmpl == "" then MarkDeadGuid(g); return nil end
    local ok2, e = pcall(Ext.Entity.GetItem, g)
    if ok2 and e and IsItemProxy(e) then return e end
    local norm = NormalizeGuid(g)
    if norm ~= g then
        local ok3, e2 = pcall(Ext.Entity.GetItem, norm)
        if ok3 and e2 and IsItemProxy(e2) then return e2 end
    end
    local okGo, go = pcall(Ext.Entity.GetGameObject, g)
    if okGo and go then return go end
    if norm ~= g then
        local okGo2, go2 = pcall(Ext.Entity.GetGameObject, norm)
        if okGo2 and go2 then return go2 end
    end
    return nil
end
local function SafeGetCharacterEntity(g)
    if not g or g == "" then return nil end
    if IsDeadGuid(g) then return nil end
    local ok, e = pcall(Ext.Entity.GetCharacter, g)
    if not ok or not e then return nil end
    return e
end

local function SafeGetGameObjectEntity(g)
    if not g or g == "" then return nil end
    local ok, e = pcall(Ext.Entity.GetGameObject, g)
    if not ok or not e then return nil end
    return e
end

local function GetAnyTemplate(guid)
    local e = SafeGetItemEntity(guid)
    if e then
        local tmpl = nil
        pcall(function() tmpl = e.CurrentTemplate end)
        if tmpl then return tmpl, "item.CurrentTemplate" end
        pcall(function() tmpl = e.RootTemplate end)
        if tmpl then return tmpl, "item.RootTemplate" end
    end
    local go = SafeGetGameObjectEntity(guid)
    if go then
        local tmpl = nil
        pcall(function() tmpl = go.CurrentTemplate end)
        if tmpl then return tmpl, "go.CurrentTemplate" end
        pcall(function() tmpl = go.RootTemplate end)
        if tmpl then return tmpl, "go.RootTemplate" end
        pcall(function() tmpl = go.Template end)
        if tmpl then return tmpl, "go.Template" end
    end
    local name = tostring(Osi.GetTemplate(guid) or "")
    if name ~= "" then
        local tmpl = nil
        pcall(function() tmpl = Ext.Template.GetRootTemplate(name) end)
        if tmpl then return tmpl, "Ext.Template.GetRootTemplate" end
    end
    return nil, "nil"
end

local function HasUseAction(guid, actionType)
    local tmpl = GetAnyTemplate(guid)
    if not tmpl then return false end
    local actions = nil
    pcall(function() actions = tmpl.OnUsePeaceActions end)
    if type(actions) ~= "table" then return false end
    for _, action in ipairs(actions) do
        if action.Type == actionType then return true end
    end
    return false
end

local function IsContainerLike(entityGuid)
    if HasUseAction(entityGuid, "OpenClose") then return true end
    local ok, isCont = pcall(function() return Osi.ItemIsContainer(entityGuid) end)
    if ok and isCont == 1 then return true end
    local tmpl = tostring(Osi.GetTemplate(entityGuid) or ""):lower()
    if tmpl:find("^cont_") then return true end
    return false
end

local function MatchesKeywordSet(guid, keywords)
    if not keywords or #keywords == 0 then return false end
    local sId = ""
    local e = SafeGetItemEntity(guid)
    if e then pcall(function() sId = tostring(e.StatsId or ""):lower() end) end
    local tmpl = tostring(Osi.GetTemplate(guid) or ""):lower()
    local combined = sId .. " " .. tmpl
    for _, kw in ipairs(keywords) do
        local kwLower = tostring(kw):lower()
        if kwLower ~= "" and combined:find(kwLower, 1, true) then return true end
    end
    return false
end

local function IsPortableContainer(guid)
    if not guid or guid == "" then return false end
    local it = SafeGetItemEntity(guid)
    if not it then return false end
    local canPick = false
    pcall(function() canPick = (it.CanBePickedUp == true) end)
    if not canPick then return false end
    local isCont = false
    pcall(function() isCont = Osi.ItemIsContainer(guid) == 1 end)
    if not isCont then return false end
    if Osi.ItemIsInInventory(guid) == 1 then return false end
    local owner = Osi.ItemGetOwner(guid)
    if not IsNullGuid(owner) then
        local alive = false
        pcall(function() alive = (Osi.CharacterIsDead(owner) ~= 1) end)
        if alive then return false end
    end
    if MatchesKeywordSet(guid, CONFIG.PORTABLE_PICKUP_BLACKLIST) then return false end
    if #CONFIG.PORTABLE_PICKUP_WHITELIST > 0 then
        if not MatchesKeywordSet(guid, CONFIG.PORTABLE_PICKUP_WHITELIST) then return false end
    end
    return true
end

local function IsUsefulBarrel(sIdLower)
    if not sIdLower then return false end
    if not sIdLower:find("barrel", 1, true) then return false end
    for _, kw in ipairs(CONFIG.USEFUL_BARREL_KEYWORDS) do
        if sIdLower:find(kw, 1, true) then return true end
    end
    return false
end

local function ApplyStatusSafe(t, s, d, f)
    if not t or not s then return end
    pcall(function() Osi.ApplyStatus(t, s, d, f) end)
end
local function RemoveStatusSafe(t, s)
    if not t or not s then return end
    pcall(function() Osi.RemoveStatus(t, s) end)
end
local function IsSneaking(g) return Osi.HasActiveStatus(g, STATUS_SNEAK) == 1 end
local function RestoreSneaking(g) pcall(function() Osi.ApplyStatus(g, STATUS_SNEAK, -1.0, 0) end) end
local function TryRestoreSneakOnce(g) LastSkillUse[g] = nil; if IsSneaking(g) then return end; RestoreSneaking(g) end

local THEFT_CRIMES = { "Steal", "EmptyPocketNoticed", "PickPocketFailed" }
local function SetTheftCrimesEnabled(g, en)
    for _, c in ipairs(THEFT_CRIMES) do
        pcall(function() if en then Osi.CharacterEnableCrime(g, c) else Osi.CharacterDisableCrime(g, c) end end)
    end
end
local function CrimeSuppress(g)
    SetTheftCrimesEnabled(g, false)
    local px, py, pz = Osi.GetPosition(g); if not px then return end
    local ok, chars = pcall(Ext.Entity.GetCharacterGuidsAroundPosition, px, py, pz, 25.0)
    if not ok or not chars then return end
    for _, guid in pairs(chars) do
        if guid and guid ~= g and not AffectedNpcs[guid] then
            SetTheftCrimesEnabled(guid, false); AffectedNpcs[guid] = true
        end
    end
end
local function CrimeSuppressThrottled(g)
    local now = Ext.Utils.MonotonicTime()
    local last = LastCrimeSuppress[g] or 0
    if (now - last) < CONFIG.CRIME_SUPPRESS_INTERVAL then return end
    LastCrimeSuppress[g] = now; CrimeSuppress(g)
end
local function CrimeRestoreAll()
    for g, _ in pairs(AffectedNpcs) do SetTheftCrimesEnabled(g, true) end
    AffectedNpcs = {}
end

local function GetLuckyCharmLevel(g)
    local now = Ext.Utils.MonotonicTime()
    local c = LuckCache[g]; if c and (now - c.at) < CONFIG.LUCK_CACHE_TTL then return c.value end
    local lvl = 0
    local ch = SafeGetCharacterEntity(g)
    if ch and ch.Stats then
        local raw = ch.Stats.Luck
        if type(raw) == "number" and raw > 0 then lvl = raw end
    end
    LuckCache[g] = { value = lvl, at = now }; return lvl
end

local function DoesLuckTableExist(t)
    if not CONFIG.VALIDATE_LUCK_TABLES then return true end
    local cached = LuckTableCache[t]; if cached ~= nil then return cached end
    local ok, e = pcall(function() return Ext.Stats.TreasureTable.GetLegacy(t) end)
    local exists = ok and e ~= nil; LuckTableCache[t] = exists; return exists
end
local function GetPartyLuckTable(g)
    local best = 0
    local lvl = GetLuckyCharmLevel(g); if lvl > best then best = lvl end
    for _, pg in ipairs(GetCachedPlayers()) do
        if pg ~= g then local l = GetLuckyCharmLevel(pg); if l > best then best = l end end
    end
    if best <= 0 then return nil end
    for i = best, 1, -1 do
        local t = "Luck" .. i
        if DoesLuckTableExist(t) then return t end
    end
    return nil
end

local function IsUtilityItem(s) for _, kw in ipairs(CONFIG.UTILITY_KEYWORDS) do if s:find(kw, 1, true) then return true end end return false end
local function IsWhitelisted(s, t) for _, kw in ipairs(CONFIG.WHITELIST_KEYWORDS) do if s:find(kw, 1, true) then return true end if t:find(kw, 1, true) then return true end end return false end
local function IsBannedFurniture(sId, tmpl)
    if not sId or sId == "" then return false end
    local sIdL = sId:lower(); local tmplL = tostring(tmpl or ""):lower()
    if IsWhitelisted(sIdL, tmplL) then return false end
    if IsUsefulBarrel(sIdL) then return false end
    for _, kw in ipairs(CONFIG.UTILITY_KEYWORDS) do if sIdL:find(kw, 1, true) then return false end end
    for _, p in ipairs(CONFIG.BANNED_STAT_PREFIXES) do if sId:find("^" .. p) then return true end end
    local combined = sIdL .. " " .. tmplL
    for _, kw in ipairs(CONFIG.BANNED_STAT_KEYWORDS) do if combined:find(kw, 1, true) then return true end end
    return false
end
local FOOD_SUBSTRINGS = { "egg","flask","bottle","potion","food","drink","water","empty_flask","emptyflask","empty_bottle","emptybottle" }
local function IsFoodOrDrink(s)
    if s:find("^con_") then return true end
    if s:find("^food_") then return true end
    if s:find("^drink_") then return true end
    if s:find("^potion_") then return true end
    if s:find("^egg") then return true end
    if s:find("^flask") then return true end
    if s:find("^bottle") then return true end
    for _, kw in ipairs(FOOD_SUBSTRINGS) do if s:find(kw, 1, true) then return true end end
    return false
end
local function GetRarityRank(r) if not r then return 0 end return CONFIG.RARITY_RANK[r] or 0 end
local function MeetsMinRarity(r) return GetRarityRank(r) >= GetRarityRank(CONFIG.MIN_RARITY_TO_PICKUP) end

local IsValidPickupItem; local GetContainerContents; local CollectItem

local function TryNotify(g, n, r)
    if not CONFIG.NOTIFY_VALUABLE_ITEMS then return end
    if GetRarityRank(r) < GetRarityRank(CONFIG.MIN_RARITY_FOR_NOTIFY) then return end
    Log(string.format("Valuable loot: %s [%s] picked by %s", tostring(n), tostring(r), tostring(g)))
end
local function IsCharacterInAnimation(g)
    if not CONFIG.SKIP_DURING_ANIMATION then return false end
    if Osi.CharacterIsInCombat(g) == 1 then return true end
    return false
end
local function ItemInContainer(cg, ig, forceChar)
    if not cg or not ig then return false end
    if forceChar ~= nil then
        local list = GetContainerContents(cg, forceChar)
        for _, g in ipairs(list) do if g == ig then return true end end
        return false
    end
    local c1 = GetContainerContents(cg, false); for _, g in ipairs(c1) do if g == ig then return true end end
    local c2 = GetContainerContents(cg, true); for _, g in ipairs(c2) do if g == ig then return true end end
    return false
end

local function GetCharGold(g)
    if not g then return nil end
    local getters = {
        function() return Osi.CharacterGetGold(g) end,
        function() return Osi.GetGold(g) end,
        function() return Osi.PlayerGetGold(g) end,
        function() return Osi.GetPlayerGold(g) end,
        function() return Osi.GetInventoryGold(g) end,
    }
    for _, fn in ipairs(getters) do
        local ok, v = pcall(fn); if ok and type(v) == "number" then return v end
    end
    return nil
end
local function TryAddGold(g, amt)
    if not g or not amt or amt <= 0 then return false end
    local adders = {
        function() Osi.CharacterAddGold(g, amt) end,
        function() Osi.AddGold(g, amt) end,
        function() Osi.PlayerAddGold(g, amt) end,
        function() Osi.AddPlayerGold(g, amt) end,
        function() Osi.IncreaseGold(g, amt) end,
        function() Osi.AddInventoryGold(g, amt) end,
    }
    for _, fn in ipairs(adders) do local ok = pcall(fn); if ok then return true end end
    return false
end
local function IsGoldItem(s)
    if not s then return false end
    if s == "gold" then return true end
    if s:match("_gold$") then return true end
    if s:match("^gold_") then return true end
    if s:find("currency", 1, true) then return true end
    return false
end

local function MarkItemPickedUp(itemGuid)
    local ent = GetContainerEntity(itemGuid)
    if not ent then return end
    pcall(function() ent.Known = true end)
    pcall(function() ent.IsContainer = true end)
end

CollectItem = function(itemGuid, charGuid, mode, isFromContainer, containerGuid)
    if IsCharacterInAnimation(charGuid) then return false end
    local amount = Osi.ItemGetAmount(itemGuid) or 1; if amount <= 0 then amount = 1 end
    local item = SafeGetItemEntity(itemGuid)
    if not item then return false end
    if not IsItemProxy(item) then return false end
    local sId = tostring(item.StatsId or "?"); local sIdL = sId:lower()
    local isGold = IsGoldItem(sIdL)
    if not isFromContainer and Osi.ItemIsInInventory(itemGuid) == 1 then return true end

    local containerIsChar = false
    if isFromContainer and containerGuid then
        local isCont = false; pcall(function() isCont = Osi.ItemIsContainer(containerGuid) == 1 end)
        if isCont then containerIsChar = false else
            local okCh, ch = pcall(Ext.Entity.GetCharacter, containerGuid)
            containerIsChar = okCh and ch ~= nil
        end
    end

    local beforeInCont = false; local beforeInInv = 0
    if isFromContainer and containerGuid then beforeInCont = ItemInContainer(containerGuid, itemGuid, containerIsChar)
    else beforeInInv = Osi.ItemIsInInventory(itemGuid) or 0 end

    local goldBefore = nil; if isGold then goldBefore = GetCharGold(charGuid) end
    local clearOwner = (mode == MODE_STEAL) and 1 or 0
    local ok = pcall(function() Osi.ItemToInventory(itemGuid, charGuid, amount, 0, clearOwner) end)

    if isGold then
        local goldAfter = GetCharGold(charGuid)
        if goldBefore and goldAfter and goldAfter == goldBefore then
            if TryAddGold(charGuid, amount) then
                pcall(function() Osi.ItemRemove(itemGuid) end); ok = true
            end
        end
    end

    local afterInCont = false; local afterInInv = 0; local destroyed = false
    if isFromContainer and containerGuid then afterInCont = ItemInContainer(containerGuid, itemGuid, containerIsChar)
    else afterInInv = Osi.ItemIsInInventory(itemGuid) or 0 end
    pcall(function() destroyed = Osi.ItemIsDestroyed(itemGuid) == 1 end)

    local collected
    if isFromContainer and containerGuid then
        collected = ok and beforeInCont and (not afterInCont)
        if not collected and ok and beforeInCont and destroyed then collected = true end
    else
        collected = ok and (afterInInv == 1)
        if not collected and ok and beforeInInv == 0 and destroyed then collected = true end
    end
    if isGold and not collected and goldBefore and goldAfter and (goldAfter - goldBefore) > 0 then collected = true end

    if collected then MarkItemPickedUp(itemGuid) end

    local rarity = nil; pcall(function() rarity = item.Rarity end)
    if collected then TryNotify(charGuid, sId, rarity)
    else
        if isFromContainer and containerGuid and beforeInCont and afterInCont and ok then
            MarkUncollectable(itemGuid)
        end
    end
    return collected
end

GetContainerContents = function(entityGuid, isCharacter)
    local result, seen = {}, {}

    local function addItems(list)
        if not list then return end
        for _, g in ipairs(list) do
            if g and g ~= "" and not seen[g] then
                seen[g] = true
                table.insert(result, g)
            end
        end
    end

    local ent = isCharacter and SafeGetCharacterEntity(entityGuid) or GetContainerEntity(entityGuid)
    if ent and ent.GetInventoryItems then
        pcall(function() addItems(ent:GetInventoryItems()) end)
    end

    if #result == 0 then
        local norm = NormalizeGuid(entityGuid)
        pcall(function()
            local inv = Osi.GetInventoryItems(norm)
            if type(inv) == "table" then addItems(inv) end
        end)
    end

    if #result == 0 then
        pcall(function()
            local inv = Osi.GetInventoryItems(entityGuid)
            if type(inv) == "table" then addItems(inv) end
        end)
    end

    if #result == 0 and not isCharacter then
        local tmplName = tostring(Osi.GetTemplate(entityGuid) or "")
        local tmplUuid = ExtractTemplateUuid(tmplName)
        if tmplUuid and tmplUuid ~= entityGuid then
            pcall(function()
                local inv = Osi.GetInventoryItems(tmplUuid)
                if type(inv) == "table" and #inv > 0 then addItems(inv) end
            end)
        end
    end

    if #result == 0 and not isCharacter then
        local norm = NormalizeGuid(entityGuid)
        local tmplName = tostring(Osi.GetTemplate(entityGuid) or "")
        local tmplUuid = ExtractTemplateUuid(tmplName)
        pcall(function()
            local ok, allItems = pcall(Ext.Entity.GetAllItemGuids)
            if ok and allItems then
                for k, v in pairs(allItems) do
                    local g = (type(k) == "string" and #k >= 32) and k
                           or (type(v) == "string" and #v >= 32) and v
                           or nil
                    if g then
                        local owner = ""
                        pcall(function() owner = Osi.ItemGetOwner(g) or "" end)
                        if owner == entityGuid or owner == norm
                           or (tmplUuid and owner == tmplUuid) then
                            addItems({ g })
                        end
                    end
                end
            end
        end)
    end

    return result
end

local function ExtractFromContainer(cg, g, mode)
    local count = 0
    local contents = GetContainerContents(cg, false)

    if #contents == 0 then
        if not LuckyCharmRolled[cg] then
            LuckyCharmRolled[cg] = Ext.Utils.MonotonicTime()
            pcall(GenerateFullTreasure, cg, g)
        end
        MarkContainerKnown(cg)
        contents = GetContainerContents(cg, false)
    end

    for _, cg2 in ipairs(contents) do
        if IsValidPickupItem(cg2, g, mode, true) then
            if CollectItem(cg2, g, mode, true, cg) then count = count + 1 end
        end
    end
    return count
end

local function ExtractNearbyContainer(cg, g, mode)
    local tmpl = tostring(Osi.GetTemplate(cg) or ""):lower()
    local isHinted = false
    for _, kw in ipairs(CONFIG.NEARBY_TEMPLATE_HINTS) do
        if tmpl:find(kw, 1, true) then isHinted = true; break end
    end
    if not isHinted then return 0 end
    local px, py, pz = Osi.GetPosition(cg); if not px then return 0 end
    local ok, items = pcall(Ext.Entity.GetItemGuidsAroundPosition, px, py, pz, CONFIG.NEARBY_CONTAINER_RADIUS)
    if not ok or not items then return 0 end
    local count = 0
    for _, gi in pairs(items) do
        if gi ~= cg then
            if IsValidPickupItem(gi, g, mode, false) then
                if CollectItem(gi, g, mode, false, nil) then count = count + 1 end
            end
        end
    end
    return count
end

local function ExtractFromCharacter(tg, g, mode)
    local count = 0
    for _, gi in ipairs(GetContainerContents(tg, true)) do
        local ci = SafeGetItemEntity(gi)
        if ci and IsItemProxy(ci) then
            if IsValidPickupItem(gi, g, mode, true) then
                if CollectItem(gi, g, mode, true, tg) then count = count + 1 end
            end
        end
    end
    return count
end

IsValidPickupItem = function(guid, charGuid, mode, isFromContainer)
    if not guid or guid == "" then return false end
    if IsUncollectable(guid) then return false end
    local tmpl = Osi.GetTemplate(guid)
    if Osi.ItemIsDestroyed(guid) == 1 then return false end
    if not isFromContainer and Osi.ItemIsInInventory(guid) == 1 then return false end

    local item = SafeGetItemEntity(guid)
    if not item then
        if isFromContainer then return true end
        return false
    end
    if not IsItemProxy(item) then return false end

    local sId = tostring(item.StatsId or ""); local sIdL = sId:lower()
    local tmplL = tostring(tmpl or ""):lower()

    if IsGoldItem(sIdL) then return true end

    local isUsefulBarrel = IsUsefulBarrel(sIdL)

    if not isFromContainer and not isUsefulBarrel then
        local canPick = true; pcall(function() canPick = (item.CanBePickedUp ~= false) end)
        if not canPick then return false end
    end

    if not isFromContainer and CONFIG.PICKUP_PORTABLE_CONTAINERS and IsPortableContainer(guid) then
        return true
    end

    if not isFromContainer then
        local r = nil; pcall(function() r = item.Rarity end)
        if not MeetsMinRarity(r) then return false end
    end

    local isUtility = IsUtilityItem(sIdL)
    local isFood = IsFoodOrDrink(sIdL)

    if isFromContainer then return true end

    if Osi.ItemIsStoryItem(guid) == 1 and not isUtility and not isFood then
        if not (isUsefulBarrel and CONFIG.USEFUL_BARREL_IGNORE_STORY) then return false end
    end
    if isUsefulBarrel then return true end
    if not isUtility and not isFood then
        if sId == "" then return false end
        if IsBannedFurniture(sId, tmpl) then return false end
    end
    return true
end

local function IterateEntitiesNear(px, py, pz, radius, cb)
    local okCh, chars = pcall(Ext.Entity.GetCharacterGuidsAroundPosition, px, py, pz, radius)
    if okCh and chars then for _, g in pairs(chars) do cb(g, { isCharacter = true }) end end
    local okIt, items = pcall(Ext.Entity.GetItemGuidsAroundPosition, px, py, pz, radius)
    if okIt and items then
        for _, g in pairs(items) do
            if not IsDeadGuid(g) then
                local isCont = IsContainerLike(g)
                cb(g, { isItem = true, isContainer = isCont })
            end
        end
    end
end

local function IsContainerOpened(g)
    local t = AutoLoot.OpenedContainers[g]; if not t then return false end
    if (Ext.Utils.MonotonicTime() - t) > CONFIG.OPENED_CONTAINER_TTL then AutoLoot.OpenedContainers[g] = nil; return false end
    return true
end
local function MarkContainerOpened(g) AutoLoot.OpenedContainers[g] = Ext.Utils.MonotonicTime() end
local function IsEmptyMarked(g)
    local t = EmptyContainers[g]; if not t then return false end
    if (Ext.Utils.MonotonicTime() - t) > CONFIG.EMPTY_RECHECK_TTL then EmptyContainers[g] = nil; ContainerAttempts[g] = nil; return false end
    return true
end
local function MarkEmpty(g) EmptyContainers[g] = Ext.Utils.MonotonicTime(); ContainerAttempts[g] = nil end

local LEVEL_CONTAINER_APIS = {
    { name = "GetAllItemGuids", fn = function() return Ext.Entity.GetAllItemGuids() end },
}

local function ExtractGuid(k, v)
    if type(k) == "string" and #k >= 32 then return k end
    if type(v) == "string" and #v >= 32 then return v end
    if type(v) == "table" then
        if type(v.GetGuid) == "function" then local ok, g = pcall(function() return v:GetGuid() end)
            if ok and type(g) == "string" and #g >= 32 then return g end end
        if type(v.Guid) == "string" and #v.Guid >= 32 then return v.Guid end
    end
    return nil
end

local function RefreshLevelContainers(force)
    local now = Ext.Utils.MonotonicTime()
    if not force and LevelContainersReady
       and (now - lastLevelContainerRefresh) < CONFIG.LEVEL_CONTAINER_REFRESH_INTERVAL then return end
    lastLevelContainerRefresh = now
    LevelContainers = {}

    local apisUsed = {}; local candidates = {}
    for _, entry in ipairs(LEVEL_CONTAINER_APIS) do
        local ok, res = pcall(entry.fn)
        if ok and type(res) == "table" then
            table.insert(apisUsed, entry.name)
            for k, v in pairs(res) do
                local guid = ExtractGuid(k, v)
                if guid and not IsDeadGuid(guid) then candidates[guid] = true end
            end
        end
    end

    if #apisUsed == 0 then
        LevelContainersReady = true; return
    end

    for guid, _ in pairs(candidates) do
        local isCont = false; pcall(function() isCont = Osi.ItemIsContainer(guid) == 1 end)
        if not isCont then
            if HasUseAction(guid, "OpenClose") then
                isCont = true
            else
                local tmpl = ""
                pcall(function() tmpl = tostring(Osi.GetTemplate(guid) or ""):lower() end)
                if tmpl ~= "" then
                    if tmpl:find("^cont_") then isCont = true
                    else
                        for _, kw in ipairs(CONFIG.CONTAINER_TEMPLATE_HINTS) do
                            if tmpl:find(kw, 1, true) then isCont = true; break end
                        end
                    end
                end
            end
        end
        if isCont then
            local px, py, pz = Osi.GetPosition(guid)
            if px then LevelContainers[guid] = { x = px, y = py, z = pz } end
        end
    end
    LevelContainersReady = true
end

GenerateFullTreasure = function(guid, charGuid)
    if IsUncollectable(guid) then return false end

    local tmpl = GetAnyTemplate(guid)
    if not tmpl then return false end

    local alreadyGen = false
    local e = GetContainerEntity(guid)
    if e then pcall(function() alreadyGen = (e.TreasureGenerated == true) end) end
    if alreadyGen then return false end

    local level = -1
    pcall(function() level = tmpl.TreasureLevel or -1 end)
    local usePartyLvl = false
    pcall(function() usePartyLvl = (tmpl.UsePartyLevelForTreasureLevel == true) end)
    if usePartyLvl or level < 1 then
        local best = 0
        for _, pg in ipairs(GetCachedPlayers()) do
            local ch = SafeGetCharacterEntity(pg)
            if ch and ch.Stats and type(ch.Stats.Level) == "number" and ch.Stats.Level > best then
                best = ch.Stats.Level
            end
        end
        if best > 0 then level = best end
    end

    local beforeCount = GetContainerItemCount(guid)
    local genCount = 0

    local singleTable = nil
    pcall(function() singleTable = tmpl.TreasureTable end)
    local hasTreasuresArray = false
    pcall(function()
        hasTreasuresArray = type(tmpl.Treasures) == "table" and #tmpl.Treasures > 0
    end)
    if type(singleTable) == "string" and singleTable ~= "" and not hasTreasuresArray then
        pcall(function() Osi.GenerateTreasure(guid, singleTable, level, charGuid) end)
        genCount = genCount + 1
    end

    local treasures = nil
    pcall(function() treasures = tmpl.Treasures end)
    if type(treasures) == "table" then
        for _, tID in ipairs(treasures) do
            if tID and tID ~= "" then
                pcall(function() Osi.GenerateTreasure(guid, tID, level, charGuid) end)
                genCount = genCount + 1
            end
        end
    end

    local lt = GetPartyLuckTable(charGuid)
    if lt then
        pcall(function() Osi.GenerateTreasure(guid, lt, level, charGuid) end)
        genCount = genCount + 1
    end

    local afterCount = GetContainerItemCount(guid)
    if afterCount > beforeCount or genCount > 0 then
        MarkContainerKnown(guid)
        pcall(function() if e then e.TreasureGenerated = true end end)
    end

    return genCount > 0 or afterCount > beforeCount
end

local function ProcessContainer(guid, charGuid, mode)
    if IsContainerOpened(guid) then return 0 end
    if IsEmptyMarked(guid) then return 0 end

    local workGuid = NormalizeGuid(guid)
    local isPortable = CONFIG.PICKUP_PORTABLE_CONTAINERS and IsPortableContainer(workGuid)

    local lockedBefore = false; pcall(function() lockedBefore = Osi.ItemIsLocked(workGuid) == 1 end)
    if lockedBefore then
        local shouldUnlock = false
        if mode == MODE_STEAL then shouldUnlock = true
        elseif mode == MODE_NORMAL and CONFIG.UNLOCK_IN_NORMAL_MODE then shouldUnlock = true end
        if shouldUnlock then pcall(function() Osi.ItemUnLock(workGuid, charGuid) end) end
    end
    local lockedAfter = false; pcall(function() lockedAfter = Osi.ItemIsLocked(workGuid) == 1 end)
    if lockedAfter then MarkContainerOpened(workGuid); return 0 end

    pcall(function() Osi.ItemOpen(workGuid, charGuid) end)
    MarkContainerKnown(workGuid)

    local extracted = ExtractFromContainer(workGuid, charGuid, mode)
    if extracted == 0 and workGuid ~= guid then
        extracted = ExtractFromContainer(guid, charGuid, mode)
    end

    if extracted == 0 then
        local nearby = ExtractNearbyContainer(workGuid, charGuid, mode)
        if nearby > 0 then extracted = nearby; ContainerAttempts[workGuid] = nil end
    end

    if extracted == 0 then
        local sg = workGuid; local sc = charGuid; local sm = mode
        for _, d in ipairs({ CONFIG.OPEN_RECHECK_DELAY, CONFIG.OPEN_RECHECK_DELAY * 3 }) do
            ScheduleCheck(d, function()
                if IsContainerOpened(sg) or IsEmptyMarked(sg) then return end
                MarkContainerKnown(sg)
                local late = ExtractFromContainer(sg, sc, sm)
                if late > 0 then
                    MarkContainerOpened(sg); ContainerAttempts[sg] = nil; EmptyContainers[sg] = nil
                end
            end)
        end
    end

    local pickedUp = false
    local shouldTryPickup = false
    if isPortable and extracted > 0 then shouldTryPickup = true end
    if CONFIG.PICKUP_USEFUL_BARRELS then
        local ci = SafeGetItemEntity(workGuid)
        if ci then
            local cs = ""; pcall(function() cs = tostring(ci.StatsId or ""):lower() end)
            if IsUsefulBarrel(cs) then shouldTryPickup = true end
        end
    end

    if shouldTryPickup then
        if IsValidPickupItem(workGuid, charGuid, mode, false) then
            if CollectItem(workGuid, charGuid, mode, false, nil) then pickedUp = true end
        end
    end

    if extracted > 0 or pickedUp then
        MarkContainerOpened(workGuid); ContainerAttempts[workGuid] = nil; EmptyContainers[workGuid] = nil
    else
        local n = (ContainerAttempts[workGuid] or 0) + 1; ContainerAttempts[workGuid] = n
        if n >= CONFIG.EMPTY_RECHECK_ATTEMPTS then
            if IsPersistentEmptyTemplate(workGuid) then
                ContainerAttempts[workGuid] = 0
            else
                MarkEmpty(workGuid)
            end
        end
    end
    return extracted
end

local function OnContainerOpenedDelayed(cg)
    if IsContainerOpened(cg) then return 0 end
    local g = GetAnyActivePlayerGuid()
    if not g then return 0 end
    local mode = AutoLoot.State[g] or MODE_OFF
    if mode == MODE_OFF then return 0 end

    local normGuid = NormalizeGuid(cg)
    MarkContainerKnown(normGuid)

    local extracted = ExtractFromContainer(normGuid, g, mode)
    if extracted == 0 and normGuid ~= cg then
        extracted = ExtractFromContainer(cg, g, mode)
    end
    if extracted == 0 then
        local nearby = ExtractNearbyContainer(normGuid, g, mode)
        if nearby > 0 then extracted = nearby end
    end

    if CONFIG.PICKUP_USEFUL_BARRELS then
        local ci = SafeGetItemEntity(normGuid)
        if ci then
            local cs = ""; pcall(function() cs = tostring(ci.StatsId or ""):lower() end)
            if IsUsefulBarrel(cs) then
                if IsValidPickupItem(normGuid, g, mode, false) then
                    if CollectItem(normGuid, g, mode, false, nil) then
                        MarkContainerOpened(normGuid)
                        return extracted + 1
                    end
                end
            end
        end
    end

    if extracted > 0 then
        MarkContainerOpened(normGuid); ContainerAttempts[normGuid] = nil; EmptyContainers[normGuid] = nil
    end
    return extracted
end

local function OnContainerOpened(cg)
    if not cg or cg == "" then return end
    local now = Ext.Utils.MonotonicTime()
    local last = LastHookProcess[cg] or 0
    if (now - last) < CONFIG.HOOK_DEBOUNCE then return end
    LastHookProcess[cg] = now

    local normGuid = NormalizeGuid(cg)
    EmptyContainers[cg] = nil; ContainerAttempts[cg] = nil
    if normGuid ~= cg then
        EmptyContainers[normGuid] = nil; ContainerAttempts[normGuid] = nil
    end

    local isCont = false; pcall(function() isCont = Osi.ItemIsContainer(cg) == 1 end)
    if not isCont and normGuid ~= cg then
        pcall(function() isCont = Osi.ItemIsContainer(normGuid) == 1 end)
    end
    if not isCont then
        local tmpl = tostring(Osi.GetTemplate(cg) or ""):lower()
        for _, kw in ipairs(CONFIG.CONTAINER_TEMPLATE_HINTS) do
            if tmpl:find(kw, 1, true) then isCont = true; break end
        end
    end
    if not isCont then return end

    for _, delay in ipairs(CONFIG.HOOK_RETRY_DELAYS) do
        ScheduleCheck(delay, function()
            if IsContainerOpened(cg) then return end
            OnContainerOpenedDelayed(cg)
        end)
    end
end

Ext.Osiris.RegisterListener("ItemOpened", 1, "after", function(g) OnContainerOpened(g) end)
Ext.Osiris.RegisterListener("ItemOpened", 2, "after", function(a, b)
    local c1 = false; pcall(function() c1 = Osi.ItemIsContainer(a) == 1 end)
    if c1 then OnContainerOpened(a) else
        local c2 = false; pcall(function() c2 = Osi.ItemIsContainer(b) == 1 end)
        if c2 then OnContainerOpened(b) end
    end
end)

local function RunScan(charGuid, parts)
    local mode = AutoLoot.State[charGuid] or MODE_OFF
    if mode == MODE_OFF then return end
    local inC = false; pcall(function() inC = (Osi.CharacterIsInCombat(charGuid) == 1) end); if inC then return end
    local isD = false; pcall(function() isD = (Osi.CharacterIsDead(charGuid) == 1) end); if isD then return end
    if mode == MODE_STEAL then CrimeSuppressThrottled(charGuid) end
    local px, py, pz = Osi.GetPosition(charGuid); if not px or not py or not pz then return end

    local doCont = (parts == nil) or parts.containers
    local doItems = (parts == nil) or parts.items
    local doCorpses = (parts == nil) or parts.corpses

    local looted = 0
    ProcessedCharGuidsThisScan = {}
    local seenContainers = {}

    IterateEntitiesNear(px, py, pz, CONFIG.RADIUS, function(guid, info)
        if info.isCharacter then
            if not doCorpses then return end
            local isDeadChar = false; pcall(function() isDeadChar = (Osi.CharacterIsDead(guid) == 1) end)
            if isDeadChar then
                local ch = SafeGetCharacterEntity(guid)
                if ch then
                    ProcessedCharGuidsThisScan[guid] = true
                    local okEx, added = pcall(ExtractFromCharacter, guid, charGuid, mode)
                    if okEx and type(added) == "number" then looted = looted + added end
                end
            end
            return
        end
        if info.isContainer then
            if not doCont then return end
            seenContainers[guid] = true
            local canLoot = true
            if mode == MODE_NORMAL and not CONFIG.ALLOW_OWNED_CONTAINERS_IN_NORMAL then
                local owner = Osi.ItemGetOwner(guid)
                if not IsNullGuid(owner) and owner ~= charGuid then
                    if Osi.CharacterIsDead(owner) ~= 1 then canLoot = false end
                end
            end
            if canLoot then looted = looted + ProcessContainer(guid, charGuid, mode) end
            return
        end
        if info.isItem then
            if not doItems then return end
            if not CONFIG.PROCESS_CORPSES_AS_ITEMS and ProcessedCharGuidsThisScan[guid] then return end
            if IsValidPickupItem(guid, charGuid, mode, false) then
                if CollectItem(guid, charGuid, mode, false, nil) then looted = looted + 1 end
            end
            return
        end
    end)

    if doCont then
        RefreshLevelContainers(false)
        local r2 = CONFIG.RADIUS * CONFIG.RADIUS
        for guid, pos in pairs(LevelContainers) do
            if not seenContainers[guid] and not IsDeadGuid(guid) then
                local dx, dy, dz = pos.x - px, pos.y - py, pos.z - pz
                if dx * dx + dy * dy + dz * dz <= r2 then
                    local canLoot = true
                    if mode == MODE_NORMAL and not CONFIG.ALLOW_OWNED_CONTAINERS_IN_NORMAL then
                        local owner = Osi.ItemGetOwner(guid)
                        if not IsNullGuid(owner) and owner ~= charGuid then
                            if Osi.CharacterIsDead(owner) ~= 1 then canLoot = false end
                        end
                    end
                    if canLoot then looted = looted + ProcessContainer(guid, charGuid, mode) end
                    seenContainers[guid] = true
                end
            end
        end
    end
end

local function SetAuraMode(charGuid, targetMode)
    local ok, err = pcall(function()
        local cur = AutoLoot.State[charGuid] or MODE_OFF
        if cur == targetMode then
            AutoLoot.State[charGuid] = MODE_OFF
            RemoveStatusSafe(charGuid, STATUS_NORMAL); RemoveStatusSafe(charGuid, STATUS_STEAL)
            CrimeRestoreAll(); SetTheftCrimesEnabled(charGuid, true)
            LastCrimeSuppress[charGuid] = nil
            Log(Short(charGuid) .. " -> OFF"); return
        end
        AutoLoot.State[charGuid] = targetMode
        RemoveStatusSafe(charGuid, STATUS_NORMAL); RemoveStatusSafe(charGuid, STATUS_STEAL)
        AutoLoot.OpenedContainers = {}; ContainerAttempts = {}; EmptyContainers = {}
        UncollectableItems = {}; LastCrimeSuppress[charGuid] = nil
        LastHookProcess = {}
        AutoLoot.LastScan = {}
        AutoLoot.LastScanContainer = {}; AutoLoot.LastScanItem = {}; AutoLoot.LastScanCorpse = {}
        if targetMode == MODE_NORMAL then
            CrimeRestoreAll(); SetTheftCrimesEnabled(charGuid, true)
            ApplyStatusSafe(charGuid, STATUS_NORMAL, -1.0, 1)
        else
            CrimeSuppress(charGuid); ApplyStatusSafe(charGuid, STATUS_STEAL, -1.0, 1)
        end
    end)
    if not ok then Log("SetAuraMode error: " .. tostring(err)); return end

    pcall(RunScan, charGuid, nil)
    for _, delay in ipairs({ 500, 1500, 3000, 5000 }) do
        ScheduleCheck(delay, function()
            if (AutoLoot.State[charGuid] or MODE_OFF) == MODE_OFF then return end
            pcall(RunScan, charGuid, nil)
        end)
    end
end

local function GrantSkillsToPlayer(g)
    if not g or g == "" then return false end
    if AutoLoot.SkillsGranted[g] then return true end
    local hN = Osi.CharacterHasSkill(g, SKILL_NORMAL); local hS = Osi.CharacterHasSkill(g, SKILL_STEAL)
    if hN == 0 then Osi.CharacterAddSkill(g, SKILL_NORMAL, 0) end
    if hS == 0 then Osi.CharacterAddSkill(g, SKILL_STEAL, 0) end
    local okN = Osi.CharacterHasSkill(g, SKILL_NORMAL) == 1; local okS = Osi.CharacterHasSkill(g, SKILL_STEAL) == 1
    if okN and okS then AutoLoot.SkillsGranted[g] = true; return true end
    return false
end

local function SetupPlayer(g)
    if not GrantSkillsToPlayer(g) then return end
    if Osi.HasActiveStatus(g, STATUS_NORMAL) == 1 then
        AutoLoot.State[g] = MODE_NORMAL; SetTheftCrimesEnabled(g, true)
    elseif Osi.HasActiveStatus(g, STATUS_STEAL) == 1 then
        AutoLoot.State[g] = MODE_STEAL; CrimeSuppress(g)
        RemoveStatusSafe(g, STATUS_STEAL); ApplyStatusSafe(g, STATUS_STEAL, -1.0, 1)
    else
        AutoLoot.State[g] = MODE_OFF; SetTheftCrimesEnabled(g, true)
    end
end

local function EnableAllCrimesEverywhere()
    local ok, guids = pcall(Ext.Entity.GetAllCharacterGuids); if not ok or not guids then return end
    for _, g in pairs(guids) do pcall(function() Osi.CharacterEnableAllCrimes(g) end) end
end

local function SyncAllPlayers()
    EnableAllCrimesEverywhere()
    AutoLoot.LastScan = {}; AutoLoot.LastScanContainer = {}; AutoLoot.LastScanItem = {}; AutoLoot.LastScanCorpse = {}
    AutoLoot.SkillsGranted = {}
    CrimeRestoreAll(); AffectedNpcs = {}; LastCrimeSuppress = {}
    LuckCache = {}; LuckTableCache = {}
    ContainerAttempts = {}; EmptyContainers = {}; UncollectableItems = {}
    LastHookProcess = {}
    NormalizeCache = {}
    LevelContainers = {}; LevelContainersReady = false; lastLevelContainerRefresh = 0
    LoadOpenedContainers()
    if not RefreshPlayerCache() then Log("SyncAllPlayers: player cache is empty"); return end
    local n = 0
    for _, g in ipairs(GetCachedPlayers()) do n = n + 1; SetupPlayer(g) end
    Log("SyncAllPlayers: processed " .. n .. " player(s)")
end

Ext.Osiris.RegisterListener("CharacterUsedSkill", 4, "after", function(g, sid, _, _)
    if sid ~= SKILL_NORMAL and sid ~= SKILL_STEAL then return end
    local now = Ext.Utils.MonotonicTime()
    local last = LastToggleUse[g] or 0
    if (now - last) < CONFIG.TOGGLE_DEBOUNCE then return end
    LastToggleUse[g] = now; LastSkillUse[g] = now
    if sid == SKILL_NORMAL then SetAuraMode(g, MODE_NORMAL); Log(Short(g) .. " -> NORMAL")
    elseif sid == SKILL_STEAL then SetAuraMode(g, MODE_STEAL); Log(Short(g) .. " -> STEAL") end
end)

Ext.Osiris.RegisterListener("StatusRemoved", 3, "after", function(g, sid, _)
    if sid ~= STATUS_SNEAK then return end
    local last = LastSkillUse[g]; if not last then return end
    if (Ext.Utils.MonotonicTime() - last) > CONFIG.STEALTH_WINDOW then LastSkillUse[g] = nil; return end
    TryRestoreSneakOnce(g)
end)

Ext.Events.Tick:Subscribe(function()
    local now = Ext.Utils.MonotonicTime()
    for g, last in pairs(LastSkillUse) do
        if (now - last) > CONFIG.STEALTH_WINDOW then LastSkillUse[g] = nil end
    end
end)

Ext.Osiris.RegisterListener("CharacterDied", 1, "after", function(g)
    AutoLoot.SkillsGranted[g] = nil; LuckCache[g] = nil
    if AutoLoot.State[g] and AutoLoot.State[g] ~= MODE_OFF then
        AutoLoot.State[g] = MODE_OFF
        RemoveStatusSafe(g, STATUS_NORMAL); RemoveStatusSafe(g, STATUS_STEAL)
        CrimeRestoreAll()
    end
end)

Ext.Osiris.RegisterListener("SavegameLoaded", 4, "after", function() SyncAllPlayers() end)
Ext.Osiris.RegisterListener("RegionStarted", 1, "after", function() SyncAllPlayers() end)
Ext.Osiris.RegisterListener("SessionLoaded", 1, "after", function() SyncAllPlayers() end)
Ext.Osiris.RegisterListener("GameStarted", 1, "after", function() SyncAllPlayers() end)
Ext.Osiris.RegisterListener("CharacterCreationDone", 1, "after", function() SyncAllPlayers() end)

local lastSkillPoll = 0
Ext.Events.Tick:Subscribe(function()
    local now = Ext.Utils.MonotonicTime()
    if (now - lastSkillPoll) < 2000 then return end
    lastSkillPoll = now
    if not AutoLoot.CachedPlayers or #AutoLoot.CachedPlayers == 0 then pcall(RefreshPlayerCache) end
    for _, g in ipairs(GetCachedPlayers()) do
        if g and not AutoLoot.SkillsGranted[g] then
            if GrantSkillsToPlayer(g) then
                if not AutoLoot.State[g] then SetupPlayer(g) end
            end
        end
    end
end)

Ext.Events.Tick:Subscribe(function()
    local now = Ext.Utils.MonotonicTime()
    for g, mode in pairs(AutoLoot.State) do
        if mode ~= MODE_OFF then
            if CONFIG.USE_SPLIT_SCAN then
                local parts = {}; local any = false
                if (now - (AutoLoot.LastScanContainer[g] or 0)) >= CONFIG.SCAN_INTERVAL_CONTAINER then
                    parts.containers = true; AutoLoot.LastScanContainer[g] = now; any = true end
                if (now - (AutoLoot.LastScanItem[g] or 0)) >= CONFIG.SCAN_INTERVAL_ITEM then
                    parts.items = true; AutoLoot.LastScanItem[g] = now; any = true end
                if (now - (AutoLoot.LastScanCorpse[g] or 0)) >= CONFIG.SCAN_INTERVAL_CORPSE then
                    parts.corpses = true; AutoLoot.LastScanCorpse[g] = now; any = true end
                if any then
                    local ok, err = pcall(RunScan, g, parts)
                    if not ok then Log("RunScan(split) error: " .. tostring(err)) end
                end
            else
                local last = AutoLoot.LastScan[g] or 0
                if (now - last) >= CONFIG.SCAN_INTERVAL then
                    AutoLoot.LastScan[g] = now
                    local ok, err = pcall(RunScan, g, nil)
                    if not ok then Log("RunScan error: " .. tostring(err)) end
                end
            end
        end
    end
end)

local lastCacheCleanup = 0
Ext.Events.Tick:Subscribe(function()
    local now = Ext.Utils.MonotonicTime()
    if (now - lastCacheCleanup) < 60000 then return end
    lastCacheCleanup = now
    for g, t in pairs(AutoLoot.OpenedContainers) do if (now - t) > CONFIG.OPENED_CONTAINER_TTL then AutoLoot.OpenedContainers[g] = nil end end
    for g, t in pairs(DeadGuids) do if (now - t) > CONFIG.DEAD_GUID_TTL then DeadGuids[g] = nil end end
    for g, c in pairs(LuckCache) do if (now - c.at) > CONFIG.LUCK_CACHE_TTL * 5 then LuckCache[g] = nil end end
    for g, t in pairs(EmptyContainers) do if (now - t) > CONFIG.EMPTY_RECHECK_TTL then EmptyContainers[g] = nil end end
    for g, t in pairs(LastHookProcess) do if (now - t) > 10000 then LastHookProcess[g] = nil end end
    for g, t in pairs(LuckyCharmRolled) do if (now - t) > 300000 then LuckyCharmRolled[g] = nil end end
    for g, t in pairs(UncollectableItems) do if (now - t) > CONFIG.UNCOLLECTABLE_TTL then UncollectableItems[g] = nil end end
    for k in pairs(NormalizeCache) do NormalizeCache[k] = nil end
end)

local lastPersist = 0
Ext.Events.Tick:Subscribe(function()
    if not CONFIG.PERSIST_OPENED_CONTAINERS then return end
    local now = Ext.Utils.MonotonicTime()
    if (now - lastPersist) < CONFIG.PERSIST_INTERVAL then return end
    lastPersist = now; SaveOpenedContainers()
end)

local lastLogFlush = 0
Ext.Events.Tick:Subscribe(function()
    if not CONFIG.LOG_TO_FILE then return end
    local now = Ext.Utils.MonotonicTime()
    if (now - lastLogFlush) < CONFIG.LOG_FLUSH_INTERVAL then return end
    lastLogFlush = now; FlushLogToFile()
end)

Log("=== v9.67 INIT COMPLETE ===")
Log("RADIUS=" .. CONFIG.RADIUS
    .. " PORTABLE_PICKUP=" .. tostring(CONFIG.PICKUP_PORTABLE_CONTAINERS)
    .. " USEFUL_BARRELS=" .. tostring(CONFIG.PICKUP_USEFUL_BARRELS)
    .. " TOGGLE_DEBOUNCE=" .. CONFIG.TOGGLE_DEBOUNCE .. "ms")