-- [[ NattHUB | Sailor Piece Unified Script v4.1.0 ]]
-- Optimized Monolithic Architecture
-- Created by Natt Dev (with Antigravity AI)

---@diagnostic disable: undefined-global
---@diagnostic disable: deprecated

-- [[ SERVICES ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- [[ CONSTANTS & DATA ]]
local Constants = {
    VERSION = "4.1.0",
}
Constants.Config = {
    Version = Constants.VERSION,
    Title = "NattHUB | Sailor Piece " .. Constants.VERSION,
    Icon = "solar:planet-3-bold-duotone",
    LogoID = "rbxassetid://117953684635635",
    Folder = "NattHUB_Configs",
    Author = "by Natt Dev"
}

Constants.QuestData = {
    { Min = 0,     Max = 99,    NPC = "QuestNPC1",  Island = "Starter" },
    { Min = 100,   Max = 249,   NPC = "QuestNPC2",  Island = "Starter" },
    { Min = 250,   Max = 499,   NPC = "QuestNPC3",  Island = "Jungle" },
    { Min = 500,   Max = 749,   NPC = "QuestNPC4",  Island = "Jungle" },
    { Min = 750,   Max = 999,   NPC = "QuestNPC5",  Island = "Desert" },
    { Min = 1000,  Max = 1499,  NPC = "QuestNPC6",  Island = "Desert" },
    { Min = 1500,  Max = 1999,  NPC = "QuestNPC7",  Island = "Snow" },
    { Min = 2000,  Max = 2999,  NPC = "QuestNPC8",  Island = "Snow" },
    { Min = 3000,  Max = 3999,  NPC = "QuestNPC9",  Island = "Shibuya" },
    { Min = 4000,  Max = 4999,  NPC = "QuestNPC10", Island = "Shibuya" },
    { Min = 5000,  Max = 6249,  NPC = "QuestNPC11", Island = "HallowIsland" },
    { Min = 6250,  Max = 6999,  NPC = "QuestNPC12", Island = "Shijuku" },
    { Min = 7000,  Max = 7999,  NPC = "QuestNPC13", Island = "Shijuku" },
    { Min = 8000,  Max = 8999,  NPC = "QuestNPC14", Island = "Slime" },
    { Min = 9000,  Max = 9999,  NPC = "QuestNPC15", Island = "Academy" },
    { Min = 10000, Max = 10749, NPC = "QuestNPC16", Island = "Judgement" },
    { Min = 10750, Max = 11499, NPC = "QuestNPC17", Island = "Judgement" },
    { Min = 11500, Max = 11999, NPC = "QuestNPC18", Island = "Ninja" },
    { Min = 12000, Max = 99999, NPC = "QuestNPC19", Island = "Lawless" }
}

Constants.MobMapping = {
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
    QuestNPC16 = { "Swordsman1", "Swordsman2", "Swordsman3", "Swordsman4", "Swordsman5" },
    QuestNPC17 = { "Quincy1", "Quincy2", "Quincy3", "Quincy4", "Quincy5" },
    QuestNPC18 = { "Ninja1", "Ninja2", "Ninja3", "Ninja4", "Ninja5" },
    QuestNPC19 = { "ArenaFighter1", "ArenaFighter2", "ArenaFighter3", "ArenaFighter4", "ArenaFighter5" }
}

Constants.BossConfig = {
    { Name = "Jinwoo",            Container = "TimedBossSpawn_JinwooBoss_Container",           Boss = "TimedBossSpawn_JinwooBoss",           NPCFolder = "JinwooBoss" },
    { Name = "Gojo",              Container = "TimedBossSpawn_GojoBoss_Container",             Boss = "TimedBossSpawn_GojoBoss",             NPCFolder = "GojoBoss" },
    { Name = "Sukuna",            Container = "TimedBossSpawn_SukunaBoss_Container",           Boss = "TimedBossSpawn_SukunaBoss",           NPCFolder = "SukunaBoss" },
    { Name = "Alucard",           Container = "TimedBossSpawn_AlucardBoss_Container",          Boss = "TimedBossSpawn_AlucardBoss",          NPCFolder = "AlucardBoss" },
    { Name = "Aizen",             Container = "TimedBossSpawn_AizenBoss_Container",            Boss = "TimedBossSpawn_AizenBoss",            NPCFolder = "AizenBoss" },
    { Name = "Madoka",            Container = "TimedBossSpawn_MadokaBoss_Container",           Boss = "TimedBossSpawn_MadokaBoss",           NPCFolder = "MadokaBoss" },
    { Name = "Ragna",             Container = "TimedBossSpawn_RagnaBoss_Container",            Boss = "TimedBossSpawn_RagnaBoss",            NPCFolder = "RagnaBoss" },
    { Name = "Strongest Shinobi", Container = "TimedBossSpawn_StrongestShinobiBoss_Container", Boss = "TimedBossSpawn_StrongestShinobiBoss", NPCFolder = "StrongestShinobiBoss" },
    { Name = "Yamato",            Container = "TimedBossSpawn_Yamato_Container",               Boss = "TimedBossSpawn_YamatoBoss",           NPCFolder = "YamatoBoss" },
    { Name = "Yuji",              Container = "TimedBossSpawn_YujiBoss_Container",             Boss = "TimedBossSpawn_YujiBoss",             NPCFolder = "YujiBoss" }
}

-- [[ STATE MANAGEMENT ]]
local State = {
    AutoFarmEnabled = false,
    AutoBossEnabled = false,
    AutoStatsEnabled = false,
    SelectedBoss = "None",
    SelectedStat = "Melee",
    AllocateAmount = 1,
    LastQuestClaimed = 0,
    BotStatus = "Ready"
}

-- [[ UI REFRESH REFS ]]
local UI = {
    BossLabels = {}
}

local WindUI, Window

-- [[ HELPER FUNCTIONS ]]
local Helpers = {}

function Helpers.GetPlayerData(key)
    local data = Player:FindFirstChild("Data")
    if data then
        local val = data:FindFirstChild(key)
        if val then return val.Value end
    end
    local ls = Player:FindFirstChild("leaderstats")
    if ls then
        local val = ls:FindFirstChild(key)
        if val then return val.Value end
    end
    return 0
end

function Helpers.GetCurrentLevel()
    return Helpers.GetPlayerData("Level")
end

function Helpers.To(targetCFrame, stayStill)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local hrp = Player.Character.HumanoidRootPart
    local dist = (targetCFrame.Position - hrp.Position).Magnitude

    hrp.Anchored = false
    if dist > 30 then
        local tween = TweenService:Create(hrp, TweenInfo.new(dist / 250, Enum.EasingStyle.Linear),
            { CFrame = targetCFrame })
        tween:Play()
        task.wait(dist / 250)
    else
        hrp.CFrame = targetCFrame
    end

    if stayStill then
        hrp.Anchored = true
    end
end

function Helpers.GetBossTime(config)
    local container = workspace:FindFirstChild(config.Container)
    if container then
        local bossObj = container:FindFirstChild(config.Boss)
        if bossObj then
            for _, v in ipairs(bossObj:GetDescendants()) do
                if v:IsA("TextLabel") and v.Text:find(":") then
                    return v.Text
                end
            end
        end
    end
    return "N/A"
end

-- [[ UI MANAGER ]]
local Loader = {}
function Loader.Run(callback)
    local config = Constants.Config
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
    Logo.Image = config.LogoID

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

    local steps = { "Initializing Assets...", "Configuring UI Engine...", "Mixing Modules...", "Welcome!" }
    for i, s in ipairs(steps) do
        StatusTxt.Text = s
        TweenService:Create(Logo, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            { Rotation = i * 360 }):Play()
        task.wait(0.6)
    end

    drift:Cancel()
    local fade = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    TweenService:Create(LoaderFrame, fade, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Logo, fade, { ImageTransparency = 1 }):Play()
    TweenService:Create(StatusTxt, fade, { TextTransparency = 1 }):Play()
    TweenService:Create(Blur, fade, { Size = 0 }):Play()
    task.wait(0.8)

    if callback then callback() end

    LoaderGui:Destroy()
    Blur:Destroy()
end

local UIManager = {}
function UIManager.Init()
    local load_func = (loadstring or load)
    WindUI = load_func(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    local Config = Constants.Config

    Window = WindUI:CreateWindow({
        Title = Config.Title,
        Icon = Config.Icon,
        Author = Config.Author,
        Folder = Config.Folder,
        Theme = "Mellowsi",
        Size = UDim2.fromOffset(580, 460),
        Transparent = true,
        SideBarSize = 200
    })
    Window:DisableTopbarButtons({ "Close", "Minimize" })

    if Window.SetVisible then
        Window:SetVisible(false)
    elseif Window.Instance then
        Window.Instance.Enabled = false
    end
    return Window
end

function UIManager.CreateToggle()
    local Config = Constants.Config
    local ToggleGui = Instance.new("ScreenGui", PlayerGui)
    ToggleGui.Name = "NattHUB_Toggle"
    ToggleGui.ResetOnSpawn = false

    local ToggleBtn = Instance.new("ImageButton", ToggleGui)
    ToggleBtn.Size = UDim2.fromOffset(45, 45)
    ToggleBtn.Position = UDim2.new(0, 15, 0.5, -22)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    ToggleBtn.Image = Config.LogoID
    ToggleBtn.ScaleType = Enum.ScaleType.Fit

    local Corner = Instance.new("UICorner", ToggleBtn)
    Corner.CornerRadius = UDim.new(0, 10)

    local Stroke = Instance.new("UIStroke", ToggleBtn)
    Stroke.Color = Color3.fromRGB(50, 50, 70)
    Stroke.Thickness = 1.5

    ToggleBtn.MouseButton1Click:Connect(function()
        if Window then
            if Window.Toggle then
                Window:Toggle()
            elseif Window.Instance then
                Window.Instance.Enabled = not Window.Instance.Enabled
            end

            local currentState = true
            if Window.Instance then currentState = Window.Instance.Enabled end
            TweenService:Create(ToggleBtn, TweenInfo.new(0.2), { Rotation = currentState and 0 or 180 }):Play()
        end
    end)

    -- Draggable
    local dragging, dragStart, startPos
    ToggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = ToggleBtn.Position
        end
    end)
    ToggleBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale,
                startPos.Y.Offset + delta.Y)
        end
    end)
