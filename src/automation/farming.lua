---@diagnostic disable: undefined-global
-- [[ NattHUB | Farming Automation ]]
local Farming = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

function Farming.Init(Project)
    local State = Project.State
    local Helpers = Project.Helpers
    local Constants = Project.Constants
    
    -- [[ LOCAL HELPERS ]]
    local function GetActiveBoss()
        local npcContainer = workspace:FindFirstChild("NPCs")
        if not npcContainer then return nil end

        local function FindBossInFolder(folderName)
            local folder = npcContainer:FindFirstChild(folderName)
            if folder then
                local boss = folder:FindFirstChild("Boss")
                if boss and boss:FindFirstChild("HumanoidRootPart") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                    return boss
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
        for _, q in ipairs(Constants.QuestData) do
            if myLevel >= q.Min and myLevel <= q.Max then
                local containers = { workspace:FindFirstChild("ServiceNPCs"), workspace:FindFirstChild("NPCs"), workspace }
                for _, container in ipairs(containers) do
                    if container then
                        local npc = container:FindFirstChild(q.NPC)
                        if npc then return npc end
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
                if v and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local d = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
                        if d < dist then dist = d; closest = v end
                    end
                end
            end
            return closest
        end
        return nil
    end

    -- [[ MAIN LOOP ]]
    task.spawn(function()
        while task.wait(0.5) do
            if State.AutoBossEnabled then
                local boss = GetActiveBoss()
                if boss then
                    Project.UpdateStatus("Killing Boss: " .. boss.Parent.Name)
                    Helpers.To(boss.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0), true)
                    local hit = ReplicatedStorage:FindFirstChild("CombatSystem") and ReplicatedStorage.CombatSystem:FindFirstChild("Remotes") and ReplicatedStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
                    if hit then pcall(function() hit:FireServer() end) end
                else
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.Anchored = false end
                end
            elseif State.AutoFarmEnabled then
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local npc = GetQuestNPC()
                    
                    if not npc then
                        local myLevel = Helpers.GetCurrentLevel()
                        for _, q in ipairs(Constants.QuestData) do
                            if myLevel >= q.Min and myLevel <= q.Max then
                                Project.UpdateStatus("Warping to Island: " .. q.Island)
                                ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("TeleportToPortal"):FireServer(q.Island)
                                task.wait(3); break
                            end
                        end
                    end

                    if npc and npc:FindFirstChild("HumanoidRootPart") and (tick() - State.LastQuestClaimed > 5) then
                        Project.UpdateStatus("Accepting Quest: " .. npc.Name)
                        Helpers.To(npc.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0), true)
                        task.wait(0.5)
                        pcall(function() ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("QuestAccept"):FireServer(npc) end)
                        State.LastQuestClaimed = tick()
                    end

                    local target = GetTargetMob()
                    if target and target:FindFirstChild("HumanoidRootPart") then
                        Project.UpdateStatus("Farming: " .. target.Name)
                        Helpers.To(target.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0), true)
                        local hit = ReplicatedStorage:FindFirstChild("CombatSystem") and ReplicatedStorage.CombatSystem:FindFirstChild("Remotes") and ReplicatedStorage.CombatSystem.Remotes:FindFirstChild("RequestHit")
                        if hit then pcall(function() hit:FireServer() end) end
                    else
                        Project.UpdateStatus("Scanning Targets...")
                        Player.Character.HumanoidRootPart.Anchored = false
                    end
                else
                    Project.UpdateStatus("Waiting for Character...")
                end
            else
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.Anchored = false end
            end
        end
    end)
end

return Farming
