-- ===================================================================
--                    UI MODULE COMPLETE - DARI SPIN.LUA
--                     Semua Komponen UI dari Script Asli
-- ===================================================================

local UIModule = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Local references
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- UI Configuration (dari spin.lua)
local CONFIG = {
    GUI_TITLE = "XSan FISH",
    VERSION = "V2.0",
    HOTKEY = Enum.KeyCode.F9,
    AUTO_SAVE_SETTINGS = true,
    NOTIFICATION_DURATION = 3
}

-- Function to create complete GUI (berdasarkan createCompleteGUI dari spin.lua)
function UIModule.createCompleteGUI()
    -- Main ScreenGui
    local ZayrosFISHIT = Instance.new("ScreenGui")
    ZayrosFISHIT.Name = "ZayrosFISHIT"
    ZayrosFISHIT.Parent = playerGui
    ZayrosFISHIT.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ZayrosFISHIT.ResetOnSpawn = false

    -- Main Frame (FrameUtama)
    local FrameUtama = Instance.new("Frame")
    FrameUtama.Name = "FrameUtama"
    FrameUtama.Parent = ZayrosFISHIT
    FrameUtama.Active = true
    FrameUtama.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
    FrameUtama.BorderColor3 = Color3.fromRGB(0, 0, 0)
    FrameUtama.BorderSizePixel = 0
    FrameUtama.Position = UDim2.new(0.205, 0, 0.165, 0)
    FrameUtama.Size = UDim2.new(0.590, 0, 0.670, 0)

    local MainCorner = Instance.new("UICorner")
    MainCorner.Parent = FrameUtama

    -- Header Frame
    local HeaderFrame = Instance.new("Frame")
    HeaderFrame.Name = "HeaderFrame"
    HeaderFrame.Parent = FrameUtama
    HeaderFrame.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    HeaderFrame.BorderSizePixel = 0
    HeaderFrame.Size = UDim2.new(1, 0, 0.147, 0)

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.Parent = HeaderFrame

    -- Title (Tittle di script asli)
    local Tittle = Instance.new("TextLabel")
    Tittle.Name = "Tittle"
    Tittle.Parent = HeaderFrame
    Tittle.BackgroundTransparency = 1
    Tittle.Position = UDim2.new(0.070, 0, 0.272, 0)
    Tittle.Size = UDim2.new(0.548, 0, 0.545, 0)
    Tittle.Font = Enum.Font.GothamBold
    Tittle.Text = "MAIN"
    Tittle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tittle.TextScaled = true
    Tittle.TextXAlignment = Enum.TextXAlignment.Left

    -- Logo
    local Logo = Instance.new("TextLabel")
    Logo.Name = "Logo"
    Logo.Parent = HeaderFrame
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0.022, 0, 0.090, 0)
    Logo.Size = UDim2.new(0.042, 0, 0.818, 0)
    Logo.Font = Enum.Font.GothamBold
    Logo.Text = "🎣"
    Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
    Logo.TextScaled = true

    -- Version Label
    local VersionLabel = Instance.new("TextLabel")
    VersionLabel.Name = "VersionLabel"
    VersionLabel.Parent = HeaderFrame
    VersionLabel.BackgroundTransparency = 1
    VersionLabel.Position = UDim2.new(0.618, 0, 0.272, 0)
    VersionLabel.Size = UDim2.new(0.300, 0, 0.545, 0)
    VersionLabel.Font = Enum.Font.GothamBold
    VersionLabel.Text = CONFIG.VERSION
    VersionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    VersionLabel.TextScaled = true

    -- Exit Button
    local ExitBtn = Instance.new("TextButton")
    ExitBtn.Name = "ExitBtn"
    ExitBtn.Parent = HeaderFrame
    ExitBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    ExitBtn.BorderSizePixel = 0
    ExitBtn.Position = UDim2.new(0.925, 0, 0.272, 0)
    ExitBtn.Size = UDim2.new(0.050, 0, 0.545, 0)
    ExitBtn.Font = Enum.Font.GothamBold
    ExitBtn.Text = "✕"
    ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExitBtn.TextScaled = true

    local ExitCorner = Instance.new("UICorner")
    ExitCorner.Parent = ExitBtn

    -- Menu Frame
    local MenuFrame = Instance.new("Frame")
    MenuFrame.Name = "MenuFrame"
    MenuFrame.Parent = FrameUtama
    MenuFrame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
    MenuFrame.BorderSizePixel = 0
    MenuFrame.Position = UDim2.new(0, 0, 0.147, 0)
    MenuFrame.Size = UDim2.new(0.376, 0, 0.853, 0)

    local MenuCorner = Instance.new("UICorner")
    MenuCorner.Parent = MenuFrame

    -- Menu List Layout
    local MenuListLayoutFrame = Instance.new("Frame")
    MenuListLayoutFrame.Name = "MenuListLayoutFrame"
    MenuListLayoutFrame.Parent = MenuFrame
    MenuListLayoutFrame.BackgroundTransparency = 1
    MenuListLayoutFrame.Position = UDim2.new(0, 0, 0.022, 0)
    MenuListLayoutFrame.Size = UDim2.new(1, 0, 0.956, 0)

    local ListLayoutMenu = Instance.new("UIListLayout")
    ListLayoutMenu.Name = "ListLayoutMenu"
    ListLayoutMenu.Parent = MenuListLayoutFrame
    ListLayoutMenu.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ListLayoutMenu.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayoutMenu.Padding = UDim.new(0, 8)

    -- Menu buttons (dari script asli)
    local menuButtons = {}

    -- MAIN Button
    local MAIN = Instance.new("TextButton")
    MAIN.Name = "MAIN"
    MAIN.Parent = MenuListLayoutFrame
    MAIN.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    MAIN.BorderSizePixel = 0
    MAIN.Size = UDim2.new(0.898, 0, 0.106, 0)
    MAIN.Font = Enum.Font.GothamBold
    MAIN.Text = "🏠 MAIN"
    MAIN.TextColor3 = Color3.fromRGB(255, 255, 255)
    MAIN.TextScaled = true

    local MainCorner1 = Instance.new("UICorner")
    MainCorner1.Parent = MAIN
    menuButtons.MAIN = MAIN

    -- PLAYER Button
    local Player = Instance.new("TextButton")
    Player.Name = "Player"
    Player.Parent = MenuListLayoutFrame
    Player.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    Player.BorderSizePixel = 0
    Player.Size = UDim2.new(0.898, 0, 0.106, 0)
    Player.Font = Enum.Font.GothamBold
    Player.Text = "👤 PLAYER"
    Player.TextColor3 = Color3.fromRGB(255, 255, 255)
    Player.TextScaled = true

    local PlayerCorner = Instance.new("UICorner")
    PlayerCorner.Parent = Player
    menuButtons.PLAYER = Player

    -- TELEPORT Button
    local TELEPORT = Instance.new("TextButton")
    TELEPORT.Name = "TELEPORT"
    TELEPORT.Parent = MenuListLayoutFrame
    TELEPORT.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    TELEPORT.BorderSizePixel = 0
    TELEPORT.Size = UDim2.new(0.898, 0, 0.106, 0)
    TELEPORT.Font = Enum.Font.GothamBold
    TELEPORT.Text = "📍 TELEPORT"
    TELEPORT.TextColor3 = Color3.fromRGB(255, 255, 255)
    TELEPORT.TextScaled = true

    local TeleportCorner = Instance.new("UICorner")
    TeleportCorner.Parent = TELEPORT
    menuButtons.TELEPORT = TELEPORT

    -- BOAT Button
    local SpawnBoat = Instance.new("TextButton")
    SpawnBoat.Name = "SpawnBoat"
    SpawnBoat.Parent = MenuListLayoutFrame
    SpawnBoat.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    SpawnBoat.BorderSizePixel = 0
    SpawnBoat.Size = UDim2.new(0.898, 0, 0.106, 0)
    SpawnBoat.Font = Enum.Font.GothamBold
    SpawnBoat.Text = "🚤 BOAT"
    SpawnBoat.TextColor3 = Color3.fromRGB(255, 255, 255)
    SpawnBoat.TextScaled = true

    local BoatCorner = Instance.new("UICorner")
    BoatCorner.Parent = SpawnBoat
    menuButtons.BOAT = SpawnBoat

    -- SECURITY Button
    local SECURITY = Instance.new("TextButton")
    SECURITY.Name = "SECURITY"
    SECURITY.Parent = MenuListLayoutFrame
    SECURITY.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    SECURITY.BorderSizePixel = 0
    SECURITY.Size = UDim2.new(0.898, 0, 0.106, 0)
    SECURITY.Font = Enum.Font.GothamBold
    SECURITY.Text = "🔒 SECURITY"
    SECURITY.TextColor3 = Color3.fromRGB(255, 255, 255)
    SECURITY.TextScaled = true

    local SecurityCorner = Instance.new("UICorner")
    SecurityCorner.Parent = SECURITY
    menuButtons.SECURITY = SECURITY

    -- ADVANCED Button
    local ADVANCED = Instance.new("TextButton")
    ADVANCED.Name = "ADVANCED"
    ADVANCED.Parent = MenuListLayoutFrame
    ADVANCED.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    ADVANCED.BorderSizePixel = 0
    ADVANCED.Size = UDim2.new(0.898, 0, 0.106, 0)
    ADVANCED.Font = Enum.Font.GothamBold
    ADVANCED.Text = "⚙️ ADVANCED"
    ADVANCED.TextColor3 = Color3.fromRGB(255, 255, 255)
    ADVANCED.TextScaled = true

    local AdvancedCorner = Instance.new("UICorner")
    AdvancedCorner.Parent = ADVANCED
    menuButtons.ADVANCED = ADVANCED

    -- Content Frames (semua frame konten)
    local frames = {}

    -- Main Frame Content
    local MainFrame = Instance.new("ScrollingFrame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = FrameUtama
    MainFrame.Active = true
    MainFrame.BackgroundTransparency = 1
    MainFrame.Position = UDim2.new(0.376, 0, 0.147, 0)
    MainFrame.Size = UDim2.new(0.624, 0, 0.853, 0)
    MainFrame.Visible = true
    MainFrame.ZIndex = 2
    MainFrame.ScrollBarThickness = 6
    frames.Main = MainFrame

    -- Player Frame
    local PlayerFrame = Instance.new("ScrollingFrame")
    PlayerFrame.Name = "PlayerFrame"
    PlayerFrame.Parent = FrameUtama
    PlayerFrame.Active = true
    PlayerFrame.BackgroundTransparency = 1
    PlayerFrame.Position = UDim2.new(0.376, 0, 0.147, 0)
    PlayerFrame.Size = UDim2.new(0.624, 0, 0.853, 0)
    PlayerFrame.Visible = false
    PlayerFrame.ZIndex = 2
    PlayerFrame.ScrollBarThickness = 6
    frames.Player = PlayerFrame

    -- Teleport Frame
    local Teleport = Instance.new("ScrollingFrame")
    Teleport.Name = "Teleport"
    Teleport.Parent = FrameUtama
    Teleport.Active = true
    Teleport.BackgroundTransparency = 1
    Teleport.Position = UDim2.new(0.376, 0, 0.147, 0)
    Teleport.Size = UDim2.new(0.624, 0, 0.853, 0)
    Teleport.Visible = false
    Teleport.ZIndex = 2
    Teleport.ScrollBarThickness = 6
    frames.Teleport = Teleport

    -- Boat Frame
    local SpawnBoatFrame = Instance.new("ScrollingFrame")
    SpawnBoatFrame.Name = "SpawnBoatFrame"
    SpawnBoatFrame.Parent = FrameUtama
    SpawnBoatFrame.Active = true
    SpawnBoatFrame.BackgroundTransparency = 1
    SpawnBoatFrame.Position = UDim2.new(0.376, 0, 0.147, 0)
    SpawnBoatFrame.Size = UDim2.new(0.624, 0, 0.853, 0)
    SpawnBoatFrame.Visible = false
    SpawnBoatFrame.ZIndex = 2
    SpawnBoatFrame.ScrollBarThickness = 6
    frames.Boat = SpawnBoatFrame

    -- Security Frame
    local SecurityFrame = Instance.new("ScrollingFrame")
    SecurityFrame.Name = "SecurityFrame"
    SecurityFrame.Parent = FrameUtama
    SecurityFrame.Active = true
    SecurityFrame.BackgroundTransparency = 1
    SecurityFrame.Position = UDim2.new(0.376, 0, 0.147, 0)
    SecurityFrame.Size = UDim2.new(0.624, 0, 0.853, 0)
    SecurityFrame.Visible = false
    SecurityFrame.ZIndex = 2
    SecurityFrame.ScrollBarThickness = 6
    frames.Security = SecurityFrame

    -- Advanced Frame
    local AdvancedFrame = Instance.new("ScrollingFrame")
    AdvancedFrame.Name = "AdvancedFrame"
    AdvancedFrame.Parent = FrameUtama
    AdvancedFrame.Active = true
    AdvancedFrame.BackgroundTransparency = 1
    AdvancedFrame.Position = UDim2.new(0.376, 0, 0.147, 0)
    AdvancedFrame.Size = UDim2.new(0.624, 0, 0.853, 0)
    AdvancedFrame.Visible = false
    AdvancedFrame.ZIndex = 2
    AdvancedFrame.ScrollBarThickness = 6
    frames.Advanced = AdvancedFrame

    -- Floating Button (sama seperti di script asli)
    local FloatingButton = Instance.new("Frame")
    FloatingButton.Name = "FloatingButton"
    FloatingButton.Parent = ZayrosFISHIT
    FloatingButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    FloatingButton.BackgroundTransparency = 0.2
    FloatingButton.BorderSizePixel = 0
    FloatingButton.Position = UDim2.new(0, 20, 0.5, -30)
    FloatingButton.Size = UDim2.new(0, 60, 0, 60)
    FloatingButton.ZIndex = 100
    FloatingButton.Active = true

    local floatingCorner = Instance.new("UICorner")
    floatingCorner.CornerRadius = UDim.new(0, 30)
    floatingCorner.Parent = FloatingButton

    -- Shadow untuk floating button
    local FloatingShadow = Instance.new("Frame")
    FloatingShadow.Name = "FloatingShadow"
    FloatingShadow.Parent = ZayrosFISHIT
    FloatingShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    FloatingShadow.BackgroundTransparency = 0.7
    FloatingShadow.BorderSizePixel = 0
    FloatingShadow.Position = UDim2.new(0, 22, 0.5, -28)
    FloatingShadow.Size = UDim2.new(0, 60, 0, 60)
    FloatingShadow.ZIndex = 99

    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 30)
    shadowCorner.Parent = FloatingShadow

    local FloatingButtonText = Instance.new("TextLabel")
    FloatingButtonText.Name = "FloatingButtonText"
    FloatingButtonText.Parent = FloatingButton
    FloatingButtonText.BackgroundTransparency = 1
    FloatingButtonText.Size = UDim2.new(1, 0, 1, 0)
    FloatingButtonText.Font = Enum.Font.SourceSansBold
    FloatingButtonText.Text = "🎣"
    FloatingButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
    FloatingButtonText.TextScaled = true
    FloatingButtonText.ZIndex = 101

    -- Pulse animation untuk floating button
    local pulseAnimation = TweenService:Create(
        FloatingButton,
        TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true),
        {BackgroundTransparency = 0.4}
    )
    pulseAnimation:Play()

    local FloatingButtonClick = Instance.new("TextButton")
    FloatingButtonClick.Name = "FloatingButtonClick"
    FloatingButtonClick.Parent = FloatingButton
    FloatingButtonClick.BackgroundTransparency = 1
    FloatingButtonClick.Size = UDim2.new(1, 0, 1, 0)
    FloatingButtonClick.Text = ""
    FloatingButtonClick.ZIndex = 102

    -- Tooltip untuk floating button
    local FloatingTooltip = Instance.new("Frame")
    FloatingTooltip.Name = "FloatingTooltip"
    FloatingTooltip.Parent = ZayrosFISHIT
    FloatingTooltip.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    FloatingTooltip.BackgroundTransparency = 0.2
    FloatingTooltip.BorderSizePixel = 0
    FloatingTooltip.Position = UDim2.new(0, 90, 0.5, -15)
    FloatingTooltip.Size = UDim2.new(0, 120, 0, 30)
    FloatingTooltip.ZIndex = 105
    FloatingTooltip.Visible = false

    local tooltipCorner = Instance.new("UICorner")
    tooltipCorner.CornerRadius = UDim.new(0, 5)
    tooltipCorner.Parent = FloatingTooltip

    local FloatingTooltipText = Instance.new("TextLabel")
    FloatingTooltipText.Name = "FloatingTooltipText"
    FloatingTooltipText.Parent = FloatingTooltip
    FloatingTooltipText.BackgroundTransparency = 1
    FloatingTooltipText.Size = UDim2.new(1, 0, 1, 0)
    FloatingTooltipText.Font = Enum.Font.SourceSansBold
    FloatingTooltipText.Text = "Click to toggle GUI"
    FloatingTooltipText.TextColor3 = Color3.fromRGB(255, 255, 255)
    FloatingTooltipText.TextScaled = true
    FloatingTooltipText.ZIndex = 106

    -- TP Lists (dari script asli)
    local ListOfTpPlayer = Instance.new("ScrollingFrame")
    ListOfTpPlayer.Name = "ListOfTpPlayer"
    ListOfTpPlayer.Parent = Teleport
    ListOfTpPlayer.Active = true
    ListOfTpPlayer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ListOfTpPlayer.BorderSizePixel = 0
    ListOfTpPlayer.Position = UDim2.new(0.513, 0, 0.022, 0)
    ListOfTpPlayer.Size = UDim2.new(0.468, 0, 0.956, 0)
    ListOfTpPlayer.Visible = false
    ListOfTpPlayer.ZIndex = 3
    ListOfTpPlayer.ScrollBarThickness = 6

    local ListOfTPIsland = Instance.new("ScrollingFrame")
    ListOfTPIsland.Name = "ListOfTPIsland"
    ListOfTPIsland.Parent = Teleport
    ListOfTPIsland.Active = true
    ListOfTPIsland.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ListOfTPIsland.BorderSizePixel = 0
    ListOfTPIsland.Position = UDim2.new(0.513, 0, 0.022, 0)
    ListOfTPIsland.Size = UDim2.new(0.468, 0, 0.956, 0)
    ListOfTPIsland.Visible = false
    ListOfTPIsland.ZIndex = 3
    ListOfTPIsland.ScrollBarThickness = 6

    -- Return semua komponen UI untuk digunakan di script utama
    return {
        ScreenGui = ZayrosFISHIT,
        MainFrame = FrameUtama,
        HeaderFrame = HeaderFrame,
        MenuFrame = MenuFrame,
        ContentFrames = frames,
        MenuButtons = menuButtons,
        FloatingButton = FloatingButton,
        FloatingButtonClick = FloatingButtonClick,
        FloatingButtonText = FloatingButtonText,
        FloatingShadow = FloatingShadow,
        FloatingTooltip = FloatingTooltip,
        ExitButton = ExitBtn,
        Title = Tittle,
        Logo = Logo,
        VersionLabel = VersionLabel,
        TPLists = {
            Player = ListOfTpPlayer,
            Island = ListOfTPIsland
        }
    }
