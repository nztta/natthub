-- NattHUB | Premium Glassmorphism UI
-- Created by Antigravity (Google DeepMind)

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Configuration
local Config = {
    OffBlack = Color3.fromRGB(15, 15, 15),
    OffWhite = Color3.fromRGB(245, 245, 245),
    AccentWhite = Color3.fromRGB(255, 255, 255),
    GlassTransparency = 0.35,
    SidebarTransparency = 0.25,
    Font = Enum.Font.GothamMedium,
    TitleFont = Enum.Font.GothamBold,
    LogoID = "rbxassetid://117953684635635",
}

-- Blur Effect Logic
local function SetBlur(state)
    local blur = Lighting:FindFirstChild("NattHUB_Blur")
    if state then
        if not blur then
            blur = Instance.new("BlurEffect")
            blur.Name = "NattHUB_Blur"
            blur.Size = 20
            blur.Parent = Lighting
        end
    else
        if blur then blur:Destroy() end
    end
end

-- Utility: Apply Glass Style
local function ApplyGlassEffect(frame, transparency)
    frame.BackgroundTransparency = transparency or Config.GlassTransparency
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Config.AccentWhite
    Stroke.Transparency = 0.8
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = frame
    
    local Gradient = Instance.new("UIGradient")
    Gradient.Rotation = 45
    Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
    })
    Gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.9),
        NumberSequenceKeypoint.new(1, 1)
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
LoaderFrame.BackgroundColor3 = Config.OffBlack
LoaderFrame.BackgroundTransparency = 0.2
LoaderFrame.Size = UDim2.new(1, 0, 1, 0)
LoaderFrame.ZIndex = 100

local LoaderLogo = Instance.new("ImageLabel")
LoaderLogo.Name = "Logo"
LoaderLogo.Parent = LoaderFrame
LoaderLogo.BackgroundTransparency = 1
LoaderLogo.AnchorPoint = Vector2.new(0.5, 0.5)
LoaderLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
LoaderLogo.Size = UDim2.new(0, 120, 0, 120)
LoaderLogo.Image = Config.LogoID
LoaderLogo.ZIndex = 101

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Config.OffBlack
Main.Position = UDim2.new(0.5, -260, 0.5, -185)
Main.Size = UDim2.new(0, 520, 0, 370)
Main.BorderSizePixel = 0
Main.ClipsDescendants = false -- FIX: Disabled clipping for dropdowns
Main.Visible = false
ApplyGlassEffect(Main)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = Main
Sidebar.BackgroundColor3 = Config.OffBlack
Sidebar.BackgroundTransparency = 0.4
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BorderSizePixel = 0

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 14)
SidebarCorner.Parent = Sidebar

-- Logo Branding
local LogoContainer = Instance.new("Frame")
LogoContainer.Name = "LogoContainer"
LogoContainer.Parent = Sidebar
LogoContainer.BackgroundTransparency = 1
LogoContainer.Position = UDim2.new(0, 0, 0, 20)
LogoContainer.Size = UDim2.new(1, 0, 0, 80)

local LogoCircle = Instance.new("Frame")
LogoCircle.Name = "Circle"
LogoCircle.Parent = LogoContainer
LogoCircle.BackgroundColor3 = Config.OffWhite
LogoCircle.BackgroundTransparency = 0.9
LogoCircle.Position = UDim2.new(0.5, -25, 0, 0)
LogoCircle.Size = UDim2.new(0, 50, 0, 50)

local LCCorner = Instance.new("UICorner")
LCCorner.CornerRadius = UDim.new(1, 0)
LCCorner.Parent = LogoCircle

local LCStroke = Instance.new("UIStroke")
LCStroke.Thickness = 2
LCStroke.Color = Config.OffWhite
LCStroke.Transparency = 0.5
LCStroke.Parent = LogoCircle

local LogoImage = Instance.new("ImageLabel")
LogoImage.Name = "LogoImage"
LogoImage.Parent = LogoCircle
LogoImage.BackgroundTransparency = 1
LogoImage.Size = UDim2.new(0.7, 0, 0.7, 0)
LogoImage.Position = UDim2.new(0.15, 0, 0.15, 0)
LogoImage.Image = Config.LogoID
LogoImage.ScaleType = Enum.ScaleType.Fit
LogoImage.Visible = (Config.LogoID ~= "rbxassetid://0")

