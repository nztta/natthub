-- [[ NattHUB | Sailor Piece ]]
-- Powered by WindUI Library
-- Created by Antigravity (Google DeepMind)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- [[ CONFIGURATION ]]
local Config = {
    Title = "NattHUB | Sailor Piece",
    Icon = "solar:cat-bold",
    LogoID = "rbxassetid://117953684635635",
    Version = "2.6.2",
}

-- [[ LOADING ANIMATION SYSTEM ]]
local LoaderGui = Instance.new("ScreenGui")
LoaderGui.Name = "NattHUB_Loader"
LoaderGui.Parent = PlayerGui
LoaderGui.DisplayOrder = 9999 -- Ensure it's above everything
LoaderGui.ResetOnSpawn = false

local LoaderFrame = Instance.new("Frame")
LoaderFrame.Name = "Loader"
LoaderFrame.Parent = LoaderGui
LoaderFrame.BackgroundColor3 = Color3.fromRGB(3, 3, 5)
LoaderFrame.Size = UDim2.fromScale(1, 1)

local LoaderLogo = Instance.new("ImageLabel")
LoaderLogo.Name = "Logo"
LoaderLogo.Parent = LoaderFrame
LoaderLogo.BackgroundTransparency = 1
LoaderLogo.AnchorPoint = Vector2.new(0.5, 0.5)
LoaderLogo.Position = UDim2.fromScale(0.5, 0.5)
LoaderLogo.Size = UDim2.fromOffset(140, 140)
LoaderLogo.Image = Config.LogoID

local LoaderText = Instance.new("TextLabel")
LoaderText.Name = "Status"
LoaderText.Parent = LoaderFrame
LoaderText.BackgroundTransparency = 1
LoaderText.Position = UDim2.new(0.5, 0, 0.5, 100)
LoaderText.AnchorPoint = Vector2.new(0.5, 0)
LoaderText.Size = UDim2.new(0, 300, 0, 30)
LoaderText.Font = Enum.Font.GothamMedium
LoaderText.Text = "Initializing NattHUB..."
LoaderText.TextColor3 = Color3.fromRGB(230, 230, 230)
LoaderText.TextSize = 14
LoaderText.TextTransparency = 0.5

-- [[ BLUR SYSTEM ]]
local Blur = Instance.new("BlurEffect")
Blur.Parent = Lighting
Blur.Size = 0

local function RunLoader(windowObj)
    -- Start Drift Animation (Concurrent)
    local driftInfo = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
    local driftTween = TweenService:Create(LoaderLogo, driftInfo, {
        Position = UDim2.fromScale(0.51, 0.51),
        Size = UDim2.fromOffset(150, 150)
    })
    driftTween:Play()

    -- Apply Blur
    TweenService:Create(Blur, TweenInfo.new(0.5), {Size = 24}):Play()

    -- Run Split Spin Animation
    local statuses = {
        "Loading Sailor Piece Assets...",
        "Connecting to Automation Engine...",
        "Finalizing UI Components..."
    }

    for i = 1, 3 do
        LoaderText.Text = statuses[i]
        local spinInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local spinTween = TweenService:Create(LoaderLogo, spinInfo, {Rotation = i * 360})
        spinTween:Play()
        spinTween.Completed:Wait()
        task.wait(0.75)
    end

    -- Fade Out Sequence
    driftTween:Cancel()
    local fadeInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    TweenService:Create(LoaderFrame, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoaderLogo, fadeInfo, {ImageTransparency = 1}):Play()
    TweenService:Create(LoaderText, fadeInfo, {TextTransparency = 1}):Play()
    TweenService:Create(Blur, fadeInfo, {Size = 0}):Play()
    
    task.wait(0.8)
    
    -- Show Window after loader fades
    if windowObj and windowObj.Instance then
        windowObj.Instance.Enabled = true
    end

    LoaderGui:Destroy()
    Blur:Destroy()
end

-- [[ WINDUI INITIALIZATION ]]
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = Config.Title,
    Icon = Config.LogoID,
    Author = "by Natt",
    Folder = "NattHUB_Wind_Settings",
    Size = UDim2.fromOffset(620, 500),
    Transparent = true, 
    Theme = "Dark",
    ButtonsType = "Mac",
})

-- Initially hide window (WindUI usually names the ScreenGui "WindUI" or matches Title)
-- We set it to Enabled = false immediately
if Window.Instance then
    Window.Instance.Enabled = false
end

-- Spawn loader with reference to window
task.spawn(RunLoader, Window)

-- [[ HOME TAB ]]
local HomeTab = Window:Tab({ Title = "Home", Icon = "solar:home-2-bold" })
local HomeMain = HomeTab:Section({ Title = "Dashboard" })
HomeMain:Paragraph({
    Title = "Welcome, " .. (Player.DisplayName or Player.Name) .. "!",
    Desc = "NattHUB is now initialized. This premium interface is designed for maximum speed and simplicity.",
})
HomeMain:Button({
    Title = "Join Discord",
    Desc = "discord.gg/natthub",
    Callback = function() setclipboard("https://discord.gg/natthub") end,
})

