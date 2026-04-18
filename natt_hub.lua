-- [[ NattHUB | Sailor Piece ]]
-- Optimized & De-Duplicated Architecture
-- Created by Antigravity (Google DeepMind)

---@diagnostic disable: undefined-global
---@diagnostic disable: deprecated

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- [[ CONFIGURATION ]]
local Config = {
    Title = "NattHUB | Sailor Piece",
    Icon = "solar:planet-3-bold-duotone",
    LogoID = "rbxassetid://117953684635635",
    Version = "3.1.0",
    Folder = "NattHUB_Configs",
    Author = "by Natt Dev"
}

-- [[ DATA MODELS ]]
local QuestData = {
    { Min = 0,     Max = 99,    NPC = "QuestNPC1" },
    { Min = 100,   Max = 249,   NPC = "QuestNPC2" },
    { Min = 250,   Max = 499,   NPC = "QuestNPC3" },
    { Min = 500,   Max = 749,   NPC = "QuestNPC4" },
    { Min = 750,   Max = 999,   NPC = "QuestNPC5" },
    { Min = 1000,  Max = 1499,  NPC = "QuestNPC6" },
    { Min = 1500,  Max = 1999,  NPC = "QuestNPC7" },
    { Min = 2000,  Max = 2999,  NPC = "QuestNPC8" },
    { Min = 3000,  Max = 3999,  NPC = "QuestNPC9" },
    { Min = 4000,  Max = 5000,  NPC = "QuestNPC10" },
    { Min = 5001,  Max = 6250,  NPC = "QuestNPC11" },
    { Min = 6251,  Max = 7000,  NPC = "QuestNPC12" },
    { Min = 7001,  Max = 8000,  NPC = "QuestNPC13" },
    { Min = 8001,  Max = 9000,  NPC = "QuestNPC14" },
    { Min = 9001,  Max = 10000, NPC = "QuestNPC15" },
    { Min = 10001, Max = 10750, NPC = "QuestNPC16" },
    { Min = 10751, Max = 11500, NPC = "QuestNPC17" },
    { Min = 11501, Max = 12000, NPC = "QuestNPC18" },
    { Min = 12001, Max = 99999, NPC = "QuestNPC19" }
}

local MobMapping = {
    QuestNPC1 = { "Thief1", "Thief2", "Thief3", "Thief4", "Thief5" },
    QuestNPC2 = "ThiefBoss",
    QuestNPC3 = { "Monkey1", "Monkey2", "Monkey3", "Monkey4", "Monkey5" },
    QuestNPC4 = "MonkeyBoss",
    QuestNPC5 = { "DesertBandit1", "DesertBandit2", "DesertBandit3", "DesertBandit4", "DesertBandit5" },
    QuestNPC6 = "DesertBoss",
    QuestNPC7 = { "FrostRogue1", "FrostRogue2", "FrostRogue3", "FrostRogue4", "FrostRogue5" },
    QuestNPC8 = "SnowBoss",
    QuestNPC9 = { "Sorcerer1", "Sorcerer2", "Sorcerer3", "Sorcerer4", "Sorcerer5" },
    QuestNPC10 = "PandaMiniBoss",
    QuestNPC11 = { "Hollow1", "Hollow2", "Hollow3", "Hollow4", "Hollow5" },
    QuestNPC12 = { "StrongSorcerer1", "StrongSorcerer2", "StrongSorcerer3", "StrongSorcerer4", "StrongSorcerer5" },
    QuestNPC13 = { "Curse1", "Curse2", "Curse3", "Curse4", "Curse5" },
    QuestNPC14 = { "Slime1", "Slime2", "Slime3", "Slime4", "Slime5" },
    QuestNPC15 = { "AcademyTeacher1", "AcademyTeacher2", "AcademyTeacher3", "AcademyTeacher4", "AcademyTeacher5" },
    QuestNPC16 = { "Swordsman1", "Swordsman1", "Swordsman3", "Swordsman4", "Swordsman5" },
    QuestNPC17 = { "Quincy1", "Quincy2", "Quincy3", "Quincy4", "Quincy5" },
    QuestNPC18 = { "Ninja1", "Ninja2", "Ninja3", "Ninja4", "Ninja5" },
    QuestNPC19 = { "ArenaFighter1", "ArenaFighter2", "ArenaFighter3", "ArenaFighter4", "ArenaFighter5" }
}

-- [[ STATE ]]
local AutoFarmEnabled = false
local AutoStatsEnabled = false
local SelectedStat = "Melee"
local AllocateAmount = 1
local BotStatus = "Ready"

-- [[ UI ELEMENTS ]]
local StatusLabel = nil
local PopLabel = nil
local LevelLabel = nil
local MoneyLabel = nil
local BountyLabel = nil
local PointsLabel = nil

