-- NattHUB | Premium "Natt Dev" Website Aesthetic
-- Created by Antigravity (Google DeepMind)

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Configuration (Synced with natt-dev-three.vercel.app)
local Config = {
    DeepNavy = Color3.fromRGB(3, 3, 5),      -- Main Background
    GlassTop = Color3.fromRGB(30, 25, 50),   -- Frosted Violet
    GlassBottom = Color3.fromRGB(10, 10, 15),-- Dark Navy
    AccentBlue = Color3.fromRGB(37, 99, 235),-- Signature Blue Glow
    OffWhite = Color3.fromRGB(245, 245, 245),
    SecondaryText = Color3.fromRGB(160, 160, 175),
    Font = Enum.Font.GothamMedium,
    TitleFont = Enum.Font.GothamBold,
    LogoID = "rbxassetid://117953684635635",
    CornerRadius = UDim.new(0, 24),          -- Smooth modern corners
}

-- Blur Effect Logic
local function SetBlur(state)
    local blur = Lighting:FindFirstChild("NattHUB_Blur")
    if state then
        if not blur then
            blur = Instance.new("BlurEffect")
            blur.Name = "NattHUB_Blur"
            blur.Size = 25 -- Increased for premium look
            blur.Parent = Lighting
        end
    else
        if blur then blur:Destroy() end
    end
end

-- Utility: Apply Outer Glow System
local function ApplyOuterGlow(parent)
    local Glow = Instance.new("ImageLabel")
    Glow.Name = "Glow"
    Glow.Parent = parent
    Glow.BackgroundTransparency = 1
    Glow.BorderSizePixel = 0
    Glow.Position = UDim2.new(0, -30, 0, -30)
    Glow.Size = UDim2.new(1, 60, 1, 60)
    Glow.ZIndex = parent.ZIndex - 1
    Glow.Image = "rbxassetid://6015667110" -- Neon shadow sprite
    Glow.ImageColor3 = Config.AccentBlue
    Glow.ImageTransparency = 0.5
    Glow.ScaleType = Enum.ScaleType.Slice
    Glow.SliceCenter = Rect.new(49, 49, 450, 450)
    return Glow
end

-- Utility: Apply "Natt Dev" Glass Style
local function ApplyGlassEffect(frame, transparency)
    frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    frame.BackgroundTransparency = transparency or 0
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = Config.CornerRadius
    Corner.Parent = frame

    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(255, 255, 255)
    Stroke.Transparency = 0.92 -- Subtle border
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = frame
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Rotation = 90
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Config.GlassTop),
        ColorSequenceKeypoint.new(1, Config.GlassBottom)
    })
    Gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.3),
        NumberSequenceKeypoint.new(1, 0.1)
    })
    Gradient.Parent = frame
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NattHUB"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Loading Animation UI
local LoaderFrame = Instance.new("Frame")
LoaderFrame.Name = "Loader"
LoaderFrame.Parent = ScreenGui
LoaderFrame.BackgroundColor3 = Config.DeepNavy
LoaderFrame.Size = UDim2.new(1, 0, 1, 0)
LoaderFrame.ZIndex = 200

local LoaderLogo = Instance.new("ImageLabel")
LoaderLogo.Name = "Logo"
LoaderLogo.Parent = LoaderFrame
LoaderLogo.BackgroundTransparency = 1
LoaderLogo.AnchorPoint = Vector2.new(0.5, 0.5)
LoaderLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
LoaderLogo.Size = UDim2.new(0, 140, 0, 140)
LoaderLogo.Image = Config.LogoID
LoaderLogo.ZIndex = 201

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.Position = UDim2.new(0.5, -280, 0.5, -200)
Main.Size = UDim2.new(0, 560, 0, 400)
Main.BorderSizePixel = 0
Main.ClipsDescendants = false
Main.Visible = false
Main.ZIndex = 10
ApplyGlassEffect(Main)
ApplyOuterGlow(Main)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = Main
Sidebar.BackgroundColor3 = Config.DeepNavy
Sidebar.BackgroundTransparency = 0.3
Sidebar.Size = UDim2.new(0, 180, 1, 0)
Sidebar.BorderSizePixel = 0

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = Config.CornerRadius
SidebarCorner.Parent = Sidebar

-- Logo Branding
local LogoContainer = Instance.new("Frame")
LogoContainer.Name = "LogoContainer"
LogoContainer.Parent = Sidebar
LogoContainer.BackgroundTransparency = 1
LogoContainer.Position = UDim2.new(0, 0, 0, 30)
LogoContainer.Size = UDim2.new(1, 0, 0, 100)