-- [[ ALL OTHER TABS ]]
local GeneralTab = Window:Tab({ Title = "General", Icon = "solar:settings-minimalistic-bold" })
local GenSec = GeneralTab:Section({ Title = "Player Helpers" })
GenSec:Toggle({ Title = "Auto Clicker", Value = false, Callback = function(v) end })
GenSec:Toggle({ Title = "Infinite Stamina", Value = false, Callback = function(v) end })

local MainTab = Window:Tab({ Title = "Main", Icon = "solar:star-bold" })
local MainFarm = MainTab:Section({ Title = "Fast Farming" })
MainFarm:Toggle({ 
    Title = "Auto Farm Level", 
    Desc = "Target quest-related enemies", 
    Value = false, 
    Callback = function(v) AutoFarmEnabled = v end 
})
MainFarm:Toggle({ Title = "Auto Collect Drops", Value = false, Callback = function(v) end })

local BossTab = Window:Tab({ Title = "Boss Farm", Icon = "solar:shield-danger-bold" })
local BossSec = BossTab:Section({ Title = "Legendary Encounters" })
BossSec:Dropdown({ Title = "Select Boss", Values = {"Lord Shura", "Void King", "Ancient Dragon"}, Callback = function(v) end })

local DungeonTab = Window:Tab({ Title = "Dungeon", Icon = "solar:ghost-bold" })
local DungSec = DungeonTab:Section({ Title = "Dungeon Raiding" })
DungSec:Toggle({ Title = "Auto Start Dungeon", Value = false, Callback = function(v) end })

local StatsTab = Window:Tab({ Title = "Auto Stats", Icon = "solar:chart-square-bold" })
local StatSec = StatsTab:Section({ Title = "Attribute Allocation" })
StatSec:Toggle({ Title = "Auto Strength", Value = false, Callback = function(v) end })

local QuestTab = Window:Tab({ Title = "Quest", Icon = "solar:notes-bold" })
local QuestSec = QuestTab:Section({ Title = "Quest Automation" })
QuestSec:Toggle({ 
    Title = "Auto Quest (Level Based)", 
    Value = false, 
    Callback = function(v) AutoQuestEnabled = v end 
})
QuestSec:Toggle({ Title = "Auto Complete Quest", Value = false, Callback = function(v) end })

local TeleportTab = Window:Tab({ Title = "Teleport", Icon = "solar:map-point-wave-bold" })
local WorldSec = TeleportTab:Section({ Title = "World Navigation" })
local Locations = {"Starter", "Jungle", "Desert", "Snow", "Sailor", "Shibuya", "HallowIsland", "Boss", "Dungeon", "Shijuku", "Slime", "Academy", "Kadgement", "Ninja", "Lawless", "Tower"}
WorldSec:Dropdown({
    Title = "Portal Destination",
    Values = Locations,
    Callback = function(v)
        local rem = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 5)
        if rem then
            local t = rem:WaitForChild("TeleportToPortal", 5)
            if t then t:FireServer(v) WindUI:Notify({ Title = "NattHUB", Content = "Teleported to " .. v }) end
        end
    end,
})

local MiscTab = Window:Tab({ Title = "Misc", Icon = "solar:box-bold" })
local MiscSec = MiscTab:Section({ Title = "Utilities" })
MiscSec:Button({ Title = "Anti-AFK", Callback = function() end })
MiscSec:Button({ Title = "Rejoin Server", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, Player) end })

