-- [[ NattHUB | UI Main Window ]]
local UIManager = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

function UIManager.Init(Project)
    local WindUI = (loadstring or load)(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
    local Config = Project.Constants.Config
    
    local Window = WindUI:CreateWindow({
        Title = Config.Title,
        Icon = Config.Icon,
        Author = Config.Author,
        Folder = Config.Folder,
        Theme = "Mellowsi",
        Size = UDim2.fromOffset(580, 460),
        Transparent = true,
        SideBarSize = 200
    })
    
    if Window.Instance then Window.Instance.Enabled = false end
    
    Project.Window = Window
    Project.WindUI = WindUI
    
    return Window
end

function UIManager.CreateToggle(Project)
    local Config = Project.Constants.Config
    local Window = Project.Window
    
    local ToggleGui = Instance.new("ScreenGui", PlayerGui)
    ToggleGui.Name = "NattHUB_Toggle"
    ToggleGui.ResetOnSpawn = false
    
    local ToggleBtn = Instance.new("ImageButton", ToggleGui)
    ToggleBtn.Size = UDim2.fromOffset(45, 45)
    ToggleBtn.Position = UDim2.new(0, 15, 0.5, -22)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    ToggleBtn.Image = Config.LogoID
    ToggleBtn.ScaleType = Enum.ScaleType.Fit
    
    local Corner = Instance.new("UICorner", ToggleBtn)
    Corner.CornerRadius = UDim.new(0, 10)
    
    local Stroke = Instance.new("UIStroke", ToggleBtn)
    Stroke.Color = Color3.fromRGB(50, 50, 70)
    Stroke.Thickness = 1.5
    
    ToggleBtn.MouseButton1Click:Connect(function()
        if Window.Instance then
            Window.Instance.Enabled = not Window.Instance.Enabled
            TweenService:Create(ToggleBtn, TweenInfo.new(0.2), { Rotation = Window.Instance.Enabled and 0 or 180 }):Play()
        end
    end)
    
    -- Draggable
    local dragging, dragStart, startPos
    ToggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = ToggleBtn.Position
        end
    end)
    ToggleBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

return UIManager
