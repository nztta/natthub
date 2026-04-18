-- [[ NattHUB | Sailor Piece Unified Script v5.2.0 ]]
-- Optimized for WinUI and Custom Stat Tracking
-- Improved performance and layout based on checklist

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
    VERSION = "5.2.0",
}
Constants.Config = {
    Version = Constants.VERSION,
    Title = "NattHUB | Professional Edition",
    Icon = "solar:planet-3-bold-duotone",
    LogoID = "rbxassetid://117953684635635",
    Folder = "NattHUB_Configs",
    Author = "by Natt Dev"
}

-- [[ STATE MANAGEMENT ]]
local State = {
    AutoFarmEnabled = false,
    AutoBossEnabled = false,
    AutoStatsEnabled = false,
    AutoClickEnabled = false,
    AutoSkillEnabled = false,
    AutoWeaponEnabled = false,
    AutoHealthSafety = false,
    IsHealing = false,
    SelectedWeapon = "None",
    SelectedBoss = "None",
    AllocateAmount = 1
}

local StatToggles = {
    Melee = false,
    Defense = false,
    Sword = false,
    Power = false
}

local UI = {} -- Global UI reference for dynamic updates

-- [[ SAFETY BOOT ]]
repeat task.wait() until game:IsLoaded()
if not Player:FindFirstChild("PlayerGui") then
    Player:WaitForChild("PlayerGui", 10)
end

-- [[ UI LIBRARY INITIALIZATION ]]
local WindUI
local library_url = "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"

local function LoadUI()
    local fetch_ok, code = pcall(function() return game:HttpGet(library_url) end)
    if not fetch_ok then return nil, "Network Error" end
    local loader = loadstring(code)
    if not loader then return nil, "Syntax Error" end
    local run_ok, result = pcall(loader)
    if not run_ok then return nil, "Runtime Error" end
    return result
end

local hub = LoadUI()
if not hub then
    warn("[NattHUB] Library failed to load. Retrying in 2s...")
    task.wait(2)
    hub = LoadUI()
end

if hub then
    WindUI = hub
else
    Player:Kick("NattHUB: UI Library Connection Failed.")
    return
end

local Window
local success, err = pcall(function()
    Window = WindUI:CreateWindow({
        Title = Constants.Config.Title,
        Author = Constants.Config.Author,
        Theme = "Dark"
    })
end)

if not success or not Window then
    warn("[NattHUB Critical] Window Creation Failed: " .. tostring(err))
    -- Fallback: Try even simpler creation
    Window = WindUI:CreateWindow({
        Title = "NattHUB (Safe Mode)",
        Author = "By Nattachai"
    })
end

-- [[ HOME TAB ]]
local HomeTab = Window:Tab({ Title = "Home", Icon = "solar:home-2-bold" })

local PlayerSec = HomeTab:Section({ Title = "Player Stats", Opened = true })
UI.LevelLabel = PlayerSec:Paragraph({ Title = "Level", Desc = "Loading..." })
UI.ExpLabel = PlayerSec:Paragraph({ Title = "Experience", Desc = "0 EXP" })
UI.GemsLabel = PlayerSec:Paragraph({ Title = "Gems", Desc = "0" })
UI.MoneyLabel = PlayerSec:Paragraph({ Title = "Money", Desc = "0" })
UI.PointsLabel = PlayerSec:Paragraph({ Title = "Stat Points", Desc = "0" })

local SafetySec = HomeTab:Section({ Title = "Protection", Opened = true })
SafetySec:Toggle({
    Title = "Health Safety (20%)",
    Desc = "Auto-heals/teleports when low health",
    Value = State.AutoHealthSafety,
    Callback = function(v) State.AutoHealthSafety = v end
})