end

-- [[ TABS & SYNC ]]
local function CreateTabs()
    -- [[ HOME TAB ]]
    local HomeTab = Window:Tab({ Title = "Home", Icon = "solar:home-2-bold" })

    local PlayerSec = HomeTab:Section({ Title = "Player Information", Opened = true })
    UI.LevelLabel = PlayerSec:Paragraph({ Title = "Level", Desc = "Loading..." })
    UI.MoneyLabel = PlayerSec:Paragraph({ Title = "Currency", Desc = "0 Money | 0 Gems" })
    UI.BountyLabel = PlayerSec:Paragraph({ Title = "Bounty", Desc = "0 Bounty" })
    UI.PointsLabel = PlayerSec:Paragraph({ Title = "Stat Points", Desc = "0 Available" })

    local DashboardSec = HomeTab:Section({ Title = "Engine Status", Opened = true })
    UI.StatusLabel = DashboardSec:Paragraph({ Title = "Bot Status", Desc = State.BotStatus })
    UI.PopLabel = DashboardSec:Paragraph({ Title = "Players on Server", Desc = "Calculating..." })

    HomeTab:Button({
        Title = "Join Discord",
        Desc = "discord.gg/natthub",
        Callback = function()
            local clipboard = (setclipboard or toclipboard or print)
            clipboard("https://discord.gg/natthub")
        end,
    })

    -- [[ MAIN TAB ]]
    local MainTab = Window:Tab({ Title = "Main", Icon = "solar:star-bold" })
    local MainFarm = MainTab:Section({ Title = "Automation", Opened = true })
    MainFarm:Toggle({
        Title = "Auto Farm Level",
        Desc = "Automated Questing & Mob Farming",
        Value = State.AutoFarmEnabled,
        Callback = function(v)
            State.AutoFarmEnabled = v
            if UI.StatusLabel then UI.StatusLabel:SetDesc(v and "Farming..." or "Ready") end
        end
    })

    -- [[ BOSS TAB ]]
    local BossTab = Window:Tab({ Title = "Bosses", Icon = "solar:ghost-bold" })
    local BossAuto = BossTab:Section({ Title = "Boss Automation", Opened = true })

    local bossOptions = { "None", "All Bosses" }
    for _, b in ipairs(Constants.BossConfig) do table.insert(bossOptions, b.Name) end

    BossAuto:Dropdown({
        Title = "Target Boss",
        Values = bossOptions,
        Callback = function(v) State.SelectedBoss = v end,
    })

    BossAuto:Toggle({
        Title = "Auto Kill Boss",
        Value = State.AutoBossEnabled,
        Callback = function(v)
            State.AutoBossEnabled = v
            if UI.StatusLabel then UI.StatusLabel:SetDesc(v and "Hunting Boss..." or "Ready") end
        end
    })

    local BossTrackerSec = BossTab:Section({ Title = "Timed Boss Tracker", Opened = false })
    for _, boss in ipairs(Constants.BossConfig) do
        UI.BossLabels[boss.Name] = BossTrackerSec:Paragraph({ Title = boss.Name, Desc = "Loading..." })
    end

    -- [[ STATS TAB ]]
    local StatsTab = Window:Tab({ Title = "Auto Stats", Icon = "solar:chart-square-bold" })
    local StatSec = StatsTab:Section({ Title = "Attributes", Opened = true })
    StatSec:Dropdown({
        Title = "Target Stat",
        Values = { "Melee", "Defense", "Sword", "Power" },
        Callback = function(v) State.SelectedStat = v end,
    })
    StatSec:Input({
        Title = "Points Per Cycle",
        Callback = function(v)
            local n = tonumber(v)
            if n then State.AllocateAmount = n < 1 and 1 or n end
        end,
    })
    StatSec:Toggle({
        Title = "Auto Allocate",
        Value = State.AutoStatsEnabled,
        Callback = function(v)
            State.AutoStatsEnabled =
                v
        end
    })
    StatSec:Button({
        Title = "Reset Stats",
        Callback = function()
            ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ResetStats"):FireServer()
            WindUI:Notify({ Title = "NattHUB", Content = "Stats Reset" })
        end,
    })

    -- [[ TELEPORT TAB ]]
    local TeleTab = Window:Tab({ Title = "Teleport", Icon = "solar:map-point-wave-bold" })
    local TeleSec = TeleTab:Section({ Title = "World Navigation", Opened = true })
    local Locs = { "Starter", "Jungle", "Desert", "Snow", "Sailor", "Shibuya", "HallowIsland", "Boss", "Dungeon",
        "Shijuku",
        "Slime", "Academy", "Judgement", "Ninja", "Lawless", "Tower" }
    TeleSec:Dropdown({
        Title = "Destination",
        Values = Locs,
        Callback = function(v)
            local rem = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal")
            rem:FireServer(v)
        end,
    })
