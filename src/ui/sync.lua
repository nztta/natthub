---@diagnostic disable: undefined-global
-- [[ NattHUB | UI Synchronization ]]
local Sync = {}

local Players = game:GetService("Players")

function Sync.Init(Project)
    local State = Project.State
    local Helpers = Project.Helpers
    local UI = Project.UI
    local Constants = Project.Constants
    
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

return Sync