local PlayerTab = Window:Tab({ Title = "Player", Icon = "solar:user-bold" })
PlayerTab:Section({ Title = "Identity" }):Paragraph({ Title = "DisplayName", Desc = Player.DisplayName })
local StatGrid = PlayerTab:Section({ Title = "Server" })
local PopLabel = StatGrid:Paragraph({ Title = "Population", Desc = #Players:GetPlayers() .. " / " .. Players.MaxPlayers })

local SettingTab = Window:Tab({ Title = "Setting Gui", Icon = "solar:palet-2-bold" })
local UISec = SettingTab:Section({ Title = "UI Customization" })
UISec:Button({ Title = "Reset UI Position", Callback = function() Window:ResetPosition() end })
UISec:Toggle({ Title = "Transparent Mode", Value = true, Callback = function(v) Window:SetTransparency(v) end })

-- [[ QUEST DATA ]]
local QuestData = {
    {Min = 0, Max = 99, NPC = "QuestNPC1"},
    {Min = 100, Max = 249, NPC = "QuestNPC2"},
    {Min = 250, Max = 499, NPC = "QuestNPC3"},
    {Min = 500, Max = 749, NPC = "QuestNPC4"},
    {Min = 750, Max = 999, NPC = "QuestNPC5"},
    {Min = 1000, Max = 1499, NPC = "QuestNPC6"},
    {Min = 1500, Max = 1999, NPC = "QuestNPC7"},
    {Min = 2000, Max = 2999, NPC = "QuestNPC8"},
    {Min = 3000, Max = 3999, NPC = "QuestNPC9"},
    {Min = 4000, Max = 5000, NPC = "QuestNPC10"},
    {Min = 5001, Max = 6250, NPC = "QuestNPC11"},
    {Min = 6251, Max = 7000, NPC = "QuestNPC12"},
    {Min = 7001, Max = 8000, NPC = "QuestNPC13"},
    {Min = 8001, Max = 9000, NPC = "QuestNPC14"},
    {Min = 9001, Max = 10000, NPC = "QuestNPC15"},
    {Min = 10001, Max = 10750, NPC = "QuestNPC16"},
    {Min = 10751, Max = 11500, NPC = "QuestNPC17"},
    {Min = 11501, Max = 12000, NPC = "QuestNPC18"},
    {Min = 12001, Max = 99999, NPC = "QuestNPC19"}
}

local function GetCurrentLevel()
    local stats = Player:FindFirstChild("leaderstats")
    if stats then
        local lv = stats:FindFirstChild("Level")
        if lv then return lv.Value end
    end
    return 0
end

local AutoQuestEnabled = false
task.spawn(function()
    while task.wait(5) do
        if AutoQuestEnabled then
            local myLevel = GetCurrentLevel()
            local targetNPCName = nil
            
            for _, q in ipairs(QuestData) do
                if myLevel >= q.Min and myLevel <= q.Max then
                    targetNPCName = q.NPC
                    break
                end
            end
            
            if targetNPCName then
                local npc = workspace.ServiceNPCs:FindFirstChild(targetNPCName)
                if npc then
                    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
                    if remotes then
                        local questAccept = remotes:FindFirstChild("QuestAccept")
                        if questAccept then
                            questAccept:FireServer(npc)
                            WindUI:Notify({ Title = "Auto Quest", Content = "Accepted quest from " .. targetNPCName, Duration = 2 })
                        end
                    end
                end
            end
        end
    end
end)

-- [[ FARMING DATA ]]
local MobMapping = {
    QuestNPC1 = "Thief",
    QuestNPC2 = "Thief Boss",
    QuestNPC3 = "Monkey",
    QuestNPC4 = "Monkey Boss",
    QuestNPC5 = "Desert Bandit",
    QuestNPC6 = "Desert Boss",
    QuestNPC7 = "Frost Rogue",
    QuestNPC8 = "Winter Warden",
    QuestNPC9 = "Sorcerer",
    QuestNPC10 = "Panda Boss",
    QuestNPC11 = "Hollow",
    QuestNPC12 = "Strong Sorcerer",
    QuestNPC13 = "Curse Hunter",
    QuestNPC14 = "Slime Warrior",
    QuestNPC15 = "Academy Teacher",
    QuestNPC16 = "Swordsman",
    QuestNPC17 = "Quincy",
    QuestNPC18 = "Ninja",
    QuestNPC19 = "Arena Fighter"
}

local function GetTargetMob()
    local myLevel = GetCurrentLevel()
    local targetName = nil
    
    for _, q in ipairs(QuestData) do
        if myLevel >= q.Min and myLevel <= q.Max then
            targetName = MobMapping[q.NPC]
            break
        end
    end
    
    if targetName then
        local closest = nil
        local dist = 1000000
        
        for _, v in ipairs(workspace:GetChildren()) do
            if v.Name == targetName and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                local d = (v.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = v
                end
            end
        end
        return closest
    end
    return nil
end

local AutoFarmEnabled = false
task.spawn(function()
    while task.wait() do
        if AutoFarmEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local target = GetTargetMob()
            if target and target:FindFirstChild("HumanoidRootPart") then
                -- Movement
                Player.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                
                -- Attack
                local rs = game:GetService("ReplicatedStorage")
                local combat = rs:FindFirstChild("CombatSystem")
                if combat then
                    local remotes = combat:FindFirstChild("Remotes")
                    if remotes then
                        local hit = remotes:FindFirstChild("RequestHit")
                        if hit then hit:FireServer() end
                    end
                end
            end
        end
    end
end)

-- [[ FINALIZATION ]]
local function UpdatePop()
    PopLabel:Set({ Title = "Population", Desc = #Players:GetPlayers() .. " / " .. Players.MaxPlayers })
end
Players.PlayerAdded:Connect(UpdatePop)
Players.PlayerRemoving:Connect(UpdatePop)

print("NattHUB | Full Suite Initialized")
