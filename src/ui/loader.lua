---@diagnostic disable: undefined-global
-- [[ NattHUB | UI Loader Animation ]]
local Loader = {}

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

function Loader.Run(config, callback)
    local LoaderGui = Instance.new("ScreenGui", PlayerGui)
    LoaderGui.Name = "NattHUB_Loader"
    LoaderGui.DisplayOrder = 10000

    local LoaderFrame = Instance.new("Frame", LoaderGui)
    LoaderFrame.BackgroundColor3 = Color3.fromRGB(3, 3, 5)
    LoaderFrame.Size = UDim2.fromScale(1, 1)

    local Blur = Instance.new("BlurEffect", Lighting)
    Blur.Size = 0

    local Logo = Instance.new("ImageLabel", LoaderFrame)
    Logo.BackgroundTransparency = 1
    Logo.AnchorPoint = Vector2.new(0.5, 0.5)
    Logo.Position = UDim2.fromScale(0.5, 0.5)
    Logo.Size = UDim2.fromOffset(140, 140)
    Logo.Image = config.LogoID

    local StatusTxt = Instance.new("TextLabel", LoaderFrame)
    StatusTxt.BackgroundTransparency = 1
    StatusTxt.Position = UDim2.new(0.5, 0, 0.5, 100)
    StatusTxt.AnchorPoint = Vector2.new(0.5, 0)
    StatusTxt.Size = UDim2.new(0, 300, 0, 30)
    StatusTxt.Font = Enum.Font.GothamMedium
    StatusTxt.TextColor3 = Color3.fromRGB(230, 230, 230)
    StatusTxt.TextSize = 14

    -- Animation
    local drift = TweenService:Create(Logo,
        TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Position = UDim2.fromScale(0.51, 0.51),
            Size = UDim2.fromOffset(150, 150)
        })
    drift:Play()
    TweenService:Create(Blur, TweenInfo.new(0.5), { Size = 24 }):Play()

    local steps = { "Initializing Assets...", "Syncing Player Data...", "Configuring Boss Farm...", "Welcome!" }
    for i, s in ipairs(steps) do
        StatusTxt.Text = s
        TweenService:Create(Logo, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            { Rotation = i * 360 }):Play()
        task.wait(0.8)
    end

    drift:Cancel()
    local fade = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    TweenService:Create(LoaderFrame, fade, { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Logo, fade, { ImageTransparency = 1 }):Play()
    TweenService:Create(StatusTxt, fade, { TextTransparency = 1 }):Play()
    TweenService:Create(Blur, fade, { Size = 0 }):Play()
    task.wait(0.8)

    if callback then callback() end
    
    LoaderGui:Destroy()
    Blur:Destroy()
end

return Loader