end

-- Function untuk membuat feature button dengan status indicator (dari script asli)
function UIModule.createFeatureButton(parent, text, layoutOrder)
    local Frame = Instance.new("Frame")
    Frame.Name = text .. "Frame"
    Frame.Parent = parent
    Frame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(0.898, 0, 0.106, 0)
    Frame.LayoutOrder = layoutOrder or 0

    local Corner = Instance.new("UICorner")
    Corner.Parent = Frame

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Frame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.030, 0, 0.216, 0)
    TextLabel.Size = UDim2.new(0.415, 0, 0.568, 0)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.Text = text .. " :"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    local Button = Instance.new("TextButton")
    Button.Name = text .. "Button"
    Button.Parent = Frame
    Button.BackgroundTransparency = 1
    Button.Position = UDim2.new(0.738, 0, 0.108, 0)
    Button.Size = UDim2.new(0.207, 0, 0.784, 0)
    Button.ZIndex = 2
    Button.Font = Enum.Font.SourceSansBold
    Button.Text = "OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true

    local StatusFrame = Instance.new("Frame")
    StatusFrame.Parent = Frame
    StatusFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    StatusFrame.BorderSizePixel = 0
    StatusFrame.Position = UDim2.new(0.719, 0, 0.135, 0)
    StatusFrame.Size = UDim2.new(0.257, 0, 0.730, 0)

    local StatusCorner = Instance.new("UICorner")
    StatusCorner.Parent = StatusFrame

    return {
        Frame = Frame,
        Button = Button,
        StatusFrame = StatusFrame,
        TextLabel = TextLabel
    }