local LogoCircle = Instance.new("Frame")
LogoCircle.Name = "Circle"
LogoCircle.Parent = LogoContainer
LogoCircle.BackgroundColor3 = Color3.fromRGB(255,255,255)
LogoCircle.Position = UDim2.new(0.5, -30, 0, 0)
LogoCircle.Size = UDim2.new(0, 60, 0, 60)

local LCCorner = Instance.new("UICorner")
LCCorner.CornerRadius = UDim.new(1, 0)
LCCorner.Parent = LogoCircle

local LCGradient = Instance.new("UIGradient")
LCGradient.Rotation = 45
LCGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Config.AccentBlue),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 92, 246)) -- Purple accent
})
LCGradient.Parent = LogoCircle

local LogoImage = Instance.new("ImageLabel")
LogoImage.Name = "LogoImage"
LogoImage.Parent = LogoCircle
LogoImage.BackgroundTransparency = 1
LogoImage.Size = UDim2.new(0.7, 0, 0.7, 0)
LogoImage.Position = UDim2.new(0.15, 0, 0.15, 0)
LogoImage.Image = Config.LogoID
LogoImage.ScaleType = Enum.ScaleType.Fit

local HubLabel = Instance.new("TextLabel")
HubLabel.Name = "HubLabel"
HubLabel.Parent = LogoContainer
HubLabel.BackgroundTransparency = 1
HubLabel.Position = UDim2.new(0, 0, 0, 65)
HubLabel.Size = UDim2.new(1, 0, 0, 30)
HubLabel.Font = Config.TitleFont
HubLabel.Text = "NattHUB"
HubLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HubLabel.TextSize = 20

-- Tab Container
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = Sidebar
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 15, 0, 130)
TabContainer.Size = UDim2.new(1, -30, 1, -150)
TabContainer.ScrollBarThickness = 0

local TabList = Instance.new("UIListLayout")
TabList.Parent = TabContainer
TabList.Padding = UDim.new(0, 10)

-- Content Area
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Parent = Main
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 200, 0, 30)
Content.Size = UDim2.new(1, -230, 1, -60)

-- Pages Container
local Pages = Instance.new("Folder")
Pages.Name = "Pages"
Pages.Parent = Content

-- Utility Functions
local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Parent = Pages
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Config.AccentBlue
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.Padding = UDim.new(0, 15)
    
    return Page
end

