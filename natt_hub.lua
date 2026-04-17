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
    Version = "2.5.0",
}

-- [[ WINDOW INITIALIZATION ]]
local Window = WindUI:CreateWindow({
    Title = Config.Title,
    Icon = Config.Icon,
    Author = "by Natt",
    Folder = "NattHUB_Wind_Settings",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true, 
    Theme = "Dark", -- Standard Dark theme for that navy feel
    ButtonsType = "Mac", -- Premium Mac-style window controls
})

-- [[ HOME TAB ]]
local HomeTab = Window:Tab({
    Title = "Home",
    Icon = "solar:home-2-bold",
})

local HomeMain = HomeTab:Section({
    Title = "Welcome to NattHUB",
})

HomeMain:Paragraph({
    Title = "Welcome, " .. (Player.DisplayName or Player.Name) .. "!",
    Desc = "You are currently running NattHUB Wind Edition. This version features ultra-smooth animations and glassmorphism powered by WindUI.",
})

HomeMain:Button({
    Title = "Join Discord",
    Desc = "Get the latest updates and support",
    Callback = function()
        setclipboard("https://discord.gg/natthub") -- Standard utility
        WindUI:Notify({
            Title = "NattHUB",
            Content = "Discord link copied to clipboard!",
            Icon = "solar:copy-bold",
            Duration = 3,
        })
    end,
})

-- [[ TELEPORT TAB ]]
local TeleportTab = Window:Tab({
    Title = "Teleport",
    Icon = "solar:map-point-wave-bold",
})

local WorldSec = TeleportTab:Section({
    Title = "World Navigation",
})

local Locations = {"Starter", "Jungle", "Desert", "Snow", "Sailor", "Shibuya", "HallowIsland", "Boss", "Dungeon", "Shijuku", "Slime", "Academy", "Kadgement", "Ninja", "Lawless", "Tower"}

WorldSec:Dropdown({
    Title = "Portal Destination",
    Desc = "Select a world to teleport your character using the game's portal system.",
    Values = Locations,
    Value = "Select...",
    Callback = function(selected)
        local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 5)
        if remotes then
            local remote = remotes:WaitForChild("TeleportToPortal", 5)
            if remote then 
                remote:FireServer(selected) 
                WindUI:Notify({
                    Title = "Teleporting",
                    Content = "Initiating portal sequence to: " .. selected,
                    Icon = "solar:clapperboard-play-bold-duotone",
                    Duration = 4,
                })
            else
                WindUI:Notify({
                    Title = "Error",
                    Content = "Teleport remote not found in this game.",
                    Icon = "solar:danger-bold",
                    Duration = 5,
                })
            end
        end
    end,
})

-- [[ PLAYER TAB ]]
local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "solar:user-bold",
})

local IdentitySec = PlayerTab:Section({
    Title = "Identity Metadata",
})

IdentitySec:Paragraph({
    Title = "DisplayName",
    Desc = Player.DisplayName,
})

IdentitySec:Paragraph({
    Title = "Account Username",
    Desc = Player.Name,
})

local ServerSec = PlayerTab:Section({
    Title = "Server Infrastructure",
})

-- Dynamic Population Label
local PopLabel = ServerSec:Paragraph({
    Title = "Active Population",
    Desc = #Players:GetPlayers() .. " / " .. Players.MaxPlayers .. " Players",
})

ServerSec:Paragraph({
    Title = "Server JobID",
    Desc = game.JobId:sub(1, 15) .. "...",
})

-- Real-time update logic
local function UpdatePop()
    PopLabel:Set({
        Title = "Active Population",
        Desc = #Players:GetPlayers() .. " / " .. Players.MaxPlayers .. " Players",
    })
end

Players.PlayerAdded:Connect(UpdatePop)
Players.PlayerRemoving:Connect(UpdatePop)

-- [[ FINALIZATION ]]
WindUI:Notify({
    Title = "NattHUB Loaded",
    Content = "Welcome back, " .. Player.Name .. "!",
    Icon = "solar:verified-check-bold",
    Duration = 5,
})

print("NattHUB | Wind Edition Initialized Successfully")