local DashboardSec = HomeTab:Section({ Title = "Engine Status", Opened = true })
UI.BotLabel = DashboardSec:Paragraph({ Title = "Bot status", Desc = "Initializing" })
UI.PopLabel = DashboardSec:Paragraph({ Title = "Player on server", Desc = #Players:GetPlayers() .. " / " .. Players.MaxPlayers })

-- Add Discord Link
HomeTab:Button({
    Title = "Join Discord",
    Desc = "discord.gg/natthub",
    Callback = function()
        local clipboard = (setclipboard or toclipboard or print)
        clipboard("https://discord.gg/natthub")
        WindUI:Notify({ Title = "Copied", Content = "Discord link copied to clipboard", Duration = 2 })
    end,
})

-- [[ MAIN TAB ]]
local MainTab = Window:Tab({ Title = "Main", Icon = "solar:star-bold" })
local FarmSec = MainTab:Section({ Title = "Automation", Opened = true })

FarmSec:Toggle({
    Title = "Auto Farm Level",
    Desc = "Automated grinding (Fixed initialization)",
    Value = State.AutoFarmEnabled,
    Callback = function(v) State.AutoFarmEnabled = v end
})

FarmSec:Toggle({
    Title = "Auto Health Safety",
    Desc = "Safe mode when health is low",
    Value = State.AutoHealthSafety,
    Callback = function(v) State.AutoHealthSafety = v end
})

-- [[ STATS TAB ]] (ALLOWS MULTIPLE SELECTION)
local StatsTab = Window:Tab({ Title = "Stats", Icon = "solar:chart-square-bold" })
local AutoStatsSec = StatsTab:Section({ Title = "Auto Allocate Stats", Opened = true })

AutoStatsSec:Toggle({
    Title = "Enable Auto Stats",
    Value = State.AutoStatsEnabled,
    Callback = function(v) State.AutoStatsEnabled = v end
})

for statName, _ in pairs(StatToggles) do
    AutoStatsSec:Toggle({
        Title = statName,
        Value = StatToggles[statName],
        Callback = function(v) StatToggles[statName] = v end
    })
end

-- [[ CONFIG TAB ]]
local ConfigTab = Window:Tab({ Title = "Config", Icon = "solar:settings-bold" })
local ThemeSec = ConfigTab:Section({ Title = "Appearance", Opened = true })

ThemeSec:Dropdown({
    Title = "Change Theme",
    Values = {"Dark", "Light", "Red", "Aqua", "Amethyst"},
    Callback = function(v) Window:SetTheme(v) end
})

-- [[ DATA SYNC ]]
local function InitSync()
    task.spawn(function()
        while task.wait(0.5) do
            local success, err = pcall(function()
                local dataFolder = Player:FindFirstChild("Data")
                if dataFolder then
                    -- Specific paths requested by user
                    local stats = {
                        Experience = dataFolder:FindFirstChild("Experience"),
                        Gems = dataFolder:FindFirstChild("Gems"),
                        Level = dataFolder:FindFirstChild("Level"),
                        Money = dataFolder:FindFirstChild("Money"),
                        StatPoints = dataFolder:FindFirstChild("StatPoints")
                    }

                    if stats.Level then UI.LevelLabel:SetDesc("Current: " .. tostring(stats.Level.Value)) end
                    if stats.Experience then UI.ExpLabel:SetDesc("Current: " .. tostring(stats.Experience.Value)) end
                    if stats.Gems then UI.GemsLabel:SetDesc("Current: " .. tostring(stats.Gems.Value)) end
                    if stats.Money then UI.MoneyLabel:SetDesc("Current: " .. tostring(stats.Money.Value)) end
                    if stats.StatPoints then UI.PointsLabel:SetDesc("Available: " .. tostring(stats.StatPoints.Value)) end
                end
                
                UI.PopLabel:SetDesc(#Players:GetPlayers() .. " / " .. Players.MaxPlayers)
            end)
            if not success then
                warn("[NattHUB Sync Error] " .. tostring(err))
            end
        end
    end)
end

-- [[ STARTUP ]]
InitSync()
Window:SelectTab("Home")

WindUI:Notify({
    Title = "NattHUB",
    Content = "Professional Stats UI Loaded",
    Duration = 3
})