end

local function InitSync()
    local function SyncUI()
        if UI.PopLabel then
            UI.PopLabel:SetDesc(#Players:GetPlayers() .. " / " .. Players.MaxPlayers)
        end
        if UI.LevelLabel then
            local lv = Helpers.GetPlayerData("Level")
            local exp = Helpers.GetPlayerData("Experience")
            UI.LevelLabel:SetDesc("Lv. " .. lv .. " (" .. exp .. " EXP)")
        end
        if UI.MoneyLabel then
            local money = Helpers.GetPlayerData("Money")
            local gems = Helpers.GetPlayerData("Gems")
            UI.MoneyLabel:SetDesc(money .. " Money | " .. gems .. " Gems")
        end
        if UI.BountyLabel then
            local bounty = Helpers.GetPlayerData("Bounty")
            UI.BountyLabel:SetDesc(bounty .. " Bounty")
        end
        if UI.PointsLabel then
            local pts = Helpers.GetPlayerData("StatPoints")
            UI.PointsLabel:SetDesc(pts .. " Available")
        end
        -- Boss Tracker Sync
        for _, config in ipairs(Constants.BossConfig) do
            local label = UI.BossLabels[config.Name]
            if label then
                label:SetDesc(Helpers.GetBossTime(config))
            end
        end
    end

    task.spawn(function()
        while task.wait(2) do
            pcall(SyncUI)
        end
    end)
end

-- [[ AUTOMATION ]]
local function InitAutomation()
    local function GetActiveBoss()
        local npcContainer = workspace:FindFirstChild("NPCs")
        if not npcContainer then return nil end

        local function FindBossInFolder(folderName)
            local folder = npcContainer:FindFirstChild(folderName)
            if folder then
                local boss = folder:FindFirstChild("Boss")
                if boss and boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                    return boss
                end
            end
            return nil
        end

        if State.SelectedBoss ~= "None" and State.SelectedBoss ~= "All Bosses" then
            for _, b in ipairs(Constants.BossConfig) do
                if b.Name == State.SelectedBoss then return FindBossInFolder(b.NPCFolder) end
            end
        elseif State.SelectedBoss == "All Bosses" then
            for _, b in ipairs(Constants.BossConfig) do
                local found = FindBossInFolder(b.NPCFolder)
                if found then return found end
            end
        end
        return nil
    end

    local function GetQuestNPC()
        local myLevel = Helpers.GetCurrentLevel()
        local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil end

        for _, q in ipairs(Constants.QuestData) do
            if myLevel >= q.Min and myLevel <= q.Max then
                local containers = { workspace:FindFirstChild("ServiceNPCs"), workspace:FindFirstChild("NPCs"), workspace }
                for _, container in ipairs(containers) do
                    if container then
                        local npc = container:FindFirstChild(q.NPC)
                        if npc and npc:FindFirstChild("HumanoidRootPart") then
                            local dist = (npc.HumanoidRootPart.Position - hrp.Position).Magnitude
                            if dist < 3000 then return npc end
                        end
                    end
                end
            end
        end
        return nil
    end

    local function GetTargetMob()
        local myLevel = Helpers.GetCurrentLevel()
        local targetData = nil
        for _, q in ipairs(Constants.QuestData) do
            if myLevel >= q.Min and myLevel <= q.Max then
                targetData = Constants.MobMapping[q.NPC]
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
                    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local d = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
                        if d < dist and d < 3000 then
                            dist = d; closest = v
                        end
                    end
                end
            end
            return closest
        end
        return nil
    end

    -- Farming Loop
    task.spawn(function()
        while task.wait(0.5) do
            if State.AutoBossEnabled then
                local boss = GetActiveBoss()
                if boss then
                    if UI.StatusLabel then UI.StatusLabel:SetDesc("Killing Boss: " .. boss.Parent.Name) end
                    Helpers.To(boss.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0), true)
                    local hit = ReplicatedStorage:FindFirstChild("CombatSystem") and
                        ReplicatedStorage.CombatSystem:FindFirstChild("Remotes") and
                        ReplicatedStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
                    if hit then pcall(function() hit:FireServer() end) end
                else
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.Anchored = false end
                end
            elseif State.AutoFarmEnabled then
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local npc = GetQuestNPC()

                    if not npc then
                        local myLevel = Helpers.GetCurrentLevel()
                        for _, q in ipairs(Constants.QuestData) do
                            if myLevel >= q.Min and myLevel <= q.Max then
                                if UI.StatusLabel then UI.StatusLabel:SetDesc("Warping to Island: " .. q.Island) end
                                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(q
                                    .Island)
                                task.wait(3); break
                            end
                        end
                    end

                    if npc and npc:FindFirstChild("HumanoidRootPart") and (tick() - State.LastQuestClaimed > 5) then
                        if UI.StatusLabel then UI.StatusLabel:SetDesc("Accepting Quest: " .. npc.Name) end
                        Helpers.To(npc.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0), true)
                        task.wait(0.5)
                        pcall(function()
                            ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("QuestAccept")
                                :FireServer(npc.Name)
                        end)
                        State.LastQuestClaimed = tick()
                    end

                    local target = GetTargetMob()
                    if target and target:FindFirstChild("HumanoidRootPart") then
                        if UI.StatusLabel then UI.StatusLabel:SetDesc("Farming: " .. target.Name) end
                        Helpers.To(target.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0), true)
                        local hit = ReplicatedStorage:FindFirstChild("CombatSystem") and
                            ReplicatedStorage.CombatSystem:FindFirstChild("Remotes") and
                            ReplicatedStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
                        if hit then pcall(function() hit:FireServer() end) end
                    else
                        if UI.StatusLabel then UI.StatusLabel:SetDesc("Scanning Targets...") end
                        Player.Character.HumanoidRootPart.Anchored = false
                    end
                end
            else
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.Anchored = false end
            end
        end
    end)

    -- Stats Loop
    task.spawn(function()
        while task.wait(0.5) do
            if State.AutoStatsEnabled then
                pcall(function()
                    ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("AllocateStat"):FireServer(
                        State.SelectedStat, State.AllocateAmount)
                end)
            end
        end
    end)
end

-- [[ STARTUP EXECUTION ]]
Loader.Run(function()
    UIManager.Init()
    CreateTabs()
    UIManager.CreateToggle()
    InitSync()
    InitAutomation()

    WindUI:Notify({
        Title = "NattHUB",
        Content = "Script Loaded Successfully! Version: " .. Constants.VERSION,
        Duration = 5
    })
end)
