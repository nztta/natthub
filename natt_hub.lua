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
    VERSION = "4.2.0",
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
    { Name = "Jinwoo",            HP = "6M",    Island = "Sailor",      Rewards = "Haki Reroll (80%), Race (50%), Trait (40%), Shadow Heart (2%), Cape (3%)",           Container = "TimedBossSpawn_JinwooBoss_Container",           Boss = "TimedBossSpawn_JinwooBoss",           NPCFolder = "JinwooBoss" },
    { Name = "Alucard",           HP = "20M",   Island = "Sailor",      Rewards = "Race (85%), Trait (80%), Soul Amulet (8%), Casull (2%), Blood Ring (2%), Coat (3%)", Container = "TimedBossSpawn_AlucardBoss_Container",          Boss = "TimedBossSpawn_AlucardBoss",          NPCFolder = "AlucardBoss",         DependsOn = "Jinwoo" },
    { Name = "Yuji",              HP = "3.75M", Island = "Shibuya",     Rewards = "Flash Impact (9%), Divergent Pulse (4%), Yuji Hair (5%), Title (5%)",                Container = "TimedBossSpawn_YujiBoss_Container",             Boss = "TimedBossSpawn_YujiBoss",             NPCFolder = "YujiBoss" },
    { Name = "Gojo",              HP = "4M",    Island = "Shibuya",     Rewards = "Limitless Key (30%), Void Fragment (20%), Limitless Ring (8%), Blindfold (5%)",      Container = "TimedBossSpawn_GojoBoss_Container",             Boss = "TimedBossSpawn_GojoBoss",             NPCFolder = "GojoBoss" },
    { Name = "Sukuna",            HP = "5M",    Island = "Shibuya",     Rewards = "Malevolent Key (30%), Cursed Finger (20%), Dismantle Fang (8%), Collar (4%)",        Container = "TimedBossSpawn_SukunaBoss_Container",           Boss = "TimedBossSpawn_SukunaBoss",           NPCFolder = "SukunaBoss" },
    { Name = "Aizen",             HP = "25M",   Island = "Hueco Mundo", Rewards = "Mirage Pendant (20%), Illusion Prism (8%), Hogyoku Fragment (1.2%), Haori (2%)",     Container = "TimedBossSpawn_AizenBoss_Container",            Boss = "TimedBossSpawn_AizenBoss",            NPCFolder = "AizenBoss" },
    { Name = "Madoka",            HP = "250M",  Island = "Valentine",   Rewards = "Divine Fragment (6%), Sacred Bow (4%), Pink Gem (0.75%), Wings (1.5%)",              Container = "TimedBossSpawn_MadokaBoss_Container",           Boss = "TimedBossSpawn_MadokaBoss",           NPCFolder = "MadokaBoss" },
    { Name = "Strongest Shinobi", HP = "2B",    Island = "Ninja",       Rewards = "Void Reaver (100%), Power Remnant (5.11%), Battle Sigil (2.94%), Warlord (1.5%)",    Container = "TimedBossSpawn_StrongestShinobiBoss_Container", Boss = "TimedBossSpawn_StrongestShinobiBoss", NPCFolder = "StrongestShinobiBoss" },
}

-- [[ STATE MANAGEMENT ]]
local State = {
    AutoFarmEnabled = false,
    AutoBossEnabled = false,
    AutoStatsEnabled = false,
    AutoClickEnabled = false,
    AutoSkillEnabled = false,
    AutoWeaponEnabled = false,
    SelectedWeapon = "None",
    SelectedBoss = "None",
    AllocateAmount = 1,
    LastQuestClaimed = 0,
    LastWarpTime = 0,
    AutoHealthSafety = false,
    IsHealing = false,
    BotStatus = "Ready"
}
local StatToggles = { Melee = false, Defense = false, Sword = false, Power = false }
local SkillToggles = { Z = false, X = false, C = false, V = false, F = false }


-- [[ UI REFRESH REFS ]]
local UI = {
    BossLabels = {}
}

local WindUI, Window

-- [[ HELPER FUNCTIONS ]]
local Helpers = {}

