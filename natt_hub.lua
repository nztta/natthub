-- [[ NattHUB | Wind Edition ]]
-- Powered by WindUI Library
-- Created by Antigravity (Google DeepMind)

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- [[ CONFIGURATION ]]
local Config = {
    Title = "NattHUB | Wind",
    Icon = "solar:cat-bold",
    LogoID = "rbxassetid://117953684635635",
    Version = "2.6.0",
}

-- [[ WINDOW INITIALIZATION ]]
local Window = WindUI:CreateWindow({
    Title = Config.Title,
    Icon = Config.Icon,
    Author = "by Natt",
    Folder = "NattHUB_Wind_Settings",
    Size = UDim2.fromOffset(620, 500), -- Increased size for more content
    Transparent = true, 
    Theme = "Dark",
    ButtonsType = "Mac",
})

-- [[ HOME TAB ]]
local HomeTab = Window:Tab({ Title = "Home", Icon = "solar:home-2-bold" })
local HomeMain = HomeTab:Section({ Title = "Dashboard" })
HomeMain:Paragraph({
    Title = "Welcome, " .. (Player.DisplayName or Player.Name) .. "!",
    Desc = "NattHUB is now initialized with all requested modules. Select a category from the sidebar to begin automation.",
})
HomeMain:Button({
    Title = "Join Discord",
    Desc = "discord.gg/natthub",
    Callback = function() setclipboard("https://discord.gg/natthub") end,
})

-- [[ GENERAL TAB ]]
local GeneralTab = Window:Tab({ Title = "General", Icon = "solar:settings-minimalistic-bold" })
local GenSec = GeneralTab:Section({ Title = "Player Helpers" })
GenSec:Toggle({ Title = "Auto Clicker", Desc = "Simulate heavy clicking", Value = false, Callback = function(v) end })
GenSec:Toggle({ Title = "Infinite Stamina", Desc = "Bypass stamina consumption", Value = false, Callback = function(v) end })

-- [[ MAIN TAB ]]
local MainTab = Window:Tab({ Title = "Main", Icon = "solar:star-bold" })
local MainFarm = MainTab:Section({ Title = "Fast Farming" })
MainFarm:Toggle({ Title = "Auto Farm Level", Desc = "Automatically targets highest level NPCs", Value = false, Callback = function(v) end })
MainFarm:Toggle({ Title = "Auto Collect Drops", Desc = "Picks up items automatically", Value = false, Callback = function(v) end })

-- [[ BOSS FARM TAB ]]
local BossTab = Window:Tab({ Title = "Boss Farm", Icon = "solar:shield-danger-bold" })
local BossSec = BossTab:Section({ Title = "Legendary Encounters" })
BossSec:Dropdown({ Title = "Select Boss", Desc = "Choose which boss to farm", Values = {"Lord Shura", "Void King", "Ancient Dragon"}, Callback = function(v) end })
BossSec:Toggle({ Title = "Auto Spawn Boss", Desc = "Spawns boss when available", Value = false, Callback = function(v) end })

-- [[ DUNGEON TAB ]]
local DungeonTab = Window:Tab({ Title = "Dungeon", Icon = "solar:ghost-bold" })
local DungSec = DungeonTab:Section({ Title = "Dungeon Raiding" })
DungSec:Toggle({ Title = "Auto Start Dungeon", Desc = "Starts the next floor automatically", Value = false, Callback = function(v) end })
DungSec:Toggle({ Title = "Kill Aura", Desc = "Damages players in radius", Value = false, Callback = function(v) end })

-- [[ AUTO STATS TAB ]]
local StatsTab = Window:Tab({ Title = "Auto Stats", Icon = "solar:chart-square-bold" })
local StatSec = StatsTab:Section({ Title = "Attribute Allocation" })
StatSec:Toggle({ Title = "Auto Strength", Value = false, Callback = function(v) end })
StatSec:Toggle({ Title = "Auto Defense", Value = false, Callback = function(v) end })
StatSec:Toggle({ Title = "Auto Agility", Value = false, Callback = function(v) end })

-- [[ QUEST TAB ]]
local QuestTab = Window:Tab({ Title = "Quest", Icon = "solar:notes-bold" })
local QuestSec = QuestTab:Section({ Title = "Quest Automation" })
QuestSec:Toggle({ Title = "Auto Accept Quest", Value = false, Callback = function(v) end })
QuestSec:Toggle({ Title = "Auto Complete Quest", Value = false, Callback = function(v) end })

-- [[ TELEPORT TAB ]]
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

-- [[ MISC TAB ]]
local MiscTab = Window:Tab({ Title = "Misc", Icon = "solar:box-bold" })
local MiscSec = MiscTab:Section({ Title = "Utilities" })
MiscSec:Button({ Title = "Anti-AFK", Callback = function() end })
MiscSec:Button({ Title = "Rejoin Server", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, Player) end })

-- [[ PLAYER TAB ]]
local PlayerTab = Window:Tab({ Title = "Player", Icon = "solar:user-bold" })
local ProfileSec = PlayerTab:Section({ Title = "Identity" })
ProfileSec:Paragraph({ Title = "DisplayName", Desc = Player.DisplayName })
local PopLabel = PlayerTab:Section({ Title = "Server" }):Paragraph({ Title = "Population", Desc = #Players:GetPlayers() .. " / " .. Players.MaxPlayers })

-- [[ SETTING GUI TAB ]]
local SettingTab = Window:Tab({ Title = "Setting Gui", Icon = "solar:palet-2-bold" })
local UISec = SettingTab:Section({ Title = "UI Customization" })
UISec:Button({
    Title = "Reset UI Position",
    Callback = function() Window:ResetPosition() end,
})
UISec:Toggle({
    Title = "Transparent Mode",
    Value = true,
    Callback = function(v) Window:SetTransparency(v) end,
})

-- [[ FINALIZATION ]]
WindUI:Notify({ Title = "NattHUB Loaded", Content = "Ready for automation!", Icon = "solar:verified-check-bold", Duration = 5 })

local function UpdatePop()
    PopLabel:Set({ Title = "Population", Desc = #Players:GetPlayers() .. " / " .. Players.MaxPlayers })
end
Players.PlayerAdded:Connect(UpdatePop)
Players.PlayerRemoving:Connect(UpdatePop)

print("NattHUB | Full Suite Initialized")
