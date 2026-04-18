---@diagnostic disable: undefined-global
-- [[ NattHUB | Helper Functions ]]
local Helpers = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer

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
        local tween = TweenService:Create(hrp, TweenInfo.new(dist / 250, Enum.EasingStyle.Linear), { CFrame = targetCFrame })
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

return Helpers