function Helpers.GetPlayerData(key)
    -- Priorities based on confirmed game structure
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

    -- Fallback search for other possible containers
    local folders = { "Stats", "PlayerData", "Values", "Account", "PlayerStats", "StatsFolder" }
    for _, folderName in ipairs(folders) do
        local folder = Player:FindFirstChild(folderName)
        if folder then
            local val = folder:FindFirstChild(key)
            if val then return val.Value end
        end
    end
    return 0
end

function Helpers.GetCurrentLevel()
    return Helpers.GetPlayerData("Level")
end

function Helpers.To(targetCFrame, stayStill)
    pcall(function()
        if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
        local hrp = Player.Character.HumanoidRootPart
        local dist = (targetCFrame.Position - hrp.Position).Magnitude

        warn(string.format("[NattHUB Debug] Moving: Dist %.1f | stayStill: %s", dist, tostring(stayStill)))

        local isAutomating = State.AutoFarmEnabled or State.AutoBossEnabled

        -- Cleanup BV if not automating
        if not isAutomating or not stayStill then
            local bv = hrp:FindFirstChild("NattHUB_AntiFall")
            if bv then bv:Destroy() end
            hrp.Anchored = false
            if not isAutomating then return end
        end

        if dist < 3 then
            if stayStill and isAutomating then
                -- Unleash the Anchor so we can deal damage natively!
                hrp.Anchored = false
                -- Use BodyVelocity to lock us perfectly in the air without tripping anti-cheat
                local bv = hrp:FindFirstChild("NattHUB_AntiFall")
                if not bv then
                    bv = Instance.new("BodyVelocity")
                    bv.Name = "NattHUB_AntiFall"
                    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.P = 125000
                    bv.Parent = hrp
                end
                hrp.CFrame = targetCFrame
            end
            return
        end

        -- Safe traveling: Lock anchored to tween effortlessly across the map
        hrp.Anchored = true
        local prevBv = hrp:FindFirstChild("NattHUB_AntiFall")
        if prevBv then prevBv:Destroy() end

        if dist > 30 then
            warn("[NattHUB Debug] Distance > 30: Starting Tween Movement")
            local tween = TweenService:Create(hrp, TweenInfo.new(dist / 100, Enum.EasingStyle.Linear),
                { CFrame = targetCFrame })
            tween:Play()
            task.wait(dist / 100)
        else
            hrp.CFrame = targetCFrame
        end

        -- Upon arrival, re-evaluate lock state
        if stayStill and isAutomating then
            hrp.Anchored = false
            local postBv = hrp:FindFirstChild("NattHUB_AntiFall")
            if not postBv then
                postBv = Instance.new("BodyVelocity")
                postBv.Name = "NattHUB_AntiFall"
                postBv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                postBv.Velocity = Vector3.new(0, 0, 0)
                postBv.P = 125000
                postBv.Parent = hrp
            end
        else
            Helpers.UnlockCharacter()
        end
    end)
end

function Helpers.UnlockCharacter()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = Player.Character.HumanoidRootPart
        hrp.Anchored = false
        local bv = hrp:FindFirstChild("NattHUB_AntiFall")
        if bv then bv:Destroy() end
    end
end

function Helpers.GetHealthFromUI()
    local success, result_current, result_max = pcall(function()
        local playerGui = Player:FindFirstChild("PlayerGui")
        if not playerGui then return 0, 100 end

        local ui = playerGui:FindFirstChild("BasicStatsCurrencyAndButtonsUI")
        local holder = ui and ui:FindFirstChild("MainFrame")
            and ui.MainFrame:FindFirstChild("HPAndXPBars")
            and ui.MainFrame.HPAndXPBars:FindFirstChild("HealthBar")
            and ui.MainFrame.HPAndXPBars.HealthBar:FindFirstChild("LoaderFrame")
            and ui.MainFrame.HPAndXPBars.HealthBar.LoaderFrame:FindFirstChild("LoaderHolder")
            and ui.MainFrame.HPAndXPBars.HealthBar.LoaderFrame.LoaderHolder:FindFirstChild("Stat")
            and ui.MainFrame.HPAndXPBars.HealthBar.LoaderFrame.LoaderHolder.Stat:FindFirstChild("AutoSizeHolder")

        if holder then
            local amountObj = holder:FindFirstChild("Amount")
            local capacityObj = holder:FindFirstChild("FullCapacity")
            if amountObj and capacityObj then
                local current = tonumber(amountObj.Text:gsub("[^%d%.]", "")) or 0
                local max = tonumber(capacityObj.Text:gsub("[^%d%.]", "")) or 100
                return current, max
            end
        end

        -- Fallback to Humanoid
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            return Player.Character.Humanoid.Health, Player.Character.Humanoid.MaxHealth
        end
        return 0, 100
    end)
    if success then
        return result_current, result_max
    end
    return 0, 100