end

-- Function untuk membuat input field (untuk TextBox seperti di script asli)
function UIModule.createInputField(parent, text, placeholder, layoutOrder)
    local Frame = Instance.new("Frame")
    Frame.Name = text .. "Frame"
    Frame.Parent = parent
    Frame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(0.898, 0, 0.106, 0)
    Frame.LayoutOrder = layoutOrder or 0

    local Corner = Instance.new("UICorner")
    Corner.Parent = Frame

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Frame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.030, 0, 0.216, 0)
    TextLabel.Size = UDim2.new(0.415, 0, 0.568, 0)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.Text = text .. ":"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    local TextBox = Instance.new("TextBox")
    TextBox.Name = text .. "TextBox"
    TextBox.Parent = Frame
    TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextBox.BorderSizePixel = 0
    TextBox.Position = UDim2.new(0.719, 0, 0.135, 0)
    TextBox.Size = UDim2.new(0.257, 0, 0.730, 0)
    TextBox.ZIndex = 3
    TextBox.Font = Enum.Font.SourceSansBold
    TextBox.PlaceholderText = placeholder or ""
    TextBox.Text = ""
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextBox.TextScaled = true

    local TextBoxCorner = Instance.new("UICorner")
    TextBoxCorner.Parent = TextBox

    return {
        Frame = Frame,
        TextBox = TextBox,
        TextLabel = TextLabel
    }
