-- [[ NattHUB | UI Tab Definitions ]]
local Tabs = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

function Tabs.Create(Project)
    local Window = Project.Window
    local WindUI = Project.WindUI
    local State = Project.State
    local Helpers = Project.Helpers
    local Constants = Project.Constants

    -- [[ HOME TAB ]]
    local HomeTab = Window:Tab({ Title = "Home", Icon = "solar:home-2-bold" })
    Project.HomeTab = HomeTab
    
    local PlayerSec = HomeTab:Section({ Title = "Player Information", Opened = true })
    Project.UI.LevelLabel = PlayerSec:Paragraph({ Title = "Level", Desc = "Loading..." })
    Project.UI.MoneyLabel = PlayerSec:Paragraph({ Title = "Currency", Desc = "0 Money | 0 Gems" })
    Project.UI.BountyLabel = PlayerSec:Paragraph({ Title = "Bounty", Desc = "0 Bounty" })
    Project.UI.PointsLabel = PlayerSec:Paragraph({ Title = "Stat Points", Desc = "0 Available" })
    
    local DashboardSec = HomeTab:Section({ Title = "Engine Status", Opened = true })
    Project.UI.StatusLabel = DashboardSec:Paragraph({ Title = "Bot Status", Desc = State.BotStatus })
    Project.UI.PopLabel = DashboardSec:Paragraph({ Title = "Players on Server", Desc = "Calculating..." })
    
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
            Project.UpdateStatus(v and "Farming..." or "Ready")
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
            Project.UpdateStatus(v and "Hunting Boss..." or "Ready")
        end
    })
    
    local BossTrackerSec = BossTab:Section({ Title = "Timed Boss Tracker", Opened = false })
    for _, boss in ipairs(Constants.BossConfig) do
        Project.UI.BossLabels[boss.Name] = BossTrackerSec:Paragraph({ Title = boss.Name, Desc = "Loading..." })
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
    StatSec:Toggle({ Title = "Auto Allocate", Value = State.AutoStatsEnabled, Callback = function(v) State.AutoStatsEnabled = v end })
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
end

return Tabs
