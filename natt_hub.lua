-- [[ NattHUB | Modular Loader v4.0.0 ]]
-- Optimized & Modular Architecture
-- Created by Antigravity (Google DeepMind)

---@diagnostic disable: undefined-global
---@diagnostic disable: deprecated

local BASE_URL = "https://raw.githubusercontent.com/nztta/natthub/main/"
local DEV_MODE = false -- Set to true for local testing if needed

local function GetSource(path)
    local load = (loadstring or load)
    local url = BASE_URL .. path .. "?t=" .. tick()
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        return load(result)()
    else
        warn("NattHUB: Failed to load module -> " .. path)
        return nil
    end
end

-- [[ CORE INITIALIZATION ]]
local Project = {
    Constants = GetSource("src/constants.lua"),
    Helpers = GetSource("src/helpers.lua"),
    State = {
        AutoFarmEnabled = false,
        AutoStatsEnabled = false,
        AutoBossEnabled = false,
        SelectedBoss = "None",
        SelectedStat = "Melee",
        AllocateAmount = 1,
        BotStatus = "Ready",
        LastQuestClaimed = 0
    },
    UI = {
        BossLabels = {}
    }
}

function Project.UpdateStatus(text)
    Project.State.BotStatus = text
    if Project.UI.StatusLabel then
        Project.UI.StatusLabel:SetDesc(text)
    end
end

-- [[ LOAD MODULES ]]
local Loader = GetSource("src/ui/loader.lua")
local UIManager = GetSource("src/ui/main.lua")
local Tabs = GetSource("src/ui/tabs.lua")
local Sync = GetSource("src/ui/sync.lua")
local Farming = GetSource("src/automation/farming.lua")
local Stats = GetSource("src/automation/stats.lua")

-- [[ ROBUSTNESS CHECK ]]
if not (Loader and UIManager and Tabs and Sync and Farming and Stats) then
    warn("NattHUB: One or more modules failed to load. Script terminated.")
    return
end

-- [[ EXECUTION ]]
Project.Window = UIManager.Init(Project)
Tabs.Create(Project)
UIManager.CreateToggle(Project)
Sync.Init(Project)
Farming.Init(Project)
Stats.Init(Project)

-- Initial Status
Project.UpdateStatus("Ready")

-- Run Loader Animation (Final Step)
task.spawn(function()
    Loader.Run(Project.Constants.Config, function()
        if Project.Window and Project.Window.Instance then
            Project.Window.Instance.Enabled = true
            if Project.HomeTab then Project.HomeTab:Select() end
        end
    end)
end)

print("NattHUB | v4.0.0 Global Modular Release")