-- [[ HELPERS ]]
local function GetPlayerData(key)
    local data = Player:FindFirstChild("Data")
    if data then
        local val = data:FindFirstChild(key)
        return val and val.Value or 0
    end
    -- Fallback to leaderstats for items like Bounty
    local ls = Player:FindFirstChild("leaderstats")
    if ls then
        local val = ls:FindFirstChild(key)
        return val and val.Value or 0
    end
    return 0
end

local function GetCurrentLevel()
    return GetPlayerData("Level")
end

local function UpdateStatus(text)
    BotStatus = text
    if StatusLabel then
        StatusLabel:SetDesc(BotStatus)
    end
end

local function GetQuestNPC()
    local myLevel = GetCurrentLevel()
    for _, q in ipairs(QuestData) do
        if myLevel >= q.Min and myLevel <= q.Max then
            local npcContainer = workspace:FindFirstChild("ServiceNPCs")
            return npcContainer and npcContainer:FindFirstChild(q.NPC)
        end
    end
    return nil
end

local function GetTargetMob()
    local myLevel = GetCurrentLevel()
    local targetData = nil
    for _, q in ipairs(QuestData) do
        if myLevel >= q.Min and myLevel <= q.Max then
            targetData = MobMapping[q.NPC]
            break
        end
    end

    if targetData then
        local npcContainer = workspace:FindFirstChild("NPCs")
        if not npcContainer then return nil end
        local closest, dist = nil, 5000
        local targets = type(targetData) == "table" and targetData or { targetData }
        for _, name in ipairs(targets) do
            local v = npcContainer:FindFirstChild(name)
            if v and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                local d = (v.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d; closest = v
                end
            end
        end
        return closest
    end
    return nil
end

-- [[ LOADING ANIMATION SYSTEM ]]
local function RunLoader(windowObj)
    local LoaderGui = Instance.new("ScreenGui", PlayerGui)
    LoaderGui.Name = "NattHUB_Loader"
    LoaderGui.DisplayOrder = 10000

    local LoaderFrame = Instance.new("Frame", LoaderGui)
    LoaderFrame.BackgroundColor3 = Color3.fromRGB(3, 3, 5)
    LoaderFrame.Size = UDim2.fromScale(1, 1)

    local Blur = Instance.new("BlurEffect", Lighting)
    Blur.Size = 0

    local Logo = Instance.new("ImageLabel", LoaderFrame)
    Logo.BackgroundTransparency = 1
    Logo.AnchorPoint = Vector2.new(0.5, 0.5)
    Logo.Position = UDim2.fromScale(0.5, 0.5)
    Logo.Size = UDim2.fromOffset(140, 140)
    Logo.Image = Config.LogoID

    local StatusTxt = Instance.new("TextLabel", LoaderFrame)
    StatusTxt.BackgroundTransparency = 1
    StatusTxt.Position = UDim2.new(0.5, 0, 0.5, 100)
    StatusTxt.AnchorPoint = Vector2.new(0.5, 0)
    StatusTxt.Size = UDim2.new(0, 300, 0, 30)
    StatusTxt.Font = Enum.Font.GothamMedium
    StatusTxt.TextColor3 = Color3.fromRGB(230, 230, 230)
    StatusTxt.TextSize = 14

    -- Animation
    local drift = TweenService:Create(Logo,
        TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Position = UDim2.fromScale(0.51, 0.51),
            Size = UDim2.fromOffset(150, 150)
        })
    drift:Play()
    TweenService:Create(Blur, TweenInfo.new(0.5), { Size = 24 }):Play()

    local steps = { "Initializing Assets...", "Syncing Player Data...", "Welcome!" }
    for i, s in ipairs(steps) do
        StatusTxt.Text = s
        TweenService:Create(Logo, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            { Rotation = i * 360 }):Play()
        task.wait(1)
    end

    drift:Cancel()
    local fade = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    TweenService:Create(LoaderFrame, fade, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Logo, fade, { ImageTransparency = 1 }):Play()
    TweenService:Create(StatusTxt, fade, { TextTransparency = 1 }):Play()
    TweenService:Create(Blur, fade, { Size = 0 }):Play()
    task.wait(0.8)

    if windowObj and windowObj.Instance then windowObj.Instance.Enabled = true end
    LoaderGui:Destroy()
    Blur:Destroy()
end

-- [[ WINDUI INITIALIZATION ]]
local WindUI = (loadstring or load)(game:HttpGet(
    "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = Config.Title,
    Icon = Config.Icon,
    Author = Config.Author,
    Folder = Config.Folder,
    Theme = "Mellowsi",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    SideBarSize = 200
})
if Window.Instance then Window.Instance.Enabled = false end

-- [[ TABS ]]
local HomeTab = Window:Tab({ Title = "Home", Icon = "solar:home-2-bold" })

local PlayerSec = HomeTab:Section({ Title = "Player Information", Opened = true })
LevelLabel = PlayerSec:Paragraph({ Title = "Level", Desc = "Lv. 0 (0 EXP)" })
MoneyLabel = PlayerSec:Paragraph({ Title = "Currency", Desc = "0 Money | 0 Gems" })
BountyLabel = PlayerSec:Paragraph({ Title = "Bounty", Desc = "0 Bounty" })
PointsLabel = PlayerSec:Paragraph({ Title = "Stat Points", Desc = "0 Available" })