end

-- Function untuk membuat stats display (seperti di script asli)
function UIModule.createStatsDisplay(parent, text, layoutOrder)
    local Frame = Instance.new("Frame")
    Frame.Name = "StatsFrame"
    Frame.Parent = parent
    Frame.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.new(0.898, 0, 0.106, 0)
    Frame.LayoutOrder = layoutOrder or 0

    local Corner = Instance.new("UICorner")
    Corner.Parent = Frame

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "StatsText"
    TextLabel.Parent = Frame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.030, 0, 0.216, 0)
    TextLabel.Size = UDim2.new(0.940, 0, 0.568, 0)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.Text = text
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true

    return {
        Frame = Frame,
        TextLabel = TextLabel
    }
end

-- Function untuk notification system (dari script asli)
function UIModule.createNotificationSystem(parent)
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Name = "NotificationFrame"
    NotificationFrame.Parent = parent
    NotificationFrame.BackgroundTransparency = 1
    NotificationFrame.Position = UDim2.new(0, 20, 1, -80)
    NotificationFrame.Size = UDim2.new(0, 300, 0, 60)
    NotificationFrame.ZIndex = 200
    NotificationFrame.Visible = false

    local NotificationBG = Instance.new("Frame")
    NotificationBG.Name = "NotificationBG"
    NotificationBG.Parent = NotificationFrame
    NotificationBG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    NotificationBG.BackgroundTransparency = 0.2
    NotificationBG.BorderSizePixel = 0
    NotificationBG.Size = UDim2.new(1, 0, 1, 0)

    local NotificationCorner = Instance.new("UICorner")
    NotificationCorner.CornerRadius = UDim.new(0, 8)
    NotificationCorner.Parent = NotificationBG

    local NotificationText = Instance.new("TextLabel")
    NotificationText.Name = "NotificationText"
    NotificationText.Parent = NotificationBG
    NotificationText.BackgroundTransparency = 1
    NotificationText.Position = UDim2.new(0.05, 0, 0, 0)
    NotificationText.Size = UDim2.new(0.9, 0, 1, 0)
    NotificationText.Font = Enum.Font.SourceSansBold
    NotificationText.Text = ""
    NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotificationText.TextScaled = true
    NotificationText.TextWrapped = true

    return {
        Frame = NotificationFrame,
        Background = NotificationBG,
        Text = NotificationText
    }
