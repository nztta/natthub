-- [[ NattHUB | Stats Automation ]]
local Stats = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function Stats.Init(Project)
    local State = Project.State
    
    task.spawn(function()
        while task.wait(0.5) do
            if State.AutoStatsEnabled then
                pcall(function()
                    ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("AllocateStat"):FireServer(State.SelectedStat, State.AllocateAmount)
                end)
            end
        end
    end)
end

return Stats