local ActiveTab = nil
local function SwitchTab(tabBtn, page)
    if ActiveTab == tabBtn then return end
    for _, p in pairs(Pages:GetChildren()) do p.Visible = false end
    page.Visible = true
    if ActiveTab then
        TweenService:Create(ActiveTab, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(ActiveTab.TextLabel, TweenInfo.new(0.3), {TextColor3 = Config.SecondaryText}):Play()
    end
    ActiveTab = tabBtn
    TweenService:Create(ActiveTab, TweenInfo.new(0.3), {BackgroundTransparency = 0.8}):Play()
    TweenService:Create(ActiveTab.TextLabel, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end

local function CreateTab(name, page)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = name.."Tab"
    TabBtn.Parent = TabContainer
    TabBtn.BackgroundColor3 = Config.AccentBlue
    TabBtn.BackgroundTransparency = 1
    TabBtn.Size = UDim2.new(1, 0, 0, 42)
    TabBtn.Text = ""
    TabBtn.AutoButtonColor = false
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = TabBtn
    local Label = Instance.new("TextLabel")
    Label.Parent = TabBtn
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Size = UDim2.new(1, -15, 1, 0)
    Label.Font = Config.Font
    Label.Text = name
    Label.TextColor3 = Config.SecondaryText
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.MouseButton1Click:Connect(function() SwitchTab(TabBtn, page) end)
    return TabBtn
end

local function CreateDropdown(parent, title, options, callback)
    local DropdownData = { Opened = false, Selected = options[1] or "Select...", Options = options }
    local Frame = Instance.new("Frame")
    Frame.Name = title.."Dropdown"
    Frame.Parent = parent
    Frame.BackgroundColor3 = Config.DeepNavy
    Frame.BackgroundTransparency = 0.4
    Frame.Size = UDim2.new(1, -30, 0, 45)
    Frame.Position = UDim2.new(0, 15, 0, 50)
    
    ApplyGlassEffect(Frame, 0.5)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Size = UDim2.new(1, -45, 1, 0)
    Label.Font = Config.Font
    Label.Text = DropdownData.Selected
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    local Arrow = Instance.new("TextLabel")
    Arrow.Parent = Frame
    Arrow.BackgroundTransparency = 1
    Arrow.Position = UDim2.new(1, -35, 0, 0)
    Arrow.Size = UDim2.new(0, 30, 1, 0)
    Arrow.Font = Config.Font
    Arrow.Text = "▼"
    Arrow.TextColor3 = Config.AccentBlue
    Arrow.TextSize = 12
    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Parent = Frame
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.Text = ""
    local OptionListContainer = Instance.new("Frame")
    OptionListContainer.Parent = parent
    OptionListContainer.BackgroundColor3 = Config.DeepNavy
    OptionListContainer.BackgroundTransparency = 0.2
    OptionListContainer.Position = UDim2.new(0, 15, 0, 105)
    OptionListContainer.Size = UDim2.new(1, -30, 0, 0)
    OptionListContainer.ClipsDescendants = true
    OptionListContainer.ZIndex = 20
    ApplyGlassEffect(OptionListContainer)
    local ScrollingOptions = Instance.new("ScrollingFrame")
    ScrollingOptions.Parent = OptionListContainer
    ScrollingOptions.BackgroundTransparency = 1
    ScrollingOptions.Size = UDim2.new(1, 0, 1, 0)
    ScrollingOptions.CanvasSize = UDim2.new(0, 0, 0, #options * 35)
    ScrollingOptions.ScrollBarThickness = 2
    ScrollingOptions.ScrollBarImageColor3 = Config.AccentBlue
    ScrollingOptions.ZIndex = 21
    local UIList = Instance.new("UIListLayout")
    UIList.Parent = ScrollingOptions
    local function Toggle()
        DropdownData.Opened = not DropdownData.Opened
        local targetSize = DropdownData.Opened and UDim2.new(1, -30, 0, math.min(#options * 35, 175)) or UDim2.new(1, -30, 0, 0)
        TweenService:Create(OptionListContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = targetSize}):Play()
        Arrow.Text = DropdownData.Opened and "▲" or "▼"
        TweenService:Create(parent, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 0, 130 + targetSize.Y.Offset)}):Play()
    end
    ClickBtn.MouseButton1Click:Connect(Toggle)
    for _, opt in pairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Parent = ScrollingOptions
        OptBtn.BackgroundTransparency = 1
        OptBtn.BorderSizePixel = 0
        OptBtn.Size = UDim2.new(1, 0, 0, 35)
        OptBtn.Font = Config.Font
        OptBtn.Text = "     " .. opt
        OptBtn.TextColor3 = Config.SecondaryText
        OptBtn.TextSize = 14
        OptBtn.TextXAlignment = Enum.TextXAlignment.Left
        OptBtn.ZIndex = 22
        OptBtn.MouseEnter:Connect(function() TweenService:Create(OptBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play() end)
        OptBtn.MouseLeave:Connect(function() TweenService:Create(OptBtn, TweenInfo.new(0.2), {TextColor3 = Config.SecondaryText}):Play() end)
        OptBtn.MouseButton1Click:Connect(function() DropdownData.Selected = opt Label.Text = opt Toggle() callback(opt) end)
    end
end

-- Section Container Generator
local function CreateSection(parent, title, height)
    local Sec = Instance.new("Frame")
    Sec.Name = title.."Section"
    Sec.Parent = parent
    Sec.BackgroundColor3 = Config.DeepNavy
    Sec.BackgroundTransparency = 0.5
    Sec.Size = UDim2.new(1, 0, 0, height or 130)
    ApplyGlassEffect(Sec, 0.4)
    local T = Instance.new("TextLabel")
    T.Parent = Sec
    T.BackgroundTransparency = 1
    T.Position = UDim2.new(0, 15, 0, 15)
    T.Size = UDim2.new(1, -30, 0, 20)
    T.Font = Config.TitleFont
    T.Text = title:upper()
    T.TextColor3 = Color3.fromRGB(255, 255, 255)
    T.TextSize = 14
    T.TextXAlignment = Enum.TextXAlignment.Left
    return Sec
end

-- Teleport Logic
local TeleportPage = CreatePage("Teleport")
local TeleportTab = CreateTab("Teleport", TeleportPage)
local WorldSec = CreateSection(TeleportPage, "World Teleport", 130)
local Locations = {"Starter", "Jungle", "Desert", "Snow", "Sailor", "Shibuya", "HallowIsland", "Boss", "Dungeon", "Shijuku", "Slime", "Academy", "Kadgement", "Ninja", "Lawless", "Tower"}
CreateDropdown(WorldSec, "Destination", Locations, function(sel)
    local rem = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 5)
    if rem then 
        local t = rem:WaitForChild("TeleportToPortal", 5)
        if t then t:FireServer(sel) end
    end
end)

-- Player Logic
local PlayerPage = CreatePage("Player")
local PlayerTab = CreateTab("Player", PlayerPage)
local ProfileSec = CreateSection(PlayerPage, "Professional Identity", 100)
local Avatar = Instance.new("ImageLabel", ProfileSec)
Avatar.BackgroundTransparency = 1
Avatar.Position = UDim2.new(0, 20, 0.5, -15)
Avatar.Size = UDim2.new(0, 60, 0, 60)
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
spawn(function()
    local thumb, success = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
    if success then Avatar.Image = thumb end
end)
local Welcome = Instance.new("TextLabel", ProfileSec)
Welcome.BackgroundTransparency = 1
Welcome.Position = UDim2.new(0, 95, 0, 45)
Welcome.Size = UDim2.new(1, -110, 0, 30)
Welcome.Font = Config.TitleFont
Welcome.TextSize = 18
Welcome.TextColor3 = Color3.fromRGB(255, 255, 255)
Welcome.TextXAlignment = Enum.TextXAlignment.Left
Welcome.Text = Player.DisplayName or Player.Name

local StatsSec = CreateSection(PlayerPage, "System Metadata", 180)
local function AddStat(parent, label, value, yOffset)
    local L = Instance.new("TextLabel", parent)
    L.BackgroundTransparency = 1
    L.Position = UDim2.new(0, 20, 0, yOffset)
    L.Size = UDim2.new(0, 100, 0, 25)
    L.Font = Config.Font
    L.Text = label .. ":"
    L.TextColor3 = Config.SecondaryText
    L.TextSize = 13
    L.TextXAlignment = Enum.TextXAlignment.Left
    local V = Instance.new("TextLabel", parent)
    V.BackgroundTransparency = 1
    V.Position = UDim2.new(0, 130, 0, yOffset)
    V.Size = UDim2.new(1, -150, 0, 25)
    V.Font = Config.Font
    V.Text = tostring(value)
    V.TextColor3 = Color3.fromRGB(255, 255, 255)
    V.TextSize = 13
    V.TextXAlignment = Enum.TextXAlignment.Left
    return V
end

AddStat(StatsSec, "Username", Player.Name, 45)
AddStat(StatsSec, "Account Age", Player.AccountAge .. " Days", 75)
local Pop = AddStat(StatsSec, "Active Players", #Players:GetPlayers() .. " / " .. Players.MaxPlayers, 105)
AddStat(StatsSec, "Server Identity", game.JobId:sub(1, 10), 135)
local function UpdatePop() Pop.Text = #Players:GetPlayers() .. " / " .. Players.MaxPlayers end
Players.PlayerAdded:Connect(UpdatePop)
Players.PlayerRemoving:Connect(UpdatePop)

-- Draggable
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true dragStart = input.Position startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    frame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
MakeDraggable(Main)

-- Toggle & Close
local Toggle = Instance.new("Frame", ScreenGui)
Toggle.Name = "ToggleButton"
Toggle.Size = UDim2.new(0, 60, 0, 60)
Toggle.Position = UDim2.new(0, 30, 0.5, -30)
Toggle.Visible = false
ApplyGlassEffect(Toggle, 0.5)
ApplyOuterGlow(Toggle)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
local ToggleImg = Instance.new("ImageLabel", Toggle)
ToggleImg.BackgroundTransparency = 1
ToggleImg.Size = UDim2.new(0.7, 0, 0.7, 0)
ToggleImg.Position = UDim2.new(0.15, 0, 0.15, 0)
ToggleImg.Image = Config.LogoID
local ToggleBtn = Instance.new("TextButton", Toggle)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.Text = ""
ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = true Toggle.Visible = false SetBlur(true) end)
MakeDraggable(Toggle)

local Close = Instance.new("TextButton", Main)
Close.BackgroundTransparency = 1
Close.Position = UDim2.new(1, -50, 0, 20)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Font = Config.Font
Close.Text = "✕"
Close.TextColor3 = Color3.fromRGB(240, 240, 240)
Close.TextSize = 20
Close.MouseButton1Click:Connect(function() Main.Visible = false Toggle.Visible = true SetBlur(false) end)

-- SEQUENCER
local function RunLoader()
    SetBlur(true)
    for i = 1, 3 do
        local rot = TweenService:Create(LoaderLogo, TweenInfo.new(1, Enum.EasingStyle.Linear), {Rotation = i * 360})
        rot:Play() rot.Completed:Wait()
    end
    TweenService:Create(LoaderFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoaderLogo, TweenInfo.new(0.8), {ImageTransparency = 1}):Play()
    wait(0.8)
    Main.Visible = true
    LoaderFrame:Destroy()
end

SwitchTab(TeleportTab, TeleportPage)
RunLoader()
print("NattHUB Reimagined!")