local LogoText = Instance.new("TextLabel")
LogoText.Parent = LogoCircle
LogoText.BackgroundTransparency = 1
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.Font = Config.TitleFont
LogoText.Text = "N"
LogoText.TextColor3 = Config.OffWhite
LogoText.TextSize = 24
LogoText.Visible = (Config.LogoID == "rbxassetid://0")

local HubLabel = Instance.new("TextLabel")
HubLabel.Name = "HubLabel"
HubLabel.Parent = LogoContainer
HubLabel.BackgroundTransparency = 1
HubLabel.Position = UDim2.new(0, 0, 0, 55)
HubLabel.Size = UDim2.new(1, 0, 0, 20)
HubLabel.Font = Config.TitleFont
HubLabel.Text = "NattHUB"
HubLabel.TextColor3 = Config.OffWhite
HubLabel.TextSize = 16

-- Tab Container
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = Sidebar
TabContainer.BackgroundTransparency = 1
TabContainer.Position = UDim2.new(0, 10, 0, 100)
TabContainer.Size = UDim2.new(1, -20, 1, -110)
TabContainer.ScrollBarThickness = 0

local TabList = Instance.new("UIListLayout")
TabList.Parent = TabContainer
TabList.Padding = UDim.new(0, 8)

-- Content Area
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Parent = Main
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 175, 0, 20)
Content.Size = UDim2.new(1, -195, 1, -40)

-- Pages
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
    Page.ScrollBarThickness = 1
    Page.ScrollBarImageColor3 = Config.OffWhite
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y -- FIX: Grow canvas automatically
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.Padding = UDim.new(0, 12)
    
    return Page
end