end

function Helpers.IsBossAlive(bossName)
    local config = nil
    for _, b in ipairs(Constants.BossConfig) do
        if b.Name == bossName then
            config = b; break
        end
    end
    if not config then return false end

    local npcContainer = workspace:FindFirstChild("NPCs")
    if npcContainer then
        local bossModel = npcContainer:FindFirstChild(config.NPCFolder)
        if bossModel then
            local innerBoss = bossModel:FindFirstChild("Boss")
            if innerBoss and innerBoss:FindFirstChild("Humanoid") and innerBoss.Humanoid.Health > 0 then
                return true
            end
            if bossModel:FindFirstChild("Humanoid") and bossModel.Humanoid.Health > 0 then
                return true
            end
        end
    end
    return false
end

function Helpers.HasActiveQuest()
    local hasQuest = false
    pcall(function()
        local questUI = Player:WaitForChild("PlayerGui"):FindFirstChild("QuestUI")
        if questUI and questUI:FindFirstChild("Quest") and questUI.Quest.Visible then
            hasQuest = true
        end
    end)
    warn("[NattHUB Debug] HasActiveQuest Check: " .. tostring(hasQuest))
    return hasQuest
end

function Helpers.GetBossTime(config)
    -- Check Dependency
    if config.DependsOn and Helpers.IsBossAlive(config.DependsOn) then
        return "Waiting"
    end

    -- Check if Spawned
    if Helpers.IsBossAlive(config.Name) then
        return "Spawned!"
    end

    -- Check Timer
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
    return "Waiting..."
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
    UI.StatusLabel = DashboardSec:Paragraph({ Title = "Bot Status", Desc = "Ready" })
    UI.PopLabel = DashboardSec:Paragraph({ Title = "Player on Server", Desc = #Players:GetPlayers() .. " / " .. Players.MaxPlayers })

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
        Title = "Auto Health",
        Desc = "Fly 20 studs higher when health is < 20%",
        Value = State.AutoHealthSafety,
        Callback = function(v)
            State.AutoHealthSafety = v
            if v == false then State.IsHealing = false end
        end
    })

    MainFarm:Toggle({
        Title = "Auto Farm Level",
        Desc = "Automated Questing & Mob Farming",
        Value = State.AutoFarmEnabled,
        Callback = function(v)
            State.AutoFarmEnabled = v
            if UI.StatusLabel then UI.StatusLabel:SetDesc(v and "Farming..." or "Ready") end
            if not v then Helpers.UnlockCharacter() end
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
            if not v then Helpers.UnlockCharacter() end
        end
    })

    local BossTrackerSec = BossTab:Section({ Title = "Timed Boss Tracker", Opened = false })
    for _, boss in ipairs(Constants.BossConfig) do
        local info = string.format("[%s @ %s]\nHP: %s\nDrops: %s", boss.Name, boss.Island or "Unknown", boss.HP or "?",
            boss.Rewards or "Unknown")
        UI.BossLabels[boss.Name] = BossTrackerSec:Paragraph({ Title = boss.Name, Desc = info .. "\nStatus: Loading..." })
    end

    -- [[ COMBAT SETTINGS (MAIN TAB) ]]
    local WeaponSec = MainTab:Section({ Title = "Weapon Management", Opened = false })

    local weaponDropdown = WeaponSec:Dropdown({
        Title = "Select Weapon",
        Values = { "None" },
        Callback = function(v) State.SelectedWeapon = v end,
    })
    WeaponSec:Button({
        Title = "Refresh Weapons",
        Callback = function()
            local list = { "None" }
            for _, t in ipairs(Player.Backpack:GetChildren()) do
                if t:IsA("Tool") then table.insert(list, t.Name) end
            end
            if Player.Character then
                for _, t in ipairs(Player.Character:GetChildren()) do
                    if t:IsA("Tool") then table.insert(list, t.Name) end
                end
            end
            weaponDropdown:Refresh(list)
            WindUI:Notify({ Title = "NattHUB", Content = "Weapons Refreshed!" })
        end
    })
    WeaponSec:Toggle({
        Title = "Auto Equip Weapon",
        Value = State.AutoWeaponEnabled,
        Callback = function(v) State.AutoWeaponEnabled = v end
    })

    local SkillSec = MainTab:Section({ Title = "Auto Skills & Combat", Opened = false })
    SkillSec:Toggle({
        Title = "Auto Use Skills",
        Value = State.AutoSkillEnabled,
        Callback = function(v)
            State.AutoSkillEnabled =
                v
        end
    })
    SkillSec:Toggle({ Title = "Use Z Skill", Value = false, Callback = function(v) SkillToggles.Z = v end })
    SkillSec:Toggle({ Title = "Use X Skill", Value = false, Callback = function(v) SkillToggles.X = v end })
    SkillSec:Toggle({ Title = "Use C Skill", Value = false, Callback = function(v) SkillToggles.C = v end })
    SkillSec:Toggle({ Title = "Use V Skill", Value = false, Callback = function(v) SkillToggles.V = v end })
    SkillSec:Toggle({ Title = "Use F Skill", Value = false, Callback = function(v) SkillToggles.F = v end })

    -- [[ STATS TAB ]]
    local StatsTab = Window:Tab({ Title = "Auto Stats", Icon = "solar:chart-square-bold" })
    local StatSec = StatsTab:Section({ Title = "Attributes", Opened = true })
    StatSec:Input({
        Title = "Points Per Cycle",
        Placeholder = "Amount...",
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
    StatSec:Paragraph({ Title = "Select Targets", Desc = "Enable multiple stats to allocate equally." })
    StatSec:Toggle({ Title = "Melee", Value = false, Callback = function(v) StatToggles.Melee = v end })
    StatSec:Toggle({ Title = "Defense", Value = false, Callback = function(v) StatToggles.Defense = v end })
    StatSec:Toggle({ Title = "Sword", Value = false, Callback = function(v) StatToggles.Sword = v end })
    StatSec:Toggle({ Title = "Power", Value = false, Callback = function(v) StatToggles.Power = v end })

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
        "Shijuku", "Slime", "Academy", "Judgement", "Ninja", "Lawless", "Hueco Mundo", "Valentine", "Tower" }
    TeleSec:Dropdown({
        Title = "Destination",
        Values = Locs,
        Callback = function(v)
            local rem = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal")
            rem:FireServer(v)
        end,
    })

    -- [[ MISC TAB ]]
    local MiscTab = Window:Tab({ Title = "Misc", Icon = "solar:settings-minimalistic-bold" })
    local MiscSec = MiscTab:Section({ Title = "Server Utilities", Opened = true })

    MiscSec:Button({
        Title = "Rejoin Server",
        Desc = "Quickly rejoin the current server instance.",
        Callback = function()
            local ts = game:GetService("TeleportService")
            ts:Teleport(game.PlaceId, Player)
        end,
    })
end

local function InitSync()
    task.wait(2) -- Buffer for game data loading

    local function SyncUI()
        -- Population Sync
        pcall(function()
            if UI.PopLabel then
                UI.PopLabel:SetDesc(tostring(#Players:GetPlayers()) .. " / " .. tostring(Players.MaxPlayers))
            end
        end)

        -- Level/Exp Sync
        pcall(function()
            if UI.LevelLabel then
                local lv = Helpers.GetPlayerData("Level")
                local exp = Helpers.GetPlayerData("Experience")
                if exp == 0 then exp = Helpers.GetPlayerData("Exp") or 0 end
                if exp == 0 then exp = Helpers.GetPlayerData("XP") or 0 end
                UI.LevelLabel:SetDesc("Lv. " .. tostring(lv) .. " (" .. tostring(exp) .. " EXP)")
            end
        end)

        -- Currency Sync
        pcall(function()
            if UI.MoneyLabel then
                local money = Helpers.GetPlayerData("Money")
                if money == 0 then money = Helpers.GetPlayerData("Beli") or 0 end
                if money == 0 then money = Helpers.GetPlayerData("Cash") or 0 end
                if money == 0 then money = Helpers.GetPlayerData("Gold") or 0 end

                local gems = Helpers.GetPlayerData("Gems")
                if gems == 0 then gems = Helpers.GetPlayerData("Diamonds") or 0 end

                UI.MoneyLabel:SetDesc(tostring(money) .. " Money | " .. tostring(gems) .. " Gems")
            end
        end)

        -- Bounty Sync
        pcall(function()
            if UI.BountyLabel then
                local bounty = Helpers.GetPlayerData("Bounty")
                if bounty == 0 then bounty = Helpers.GetPlayerData("Honor") or 0 end
                UI.BountyLabel:SetDesc(tostring(bounty) .. " Bounty")
            end
        end)

        -- Stat Points Sync
        pcall(function()
            if UI.PointsLabel then
                local pts = Helpers.GetPlayerData("StatPoints")
                if pts == 0 then pts = Helpers.GetPlayerData("Points") or 0 end
                UI.PointsLabel:SetDesc(tostring(pts) .. " Available")
            end
        end)

        -- Boss Tracker Sync
        pcall(function()
            for _, config in ipairs(Constants.BossConfig) do
                local label = UI.BossLabels[config.Name]
                if label then
                    local info = string.format("[%s @ %s]\nHP: %s\nDrops: %s",
                        tostring(config.Name),
                        tostring(config.Island or "Unknown"),
                        tostring(config.HP or "?"),
                        tostring(config.Rewards or "Unknown")
                    )
                    label:SetDesc(info .. "\nStatus: " .. tostring(Helpers.GetBossTime(config)))
                end
            end
        end)
    end

    -- Trigger initial sync immediately
    pcall(SyncUI)

    task.spawn(function()
        while task.wait(2) do
            pcall(SyncUI)
        end
    end)

    -- DEBUG: Identify possible data containers for "player data not connect" issue
    task.spawn(function()
        task.wait(5)
        warn("NattHUB: Scanning player for data containers...")
        local found = false
        for _, child in ipairs(Player:GetChildren()) do
            if child:IsA("Folder") or child:IsA("Configuration") then
                print("NattHUB Data Candidate: " .. child.Name .. " (" .. child.ClassName .. ")")
                found = true
            end
        end
        if not found then warn("NattHUB: No folders found in Player object!") end
    end)
end

-- [[ AUTOMATION ]]
local function InitAutomation()
    local function GetActiveBoss()
        local npcContainer = workspace:FindFirstChild("NPCs")
        if not npcContainer then return nil end

        local function FindBossInFolder(folderName)
            local bossModel = npcContainer:FindFirstChild(folderName)
            if bossModel then
                local innerBoss = bossModel:FindFirstChild("Boss")
                if innerBoss and innerBoss:FindFirstChild("HumanoidRootPart") and innerBoss:FindFirstChild("Humanoid") and innerBoss.Humanoid.Health > 0 then
                    return innerBoss
                end
                if bossModel:FindFirstChild("HumanoidRootPart") and bossModel:FindFirstChild("Humanoid") and bossModel.Humanoid.Health > 0 then
                    return bossModel
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
                        if npc then
                            local npcHRP = npc:FindFirstChild("HumanoidRootPart")
                            if npcHRP then
                                local dist = (npcHRP.Position - hrp.Position).Magnitude
                                if dist < 3000 then return npc end
                            end
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
                if v then
                    local vHRP = v:FindFirstChild("HumanoidRootPart")
                    local vHum = v:FindFirstChild("Humanoid")
                    if vHRP and vHum and vHum.Health > 0 then
                        local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local d = (vHRP.Position - hrp.Position).Magnitude
                            if d < dist and d < 3000 then
                                dist = d; closest = v
                            end
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
            local success, err = pcall(function()
                -- Health Safety Logic
                if State.AutoHealthSafety and Player.Character then
                    local currHealth, maxHealth = Helpers.GetHealthFromUI()
                    local healthRatio = currHealth / maxHealth

                    if healthRatio < 0.2 then State.IsHealing = true end
                    if healthRatio >= 0.95 then State.IsHealing = false end

                    if State.IsHealing then
                        if UI.StatusLabel then
                            UI.StatusLabel:SetDesc(string.format("Healing (%.1f%%)...", healthRatio * 100))
                        end

                        -- Find ANY target to float above for safety
                        local safeTarget = GetActiveBoss() or GetTargetMob()
                        if safeTarget and safeTarget:FindFirstChild("HumanoidRootPart") then
                            Helpers.To(safeTarget.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0), true)
                        else
                            -- If no target nearby, just stay floating where we are safely
                            if Player.Character:FindFirstChild("HumanoidRootPart") then
                                Helpers.To(Player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0), true)
                            end
                        end
                        return -- Skip combat actions while healing
                    end
                end

                if State.AutoBossEnabled then
                    warn("[NattHUB Debug] --- AutoBoss Loop Start ---")
                    local boss = GetActiveBoss()

                    -- Get Boss Config for debug and warp
                    local targetBossConfig = nil
                    if State.SelectedBoss ~= "None" and State.SelectedBoss ~= "All Bosses" then
                        for _, b in ipairs(Constants.BossConfig) do
                            if b.Name == State.SelectedBoss then
                                targetBossConfig = b; break
                            end
                        end
                    end

                    if targetBossConfig then
                        warn("[NattHUB Debug] Target Boss: " .. targetBossConfig.Name)
                        warn("[NattHUB Debug] Target Island: " .. targetBossConfig.Island)
                    end

                    if boss then
                        if UI.StatusLabel then UI.StatusLabel:SetDesc("Killing Boss: " .. boss.Parent.Name) end
                        local bossHRP = boss:FindFirstChild("HumanoidRootPart")
                        if bossHRP then
                            -- Consistent 7-stud height offset
                            Helpers.To(bossHRP.CFrame * CFrame.new(0, 7, 0), true)
                        end
                        local hit = ReplicatedStorage:FindFirstChild("CombatSystem") and
                            ReplicatedStorage.CombatSystem:FindFirstChild("Remotes") and
                            ReplicatedStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
                        if hit then pcall(function() hit:FireServer() end) end
                    else
                        warn("[NattHUB Debug] No active boss found in range.")
                        if UI.StatusLabel then UI.StatusLabel:SetDesc("Scanning Boss...") end

                        -- EMERGENCY WARP FOR BOSSES
                        if targetBossConfig and (tick() - State.LastWarpTime > 10) then
                            warn("[NattHUB Debug] Boss " ..
                                targetBossConfig.Name .. " missing. Warping to " .. targetBossConfig.Island)
                            if UI.StatusLabel then
                                UI.StatusLabel:SetDesc("Warping to Boss Island: " ..
                                    targetBossConfig.Island)
                            end
                            local warpRemote = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild(
                                "TeleportToPortal", 5)
                            if warpRemote then
                                pcall(function() warpRemote:FireServer(targetBossConfig.Island) end)
                                State.LastWarpTime = tick()
                            end
                        end

                        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                            Player.Character.HumanoidRootPart.Anchored = false
                        end
                    end
                elseif State.AutoFarmEnabled then
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        warn("[NattHUB Debug] --- AutoFarm Loop Start ---")
                        local hasQuest = Helpers.HasActiveQuest()
                        local npc = nil

                        -- Determine target quest data upfront
                        local myLevel = Helpers.GetCurrentLevel()
                        local questConfig = nil
                        for _, q in ipairs(Constants.QuestData) do
                            if myLevel >= q.Min and myLevel <= q.Max then
                                questConfig = q; break
                            end
                        end

                        if questConfig then
                            local mobNames = Constants.MobMapping[questConfig.NPC]
                            local mobDisplay = type(mobNames) == "table" and table.concat(mobNames, ", ") or
                                tostring(mobNames)
                            warn("[NattHUB Debug] Target Island: " .. questConfig.Island)
                            warn("[NattHUB Debug] Target NPC: " .. questConfig.NPC)
                            warn("[NattHUB Debug] Target Mobs: " .. mobDisplay)
                            warn("[NattHUB Debug] HasActiveQuest Check: " .. tostring(hasQuest))

                            if not hasQuest then
                                -- Global Search for NPC (Verify Presence)
                                local foundNPC = nil
                                local containers = { workspace:FindFirstChild("ServiceNPCs"), workspace:FindFirstChild(
                                    "NPCs"), workspace }
                                for _, container in ipairs(containers) do
                                    if container then
                                        local candidate = container:FindFirstChild(questConfig.NPC)
                                        if candidate and candidate:FindFirstChild("HumanoidRootPart") then
                                            foundNPC = candidate; break
                                        end
                                    end
                                end

                                local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                                if hrp and foundNPC then
                                    local dist = (foundNPC.HumanoidRootPart.Position - hrp.Position).Magnitude
                                    if dist < 25 then
                                        warn("[NattHUB Debug] Above Quest NPC head. Ready to claim.")
                                        npc = foundNPC
                                    else
                                        -- Found but not on head - Warp Required
                                        if tick() - State.LastWarpTime > 10 then
                                            warn("[NattHUB Debug] NPC found but too far (" ..
                                                math.floor(dist) .. " studs). Retrying Warp...")
                                            if UI.StatusLabel then
                                                UI.StatusLabel:SetDesc("Retrying Warp: " ..
                                                    questConfig.Island)
                                            end
                                            local warpRemote = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild(
                                                "TeleportToPortal", 5)
                                            if warpRemote then
                                                pcall(function() warpRemote:FireServer(questConfig.Island) end)
                                                State.LastWarpTime = tick()
                                            end
                                        else
                                            if UI.StatusLabel then
                                                UI.StatusLabel:SetDesc("Warp Cooldown... (" ..
                                                    math.floor(10 - (tick() - State.LastWarpTime)) .. "s)")
                                            end
                                        end
                                    end
                                else
                                    -- NPC Not found at all in workspace - Warp Required
                                    if tick() - State.LastWarpTime > 10 then
                                        warn("[NattHUB Debug] NPC " ..
                                            questConfig.NPC .. " NOT FOUND. Warping to " .. questConfig.Island)
                                        if UI.StatusLabel then
                                            UI.StatusLabel:SetDesc("Island Warp: " ..
                                                questConfig.Island)
                                        end
                                        local warpRemote = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild(
                                            "TeleportToPortal", 5)
                                        if warpRemote then
                                            pcall(function() warpRemote:FireServer(questConfig.Island) end)
                                            State.LastWarpTime = tick()
                                        end
                                    else
                                        if UI.StatusLabel then
                                            UI.StatusLabel:SetDesc("Warp Cooldown... (" ..
                                                math.floor(10 - (tick() - State.LastWarpTime)) .. "s)")
                                        end
                                    end
                                end
                            end
                        end

                        if npc and npc:FindFirstChild("HumanoidRootPart") and (tick() - State.LastQuestClaimed > 5) then
                            warn("[NattHUB Debug] Approaching NPC to accept quest...")
                            if UI.StatusLabel then UI.StatusLabel:SetDesc("Accepting Quest: " .. npc.Name) end
                            Helpers.To(npc.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0), true)
                            task.wait(0.5)
                            warn("[NattHUB Debug] Firing QuestAccept Server Event")
                            pcall(function()
                                local qRemote = ReplicatedStorage:FindFirstChild("RemoteEvents") and
                                    ReplicatedStorage.RemoteEvents:FindFirstChild("QuestAccept")
                                if qRemote then qRemote:FireServer(npc.Name) end
                            end)
                            State.LastQuestClaimed = tick()
                        end

                        warn("[NattHUB Debug] Looking for Target Mobs...")
                        local target = GetTargetMob()
                        if target and target:FindFirstChild("HumanoidRootPart") then
                            warn("[NattHUB Debug] Target Found: " .. target.Name)
                            if UI.StatusLabel then UI.StatusLabel:SetDesc("Farming: " .. target.Name) end
                            Helpers.To(target.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0), true)

                            warn("[NattHUB Debug] Firing Combat RequestHit")
                            local hit = ReplicatedStorage:FindFirstChild("CombatSystem") and
                                ReplicatedStorage.CombatSystem:FindFirstChild("Remotes") and
                                ReplicatedStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
                            if hit then pcall(function() hit:FireServer() end) end
                        else
                            warn("[NattHUB Debug] No targets found in range.")
                            if UI.StatusLabel then UI.StatusLabel:SetDesc("Scanning Targets...") end

                            -- FIX: If we have a quest but no targets exist, it means we are likely on the wrong island or too far.
                            -- Trigger a warp to the island corresponding to our level.
                            if hasQuest and questConfig then
                                if tick() - State.LastWarpTime > 10 then
                                    warn(
                                        "[NattHUB Debug] No targets reachable for active quest. Triggering emergency Warp to " ..
                                        questConfig.Island)
                                    if UI.StatusLabel then
                                        UI.StatusLabel:SetDesc("Emergency Warp: " ..
                                            questConfig.Island)
                                    end
                                    local warpRemote = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild(
                                        "TeleportToPortal", 5)
                                    if warpRemote then
                                        pcall(function() warpRemote:FireServer(questConfig.Island) end)
                                        State.LastWarpTime = tick()
                                    end
                                end
                            end

                            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                                Player.Character.HumanoidRootPart.Anchored = false
                            end
                        end
                    end
                else
                    Helpers.UnlockCharacter()
                end
            end)
            if not success then
                warn("[NattHUB Error] Farming Loop Prevented Crash: " .. tostring(err))
            end
        end
    end)

    -- Stats Loop
    task.spawn(function()
        while task.wait(0.5) do
            local success, err = pcall(function()
                if State.AutoStatsEnabled then
                    local event = ReplicatedStorage:FindFirstChild("RemoteEvents") and
                        ReplicatedStorage.RemoteEvents:FindFirstChild("AllocateStat")
                    if event then
                        local activeStats = {}
                        if StatToggles.Melee then table.insert(activeStats, "Melee") end
                        if StatToggles.Defense then table.insert(activeStats, "Defense") end
                        if StatToggles.Sword then table.insert(activeStats, "Sword") end
                        if StatToggles.Power then table.insert(activeStats, "Power") end

                        for _, statName in ipairs(activeStats) do
                            event:FireServer(statName, State.AllocateAmount)
                        end
                    end
                end
            end)
            if not success then
                warn("[NattHUB Error] Stats Loop Prevented Crash: " .. tostring(err))
            end
        end
    end)

    -- Combat Loop (Weapon & Skills)
    task.spawn(function()
        while task.wait(0.2) do
            pcall(function()
                if not Player.Character then return end

                -- Auto Equip Weapon
                if State.AutoWeaponEnabled and State.SelectedWeapon ~= "None" then
                    local tool = Player.Backpack:FindFirstChild(State.SelectedWeapon)
                    if tool and tool:IsA("Tool") then
                        Player.Character.Humanoid:EquipTool(tool)
                    end
                end

                -- Auto Skills (ONLY IF Farming OR Bossing)
                if State.AutoSkillEnabled and (State.AutoFarmEnabled or State.AutoBossEnabled) then
                    local abilitySystem = ReplicatedStorage:FindFirstChild("AbilitySystem")
                    local remotes = abilitySystem and abilitySystem:FindFirstChild("Remotes")
                    local reqAbility = remotes and remotes:FindFirstChild("RequestAbility")

                    if reqAbility then
                        if SkillToggles.Z then reqAbility:FireServer(1) end
                        if SkillToggles.X then reqAbility:FireServer(2) end
                        if SkillToggles.C then reqAbility:FireServer(3) end
                        if SkillToggles.V then reqAbility:FireServer(4) end
                        if SkillToggles.F then reqAbility:FireServer(5) end
                    end
                end
            end)
        end
    end)

    -- Fast Auto Click Loop
    task.spawn(function()
        local RunService = game:GetService("RunService")
        while task.wait(0.01) do -- 100 TPS ultra fast click loop
            pcall(function()
                if State.AutoClickEnabled and (State.AutoFarmEnabled or State.AutoBossEnabled) then
                    local combat = ReplicatedStorage:FindFirstChild("CombatSystem")
                    local remotes = combat and combat:FindFirstChild("Remotes")
                    local reqHit = remotes and remotes:FindFirstChild("RequestHit")
                    if reqHit then
                        reqHit:FireServer()
                    end
                end
            end)
        end
    end)
end

-- [[ STARTUP EXECUTION ]]
Loader.Run(function()
    UIManager.Init()
    CreateTabs()
    UIManager.CreateToggle()
    
    -- Explicitly select Home tab on startup
    if Window.SelectTab then
        Window:SelectTab("Home")
    end

    InitSync()
    InitAutomation()

    WindUI:Notify({
        Title = "NattHUB",
        Content = "Script Loaded Successfully! Version: " .. Constants.VERSION,
        Duration = 5
    })
end)