end

-- Function untuk setup drag functionality (dari script asli)
function UIModule.setupDragFunctionality(frame)
    local dragging = false
    local dragStart = nil
    local startPos = nil

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

-- Function untuk setup floating button drag (dengan shadow)
function UIModule.setupFloatingButtonDrag(floatingButton, shadow)
    local floatingDragging = false
    local floatingDragStart = nil
    local floatingStartPos = nil
    local shadowStartPos = nil

    floatingButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            floatingDragging = true
            floatingDragStart = input.Position
            floatingStartPos = floatingButton.Position
            if shadow then
                shadowStartPos = shadow.Position
            end
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and floatingDragging then
            local delta = input.Position - floatingDragStart
            floatingButton.Position = UDim2.new(
                floatingStartPos.X.Scale,
                floatingStartPos.X.Offset + delta.X,
                floatingStartPos.Y.Scale,
                floatingStartPos.Y.Offset + delta.Y
            )
            if shadow then
                shadow.Position = UDim2.new(
                    shadowStartPos.X.Scale,
                    shadowStartPos.X.Offset + delta.X,
                    shadowStartPos.Y.Scale,
                    shadowStartPos.Y.Offset + delta.Y
                )
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            floatingDragging = false
        end
    end)
end

-- Function untuk panel switching (dari script asli)
function UIModule.createPanelSwitcher(frames, title, menuButtons)
    local function showPanel(pageName)
        -- Hide semua frames
        for _, frame in pairs(frames) do
            frame.Visible = false
        end
        
        -- Show frame yang dipilih
        if frames[pageName] then
            frames[pageName].Visible = true
        end
        
        -- Update title
        if title then
            title.Text = pageName:upper()
        end
        
        -- Update warna menu buttons
        for name, button in pairs(menuButtons) do
            if name == pageName:upper() then
                button.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            else
                button.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
            end
        end
    end
    
    return showPanel
end

-- Function untuk setup hover effects pada floating button
function UIModule.setupFloatingButtonHover(floatingButton, shadow, tooltip)
    floatingButton.MouseEnter:Connect(function()
        floatingButton:TweenSize(
            UDim2.new(0, 70, 0, 70),
            "Out", "Quad", 0.2, true
        )
        if shadow then
            shadow:TweenSize(
                UDim2.new(0, 70, 0, 70),
                "Out", "Quad", 0.2, true
            )
        end
        floatingButton.BackgroundTransparency = 0.1
        if tooltip then
            tooltip.Visible = true
            tooltip:TweenPosition(
                UDim2.new(0, 95, 0.5, -15),
                "Out", "Quad", 0.2, true
            )
        end
    end)
    
    floatingButton.MouseLeave:Connect(function()
        floatingButton:TweenSize(
            UDim2.new(0, 60, 0, 60),
            "Out", "Quad", 0.2, true
        )
        if shadow then
            shadow:TweenSize(
                UDim2.new(0, 60, 0, 60),
                "Out", "Quad", 0.2, true
            )
        end
        floatingButton.BackgroundTransparency = 0.2
        if tooltip then
            tooltip.Visible = false
        end
    end)
end

return UIModule