local ActiveTab = nil
local function SwitchTab(tabBtn, page)
    if ActiveTab == tabBtn then return end
    for _, p in pairs(Pages:GetChildren()) do p.Visible = false end
    page.Visible = true
    if ActiveTab then
        TweenService:Create(ActiveTab, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(ActiveTab.TextLabel, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
    end
    ActiveTab = tabBtn
    TweenService:Create(ActiveTab, TweenInfo.new(0.3), {BackgroundTransparency = 0.8}):Play()
    TweenService:Create(ActiveTab.TextLabel, TweenInfo.new(0.3), {TextColor3 = Config.OffWhite}):Play()
end

local function CreateTab(name, page)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = name.."Tab"
    TabBtn.Parent = TabContainer
    TabBtn.BackgroundColor3 = Config.OffWhite
    TabBtn.BackgroundTransparency = 1
    TabBtn.Size = UDim2.new(1, 0, 0, 38)
    TabBtn.Text = ""
    TabBtn.AutoButtonColor = false
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = TabBtn
    local Label = Instance.new("TextLabel")
    Label.Parent = TabBtn
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.Size = UDim2.new(1, -12, 1, 0)
    Label.Font = Config.Font
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(180, 180, 180)
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
    Frame.BackgroundColor3 = Config.OffBlack
    Frame.BackgroundTransparency = 0.5
    Frame.Position = UDim2.new(0, 15, 0, 45)
    Frame.Size = UDim2.new(1, -30, 0, 42)
    Frame.ZIndex = 5
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Color = Config.OffWhite
    Stroke.Transparency = 0.8
    Stroke.Parent = Frame
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Size = UDim2.new(1, -45, 1, 0)
    Label.Font = Config.Font
    Label.Text = DropdownData.Selected
    Label.TextColor3 = Config.OffWhite
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    local Arrow = Instance.new("TextLabel")
    Arrow.Parent = Frame
    Arrow.BackgroundTransparency = 1
    Arrow.Position = UDim2.new(1, -35, 0, 0)
    Arrow.Size = UDim2.new(0, 30, 1, 0)
    Arrow.Font = Config.Font
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
    Arrow.TextSize = 12
    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Parent = Frame
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.Text = ""
    local OptionListContainer = Instance.new("Frame")
    OptionListContainer.Parent = parent
    OptionListContainer.BackgroundColor3 = Config.OffBlack
    OptionListContainer.BackgroundTransparency = 0.4
    OptionListContainer.Position = UDim2.new(0, 15, 0, 95)
    OptionListContainer.Size = UDim2.new(1, -30, 0, 0)
    OptionListContainer.ClipsDescendants = true
    OptionListContainer.ZIndex = 10 -- FIX: Higher ZIndex
    local OLCorner = Instance.new("UICorner")
    OLCorner.CornerRadius = UDim.new(0, 8)
    OLCorner.Parent = OptionListContainer
    local OLStroke = Instance.new("UIStroke")
    OLStroke.Thickness = 1
    OLStroke.Color = Config.OffWhite
    OLStroke.Transparency = 0.8
    OLStroke.Parent = OptionListContainer
    local ScrollingOptions = Instance.new("ScrollingFrame")
    ScrollingOptions.Parent = OptionListContainer
    ScrollingOptions.BackgroundTransparency = 1
    ScrollingOptions.Size = UDim2.new(1, 0, 1, 0)
    ScrollingOptions.CanvasSize = UDim2.new(0, 0, 0, #options * 32)
    ScrollingOptions.ScrollBarThickness = 2
    ScrollingOptions.ScrollBarImageColor3 = Config.OffWhite
    ScrollingOptions.ZIndex = 11
    local UIList = Instance.new("UIListLayout")
    UIList.Parent = ScrollingOptions
    local function Toggle()
        DropdownData.Opened = not DropdownData.Opened
        local targetSize = DropdownData.Opened and UDim2.new(1, -30, 0, math.min(#options * 32, 160)) or UDim2.new(1, -30, 0, 0)
        local targetArrow = DropdownData.Opened and "▲" or "▼"
        TweenService:Create(OptionListContainer, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Size = targetSize}):Play()
        Arrow.Text = targetArrow
        TweenService:Create(parent, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Size = UDim2.new(1, 0, 0, 120 + targetSize.Y.Offset)}):Play()
    end
    ClickBtn.MouseButton1Click:Connect(Toggle)
    for _, opt in pairs(options) do
        local OptBtn = Instance.new("TextButton")
        OptBtn.Parent = ScrollingOptions
        OptBtn.BackgroundTransparency = 1
        OptBtn.BorderSizePixel = 0
        OptBtn.Size = UDim2.new(1, 0, 0, 32)
        OptBtn.Font = Config.Font
        OptBtn.Text = "     " .. opt
        OptBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
        OptBtn.TextSize = 13
        OptBtn.TextXAlignment = Enum.TextXAlignment.Left
        OptBtn.ZIndex = 12
        OptBtn.MouseEnter:Connect(function() TweenService:Create(OptBtn, TweenInfo.new(0.2), {TextColor3 = Config.OffWhite}):Play() end)
        OptBtn.MouseLeave:Connect(function() TweenService:Create(OptBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play() end)
        OptBtn.MouseButton1Click:Connect(function() DropdownData.Selected = opt Label.Text = opt Toggle() callback(opt) end)
    end
end

-- Pages Setup
local TeleportPage = CreatePage("Teleport")
local TeleportTab = CreateTab("Teleport", TeleportPage)
local TeleportContainer = Instance.new("Frame")
TeleportContainer.Name = "TeleportContainer"
TeleportContainer.Parent = TeleportPage
TeleportContainer.BackgroundColor3 = Config.OffBlack
TeleportContainer.BackgroundTransparency = 0.6
TeleportContainer.Size = UDim2.new(1, 0, 0, 120)
local ContainerCorner = Instance.new("UICorner")
ContainerCorner.CornerRadius = UDim.new(0, 10)
ContainerCorner.Parent = TeleportContainer
local ContainerStroke = Instance.new("UIStroke")
ContainerStroke.Thickness = 1
ContainerStroke.Color = Config.OffWhite
ContainerStroke.Transparency = 0.9
ContainerStroke.Parent = TeleportContainer
local SectionTitle = Instance.new("TextLabel")
SectionTitle.Name = "Title"
SectionTitle.Parent = TeleportContainer
SectionTitle.BackgroundTransparency = 1
SectionTitle.Position = UDim2.new(0, 15, 0, 12)
SectionTitle.Size = UDim2.new(1, -30, 0, 20)
SectionTitle.Font = Config.TitleFont
SectionTitle.Text = "WORLD TELEPORT"
SectionTitle.TextColor3 = Config.OffWhite
SectionTitle.TextSize = 14
SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

local Locations = {"Starter", "Jungle", "Desert", "Snow", "Sailor", "Shibuya", "HallowIsland", "Boss", "Dungeon", "Shijuku", "Slime", "Academy", "Kadgement", "Ninja", "Lawless", "Tower"}
CreateDropdown(TeleportContainer, "Destination", Locations, function(selected)
    local args = { [1] = selected }
    local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 5)
    if remotes then
        local remote = remotes:WaitForChild("TeleportToPortal", 5)
        if remote then remote:FireServer(unpack(args)) end
    end
end)

local PlayerPage = CreatePage("Player")
local PlayerTab = CreateTab("Player", PlayerPage)
local AvatarFrame = Instance.new("Frame")
AvatarFrame.Parent = PlayerPage
AvatarFrame.BackgroundColor3 = Config.OffBlack
AvatarFrame.BackgroundTransparency = 0.6
AvatarFrame.Size = UDim2.new(1, 0, 0, 80)
local AFCorner = Instance.new("UICorner")
AFCorner.CornerRadius = UDim.new(0, 10)
AFCorner.Parent = AvatarFrame
local AFStroke = Instance.new("UIStroke")
AFStroke.Thickness = 1
AFStroke.Color = Config.OffWhite
AFStroke.Transparency = 0.9
AFStroke.Parent = AvatarFrame
local AvatarCircle = Instance.new("ImageLabel")
AvatarCircle.Name = "Avatar"
AvatarCircle.Parent = AvatarFrame
AvatarCircle.BackgroundTransparency = 1
AvatarCircle.Position = UDim2.new(0, 15, 0.5, -25)
AvatarCircle.Size = UDim2.new(0, 50, 0, 50)
local AVCorner = Instance.new("UICorner")
AVCorner.CornerRadius = UDim.new(1, 0)
AVCorner.Parent = AvatarCircle
local AVStroke = Instance.new("UIStroke")
AVStroke.Thickness = 2
AVStroke.Color = Config.OffWhite
AVStroke.Transparency = 0.8
AVStroke.Parent = AvatarCircle
spawn(function()
    local thumb, success = Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
    if success then AvatarCircle.Image = thumb end
end)
local PlayerWelcome = Instance.new("TextLabel")
PlayerWelcome.Parent = AvatarFrame
PlayerWelcome.BackgroundTransparency = 1
PlayerWelcome.Position = UDim2.new(0, 75, 0, 0)
PlayerWelcome.Size = UDim2.new(1, -85, 1, 0)
PlayerWelcome.Font = Config.TitleFont
PlayerWelcome.Text = "Welcome, " .. (Player.DisplayName or Player.Name)
PlayerWelcome.TextColor3 = Config.OffWhite
PlayerWelcome.TextSize = 16
PlayerWelcome.TextXAlignment = Enum.TextXAlignment.Left

local PersonalCard = Instance.new("Frame")
PersonalCard.Parent = PlayerPage
PersonalCard.BackgroundColor3 = Config.OffBlack
PersonalCard.BackgroundTransparency = 0.7
PersonalCard.Size = UDim2.new(1, 0, 0, 110)
Instance.new("UICorner", PersonalCard).CornerRadius = UDim.new(0, 10)
local PCStroke = Instance.new("UIStroke", PersonalCard)
PCStroke.Thickness = 1
PCStroke.Color = Config.OffWhite
PCStroke.Transparency = 0.95
local PCList = Instance.new("UIListLayout", PersonalCard)
PCList.Padding = UDim.new(0, 5)

local function CreateInfoLabel(parent, label, value)
    local Frame = Instance.new("Frame")
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, 0, 0, 22)
    Frame.Parent = parent
    local L = Instance.new("TextLabel", Frame)
    L.BackgroundTransparency = 1
    L.Position = UDim2.new(0, 15, 0, 0)
    L.Size = UDim2.new(0, 100, 1, 0)
    L.Font = Config.Font
    L.Text = label .. ":"
    L.TextColor3 = Color3.fromRGB(150, 150, 150)
    L.TextSize = 13
    L.TextXAlignment = Enum.TextXAlignment.Left
    local V = Instance.new("TextLabel", Frame)
    V.BackgroundTransparency = 1
    V.Position = UDim2.new(0, 110, 0, 0)
    V.Size = UDim2.new(1, -125, 1, 0)
    V.Font = Config.Font
    V.Text = tostring(value)
    V.TextColor3 = Config.OffWhite
    V.TextSize = 13
    V.TextXAlignment = Enum.TextXAlignment.Left
    return V
end

Instance.new("Frame", PersonalCard).Size = UDim2.new(1, 0, 0, 5)
CreateInfoLabel(PersonalCard, "Display Name", Player.DisplayName)
CreateInfoLabel(PersonalCard, "Username", Player.Name)
CreateInfoLabel(PersonalCard, "User ID", Player.UserId)
CreateInfoLabel(PersonalCard, "Account Age", Player.AccountAge .. " Days")

local ServerCard = Instance.new("Frame")
ServerCard.Parent = PlayerPage
ServerCard.BackgroundColor3 = Config.OffBlack
ServerCard.BackgroundTransparency = 0.7
ServerCard.Size = UDim2.new(1, 0, 0, 70)
Instance.new("UICorner", ServerCard).CornerRadius = UDim.new(0, 10)
local SStroke = Instance.new("UIStroke", ServerCard)
SStroke.Thickness = 1
SStroke.Color = Config.OffWhite
SStroke.Transparency = 0.95
Instance.new("UIListLayout", ServerCard).Padding = UDim.new(0, 5)
Instance.new("Frame", ServerCard).Size = UDim2.new(1, 0, 0, 5)
local PopulationLabel = CreateInfoLabel(ServerCard, "Population", #Players:GetPlayers() .. " / " .. Players.MaxPlayers)
CreateInfoLabel(ServerCard, "Server ID", game.JobId:sub(1, 10) .. "...")
local function UpdatePop() PopulationLabel.Text = #Players:GetPlayers() .. " / " .. Players.MaxPlayers end
Players.PlayerAdded:Connect(UpdatePop)
Players.PlayerRemoving:Connect(UpdatePop)

-- Draggable Functionality
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

local ToggleButton = Instance.new("Frame")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Config.OffBlack
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Visible = false
ApplyGlassEffect(ToggleButton, 0.5)
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
local ToggleLogo = Instance.new("ImageLabel")
ToggleLogo.Parent = ToggleButton
ToggleLogo.BackgroundTransparency = 1
ToggleLogo.Position = UDim2.new(0.15, 0, 0.15, 0)
ToggleLogo.Size = UDim2.new(0.7, 0, 0.7, 0)
ToggleLogo.Image = Config.LogoID
ToggleLogo.Visible = (Config.LogoID ~= "rbxassetid://0")
local ToggleText = Instance.new("TextLabel", ToggleButton)
ToggleText.BackgroundTransparency = 1
ToggleText.Size = UDim2.new(1, 0, 1, 0)
ToggleText.Font = Config.TitleFont
ToggleText.Text = "N"
ToggleText.TextColor3 = Config.OffWhite
ToggleText.TextSize = 20
ToggleText.Visible = (Config.LogoID == "rbxassetid://0")
local ToggleBtn = Instance.new("TextButton", ToggleButton)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.Text = ""
ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = true ToggleButton.Visible = false SetBlur(true) end)
MakeDraggable(ToggleButton)

-- Close Button
local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Name = "Close"
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -35, 0, 10)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Config.Font
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Config.OffWhite
CloseBtn.TextSize = 18
CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false ToggleButton.Visible = true SetBlur(false) end)

-- Initial State
SwitchTab(TeleportTab, TeleportPage)

-- LOADING SEQUENCER
local function StartLoading()
    SetBlur(true)
    for i = 1, 3 do
        local rotation = TweenService:Create(LoaderLogo, TweenInfo.new(1, Enum.EasingStyle.Linear), {Rotation = i * 360})
        rotation:Play()
        rotation.Completed:Wait()
    end
    TweenService:Create(LoaderFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(LoaderLogo, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
    wait(0.5)
    LoaderFrame:Destroy()
    Main.Visible = true
end

StartLoading()
print("NattHUB Ready!")