local DashboardSec = HomeTab:Section({ Title = "Engine Status", Opened = true })
StatusLabel = DashboardSec:Paragraph({ Title = "Bot Status", Desc = BotStatus })
PopLabel = DashboardSec:Paragraph({ Title = "Players on Server", Desc = "Calculating..." })

HomeTab:Button({
    Title = "Join Discord",
    Desc = "discord.gg/natthub",
    Callback = function()
        local clipboard = (setclipboard or toclipboard or print)
        clipboard("https://discord.gg/natthub")
    end,
})

local MainTab = Window:Tab({ Title = "Main", Icon = "solar:star-bold" })
local MainFarm = MainTab:Section({ Title = "Automation", Opened = true })
MainFarm:Toggle({
    Title = "Auto Farm Level",
    Desc = "Automated Questing & Mob Farming",
    Value = false,
    Callback = function(v)
        AutoFarmEnabled = v; UpdateStatus(v and "Farming..." or "Ready")
    end
})

local StatsTab = Window:Tab({ Title = "Auto Stats", Icon = "solar:chart-square-bold" })
local StatSec = StatsTab:Section({ Title = "Attributes", Opened = true })
StatSec:Dropdown({
    Title = "Target Stat",
    Values = { "Melee", "Defense", "Sword", "Power" },
    Callback = function(v) SelectedStat = v end,
})
StatSec:Input({
    Title = "Points Per Cycle",
    Callback = function(v)
        local n = tonumber(v)
        if n then AllocateAmount = n < 1 and 1 or n end
    end,
})
StatSec:Toggle({ Title = "Auto Allocate", Value = false, Callback = function(v) AutoStatsEnabled = v end })
StatSec:Button({
    Title = "Reset Stats",
    Callback = function()
        ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ResetStats"):FireServer()
        WindUI:Notify({ Title = "NattHUB", Content = "Stats Reset" })
    end,
})

local TeleTab = Window:Tab({ Title = "Teleport", Icon = "solar:map-point-wave-bold" })
local TeleSec = TeleTab:Section({ Title = "World Navigation", Opened = true })
local Locs = { "Starter", "Jungle", "Desert", "Snow", "Sailor", "Shibuya", "HallowIsland", "Boss", "Dungeon", "Shijuku",
    "Slime", "Academy", "Kadgement", "Ninja", "Lawless", "Tower" }
TeleSec:Dropdown({
    Title = "Destination",
    Values = Locs,
    Callback = function(v)
        local rem = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal")
        rem:FireServer(v)
    end,
})

-- [[ LOOPS ]]
-- Unified Auto Farm
task.spawn(function()
    while task.wait(0.5) do
        if AutoFarmEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local npc = GetQuestNPC()
            if npc and npc:FindFirstChild("HumanoidRootPart") then
                UpdateStatus("Accepting Quest: " .. npc.Name)
                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("QuestAccept"):FireServer(npc)
            end

            local target = GetTargetMob()
            if target and target:FindFirstChild("HumanoidRootPart") then
                UpdateStatus("Farming: " .. target.Name)
                Player.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)

                local combat = ReplicatedStorage:FindFirstChild("CombatSystem")
                local hit = combat and combat:FindFirstChild("Remotes") and combat.Remotes:FindFirstChild("RequestHit")
                if hit then hit:FireServer() end
            else
                UpdateStatus("Scanning Targets...")
            end
        end
    end
end)

-- Stats Loop
task.spawn(function()
    while task.wait(0.5) do
        if AutoStatsEnabled then
            pcall(function()
                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("AllocateStat"):FireServer(SelectedStat,
                    AllocateAmount)
            end)
        end
    end
end)

-- UI Sync Loop
local function SyncUI()
    if PopLabel then
        PopLabel:SetDesc(#Players:GetPlayers() .. " / " .. Players.MaxPlayers)
    end
    if LevelLabel then
        local lv = GetPlayerData("Level")
        local exp = GetPlayerData("Experience")
        LevelLabel:SetDesc("Lv. " .. lv .. " (" .. exp .. " EXP)")
    end
    if MoneyLabel then
        local money = GetPlayerData("Money")
        local gems = GetPlayerData("Gems")
        MoneyLabel:SetDesc(money .. " Money | " .. gems .. " Gems")
    end
    if BountyLabel then
        local bounty = GetPlayerData("Bounty")
        BountyLabel:SetDesc(bounty .. " Bounty")
    end
    if PointsLabel then
        local pts = GetPlayerData("StatPoints")
        PointsLabel:SetDesc(pts .. " Available")
    end
end

-- Finalization
task.spawn(function()
    while task.wait(2) do
        SyncUI()
    end
end)

HomeTab:Select()
task.spawn(RunLoader, Window)

print("NattHUB | v3.1.0 Global Release")
