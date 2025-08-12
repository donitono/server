-- ██████████████████████████████████████████████████████████████
-- ██                                                          ██
-- ██                 ZAYROS FISH SCRIPT V2.0                  ██
-- ██                 COMPLETE MODULAR VERSION                 ██
-- ██                 BASED ON SPIN.LUA                        ██
-- ██                                                          ██
-- ██████████████████████████████████████████████████████████████

-- ===================================================================
--                          CONFIGURATION
-- ===================================================================
local CONFIG = {
    GUI_NAME = "SpinnerFISHIT", -- Ganti nama GUI disini
    GUI_TITLE = "FISH SCRIPT", -- Ganti judul yang ditampilkan
    LOGO_IMAGE = "rbxassetid://10776847027", -- Ganti dengan ID gambar kamu
    HOTKEY = Enum.KeyCode.F9, -- Hide/Show GUI
    AUTO_SAVE_SETTINGS = true,
    NOTIFICATION_DURATION = 3,
    FISHING_DELAYS = {
        MIN = 0.1,
        MAX = 0.3
    },
    -- AFK2 AutoFish Settings
    AFK2_DELAYS = {
        MIN = 0.5,    -- Minimum delay untuk AFK2
        MAX = 2.0,    -- Maximum delay untuk AFK2
        CUSTOM = 1.0  -- Custom delay yang bisa diatur user
    }
}

-- GitHub Raw URL for UI Module (GANTI DENGAN URL GITHUB RAW ANDA)
local UI_MODULE_URL = _G.ZayrosFishConfig and _G.ZayrosFishConfig.GitHub.UI_MODULE or "https://raw.githubusercontent.com/donitono/server/refs/heads/main/ui.lua"

-- Main execution wrapper
local success, error = pcall(function()

-- Check if GUI already exists and destroy it
if game.Players.LocalPlayer.PlayerGui:FindFirstChild(CONFIG.GUI_NAME) then
    game.Players.LocalPlayer.PlayerGui[CONFIG.GUI_NAME]:Destroy()
end

-- ===================================================================
--                            SERVICES
-- ===================================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Rs = game:GetService("ReplicatedStorage")

-- ===================================================================
--                           VARIABLES
-- ===================================================================
local player = Players.LocalPlayer
local connections = {}
local isHidden = false

-- Load UI Module from GitHub
local UIModule
local ui_success, ui_error = pcall(function()
    print("🔄 Loading Complete UI Module from GitHub...")
    UIModule = loadstring(game:HttpGet(UI_MODULE_URL))()
end)

if not ui_success then
    warn("❌ Failed to load UI Module from GitHub: " .. tostring(ui_error))
    warn("💡 Please check:")
    warn("   1. Your internet connection")
    warn("   2. The GitHub raw URL is correct")
    warn("   3. The repository is public")
    warn("   4. The ui_module_complete.lua file exists in the repository")
    return
end

print("✅ Complete UI Module loaded successfully from GitHub!")

-- ===================================================================
--                        REMOTES & REFERENCES
-- ===================================================================
local safeCall = function(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("⚠️ Safe call failed: " .. tostring(result))
    end
    return success, result
end

-- Remote references (dari spin.lua)
local sellAll, spawnBoat, despawnBoat, castRod, reelIn
safeCall(function()
    sellAll = Rs:WaitForChild("CloudFrameShared"):WaitForChild("DataStreams"):WaitForChild("processGameItemSold")
    spawnBoat = Rs:WaitForChild("CloudFrameShared"):WaitForChild("DataStreams"):WaitForChild("spawnBoat")
    despawnBoat = Rs:WaitForChild("CloudFrameShared"):WaitForChild("DataStreams"):WaitForChild("despawnBoat")
    -- Tambah remote untuk fishing jika ada
    castRod = Rs:WaitForChild("CloudFrameShared"):WaitForChild("DataStreams"):WaitForChild("FishCast")
    reelIn = Rs:WaitForChild("CloudFrameShared"):WaitForChild("DataStreams"):WaitForChild("FishCaught")
end)

-- Get workspace references
local workspace = game:GetWorkspace()
local tpFolder = workspace:FindFirstChild("TpFolder")

-- ===================================================================
--                            SETTINGS
-- ===================================================================
local Settings = {
    -- Basic Fishing
    AutoFishing = false,
    AutoFishingAFK2 = false,
    AutoFishingExtreme = false,
    AutoFishingBrutal = false,
    AutoSell = false,
    
    -- Player Stats
    WalkSpeed = 16,
    JumpPower = 50,
    
    -- Advanced Features (dari spin.lua)
    LuckBoost = false,
    WeatherBoost = false,
    SmartFishing = false,
    FishValueFilter = false,
    MinFishValue = 100,
    
    -- AFK2 Settings
    AFK2_DelayMode = "RANDOM", -- CUSTOM, RANDOM, FIXED
    AFK2_CustomDelay = 1.0,
    AFK2_MinDelay = 0.5,
    AFK2_MaxDelay = 2.0,
    AFK2_FixedDelay = 1.0,
    
    -- Extreme Settings
    ExtremeSpeed = "LOW", -- LOW, MEDIUM, HIGH, INSANE
    ExtremeSafeMode = true,
    
    -- Brutal Settings
    BrutalCustomDelay = 0.01,
    BrutalSafeMode = false
}

local SecuritySettings = {
    AdminDetection = true,
    PlayerProximityAlert = true,
    AutoHideOnAdmin = true
}

-- ===================================================================
--                         STATISTICS
-- ===================================================================
local Stats = {
    fishCaught = 0,
    sessionStartTime = tick(),
    moneyEarned = 0,
    rareFishCaught = 0,
    legendaryFishCaught = 0,
    currentLuckLevel = 1,
    fishPerMinute = 0,
    moneyPerHour = 0
}

local SecurityStats = {
    AdminsDetected = 0,
    ProximityAlerts = 0,
    AutoHides = 0
}

-- Weather Effects (dari spin.lua)
local WeatherEffects = {
    Clear = {
        luckMultiplier = 1.0,
        description = "☀️ Clear Weather (Normal Luck)"
    },
    Rain = {
        luckMultiplier = 1.2,
        description = "🌧️ Rainy Weather (+20% Luck)"
    },
    Storm = {
        luckMultiplier = 1.5,
        description = "⛈️ Storm Weather (+50% Luck)"
    },
    Fog = {
        luckMultiplier = 0.8,
        description = "🌫️ Foggy Weather (-20% Luck)"
    }
}

local currentWeather = "Clear"

-- ===================================================================
--                         CREATE GUI
-- ===================================================================

-- Create the main GUI using the loaded UI Module
local UIComponents = UIModule.createCompleteGUI()
local gui = UIComponents.ScreenGui
local mainFrame = UIComponents.MainFrame
local frames = UIComponents.ContentFrames
local menuButtons = UIComponents.MenuButtons
local floatingButton = UIComponents.FloatingButton
local floatingButtonClick = UIComponents.FloatingButtonClick
local floatingButtonText = UIComponents.FloatingButtonText
local floatingShadow = UIComponents.FloatingShadow
local floatingTooltip = UIComponents.FloatingTooltip

-- Set GUI name
gui.Name = CONFIG.GUI_NAME

-- ===================================================================
--                      NOTIFICATION SYSTEM
-- ===================================================================
local notificationSystem = UIModule.createNotificationSystem(gui)

local function createNotification(text, color)
    notificationSystem.Text.Text = text
    notificationSystem.Background.BackgroundColor3 = color or Color3.fromRGB(0, 162, 255)
    notificationSystem.Frame.Visible = true
    
    -- Slide in animation
    notificationSystem.Frame:TweenPosition(
        UDim2.new(0, 20, 1, -80),
        "Out", "Quad", 0.3, true
    )
    
    -- Auto hide after duration
    task.spawn(function()
        task.wait(CONFIG.NOTIFICATION_DURATION)
        notificationSystem.Frame:TweenPosition(
            UDim2.new(0, -320, 1, -80),
            "Out", "Quad", 0.3, true,
            function()
                notificationSystem.Frame.Visible = false
                notificationSystem.Frame.Position = UDim2.new(0, -300, 1, -80)
            end
        )
    end)
end

-- ===================================================================
--                       CORE FUNCTIONS
-- ===================================================================

-- Luck System (dari spin.lua)
local function calculateCurrentLuck()
    local baseLuck = 0.1 + (Stats.currentLuckLevel * 0.05)
    local weatherMultiplier = WeatherEffects[currentWeather].luckMultiplier
    local luckBoost = Settings.LuckBoost and 1.3 or 1.0
    return baseLuck * weatherMultiplier * luckBoost
end

-- Weather Cycle (dari spin.lua)
local function startWeatherCycle()
    task.spawn(function()
        while true do
            task.wait(math.random(300, 600)) -- 5-10 menit
            local weathers = {"Clear", "Rain", "Storm", "Fog"}
            local oldWeather = currentWeather
            currentWeather = weathers[math.random(1, #weathers)]
            
            if currentWeather ~= oldWeather then
                local effect = WeatherEffects[currentWeather]
                createNotification("🌤️ Weather changed: " .. effect.description, Color3.fromRGB(100, 200, 255))
            end
        end
    end)
end

-- Anti-AFK System (dari spin.lua)
local function antiAFK()
    task.spawn(function()
        while true do
            task.wait(math.random(180, 300)) -- 3-5 menit
            safeCall(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    local humanoid = player.Character.Humanoid
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end)
end

-- No Oxygen System (dari spin.lua)
local noOxygen = {
    enabled = false,
    connection = nil,
    
    toggle = function()
        noOxygen.enabled = not noOxygen.enabled
        
        if noOxygen.enabled then
            noOxygen.connection = RunService.Heartbeat:Connect(function()
                safeCall(function()
                    if player.Character and player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
                    end
                end)
            end)
        else
            if noOxygen.connection then
                noOxygen.connection:Disconnect()
                noOxygen.connection = nil
            end
        end
        
        return noOxygen.enabled
    end
}

-- ===================================================================
--                       FISHING FUNCTIONS
-- ===================================================================

-- Basic Auto Fishing
local function autoFishing()
    task.spawn(function()
        while Settings.AutoFishing do
            local delay = math.random(CONFIG.FISHING_DELAYS.MIN * 100, CONFIG.FISHING_DELAYS.MAX * 100) / 100
            task.wait(delay)
            
            safeCall(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    -- Cast rod
                    castRod:InvokeServer()
                    
                    -- Wait for fish
                    task.wait(math.random(2, 5))
                    
                    -- Reel in
                    reelIn:InvokeServer()
                    
                    Stats.fishCaught = Stats.fishCaught + 1
                    
                    -- Smart fishing check
                    if Settings.SmartFishing then
                        local currentLuck = calculateCurrentLuck()
                        if currentLuck > 0.5 then
                            Stats.rareFishCaught = Stats.rareFishCaught + 1
                        end
                        if currentLuck > 0.8 then
                            Stats.legendaryFishCaught = Stats.legendaryFishCaught + 1
                        end
                    end
                end
            end)
        end
    end)
end

-- AFK2 Auto Fishing
local function autoFishingAFK2()
    task.spawn(function()
        while Settings.AutoFishingAFK2 do
            local delay = 1.0
            
            if Settings.AFK2_DelayMode == "CUSTOM" then
                delay = Settings.AFK2_CustomDelay
            elseif Settings.AFK2_DelayMode == "RANDOM" then
                delay = math.random(Settings.AFK2_MinDelay * 100, Settings.AFK2_MaxDelay * 100) / 100
            else -- FIXED
                delay = Settings.AFK2_FixedDelay
            end
            
            task.wait(delay)
            
            safeCall(function()
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    castRod:InvokeServer()
                    task.wait(math.random(1, 3))
                    reelIn:InvokeServer()
                    Stats.fishCaught = Stats.fishCaught + 1
                end
            end)
        end
    end)
end

-- Extreme Auto Fishing
local function getExtremeDelay()
    if Settings.ExtremeSpeed == "LOW" then
        return 0.1
    elseif Settings.ExtremeSpeed == "MEDIUM" then
        return 0.05
    elseif Settings.ExtremeSpeed == "HIGH" then
        return 0.02
    else -- INSANE
        return 0.01
    end
end

local function autoFishingExtreme()
    task.spawn(function()
        while Settings.AutoFishingExtreme do
            local delay = getExtremeDelay()
            task.wait(delay)
            
            safeCall(function()
                if Settings.ExtremeSafeMode then
                    -- Safety checks
                    if #Players:GetPlayers() > 5 then
                        task.wait(1) -- Slow down if many players
                        return
                    end
                end
                
                castRod:InvokeServer()
                reelIn:InvokeServer()
                Stats.fishCaught = Stats.fishCaught + 1
            end)
        end
    end)
end

-- Brutal Auto Fishing
local function autoFishingBrutal()
    task.spawn(function()
        while Settings.AutoFishingBrutal do
            task.wait(Settings.BrutalCustomDelay)
            
            safeCall(function()
                if Settings.BrutalSafeMode then
                    -- Minimal safety checks
                    if #Players:GetPlayers() > 10 then
                        return
                    end
                end
                
                castRod:InvokeServer()
                reelIn:InvokeServer()
                Stats.fishCaught = Stats.fishCaught + 1
            end)
        end
    end)
end

-- ===================================================================
--                       SECURITY SYSTEM
-- ===================================================================

local function initializeSecurity()
    -- Admin Detection
    task.spawn(function()
        while SecuritySettings.AdminDetection do
            task.wait(5)
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer ~= player then
                    -- Check for admin (placeholder logic)
                    if string.find(targetPlayer.Name:lower(), "admin") or 
                       string.find(targetPlayer.Name:lower(), "mod") then
                        SecurityStats.AdminsDetected = SecurityStats.AdminsDetected + 1
                        createNotification("🚨 ADMIN DETECTED: " .. targetPlayer.Name, Color3.fromRGB(255, 0, 0))
                        
                        if SecuritySettings.AutoHideOnAdmin then
                            mainFrame.Visible = false
                            floatingButtonText.Text = "👁️"
                            floatingButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
                            SecurityStats.AutoHides = SecurityStats.AutoHides + 1
                            createNotification("🙈 Auto-hidden due to admin presence", Color3.fromRGB(255, 165, 0))
                        end
                    end
                end
            end
        end
    end)
    
    -- Proximity Alert
    task.spawn(function()
        while SecuritySettings.PlayerProximityAlert do
            task.wait(2)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local myPosition = player.Character.HumanoidRootPart.Position
                
                for _, targetPlayer in pairs(Players:GetPlayers()) do
                    if targetPlayer ~= player and targetPlayer.Character and 
                       targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (myPosition - targetPlayer.Character.HumanoidRootPart.Position).Magnitude
                        
                        if distance < 50 then -- 50 studs proximity
                            SecurityStats.ProximityAlerts = SecurityStats.ProximityAlerts + 1
                            createNotification("📡 Player nearby: " .. targetPlayer.Name .. " (" .. math.floor(distance) .. " studs)", Color3.fromRGB(255, 165, 0))
                        end
                    end
                end
            end
        end
    end)
end

-- ===================================================================
--                    PLAYER FUNCTIONS
-- ===================================================================

local function setWalkSpeed(speed)
    safeCall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speed
        end
    end)
end

local function setJumpPower(power)
    safeCall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = power
        end
    end)
end

-- ESP System
local espConnections = {}
local function createESP(targetPlayer)
    if targetPlayer == player or not targetPlayer.Character then return end
    
    local character = targetPlayer.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. targetPlayer.Name
    billboard.Parent = humanoidRootPart
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboard
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = targetPlayer.Name
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextScaled = true
    
    espConnections[targetPlayer] = billboard
end

local function removeESP(targetPlayer)
    if espConnections[targetPlayer] then
        espConnections[targetPlayer]:Destroy()
        espConnections[targetPlayer] = nil
    end
end

-- ===================================================================
--                    SETUP UI FUNCTIONALITY
-- ===================================================================

-- Setup drag functionality
UIModule.setupDragFunctionality(mainFrame)
UIModule.setupFloatingButtonDrag(floatingButton, floatingShadow)
UIModule.setupFloatingButtonHover(floatingButton, floatingShadow, floatingTooltip)

-- Create panel switcher
local showPanel = UIModule.createPanelSwitcher(frames, UIComponents.Title, menuButtons)

-- ===================================================================
--                      CREATE CONTENT FRAMES
-- ===================================================================

-- Create Main Frame Content
local mainListFrame = Instance.new("Frame")
mainListFrame.Name = "MainListLayoutFrame"
mainListFrame.Parent = frames.Main
mainListFrame.BackgroundTransparency = 1
mainListFrame.Position = UDim2.new(0, 0, 0.022, 0)
mainListFrame.Size = UDim2.new(1, 0, 1, 0)

local mainListLayout = Instance.new("UIListLayout")
mainListLayout.Name = "ListLayoutMain"
mainListLayout.Parent = mainListFrame
mainListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
mainListLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainListLayout.Padding = UDim.new(0, 8)

-- Create feature buttons
local autoFishButton = UIModule.createFeatureButton(mainListFrame, "AUTO FISH", 1)
local autoSellButton = UIModule.createFeatureButton(mainListFrame, "AUTO SELL", 2)
local noOxygenButton = UIModule.createFeatureButton(mainListFrame, "NO OXYGEN", 3)
local afk2Button = UIModule.createFeatureButton(mainListFrame, "AFK2 AUTOFISH", 4)
local extremeButton = UIModule.createFeatureButton(mainListFrame, "EXTREME AUTOFISH", 5)
local brutalButton = UIModule.createFeatureButton(mainListFrame, "BRUTAL AUTOFISH", 6)

-- Statistics display
local statsDisplay = UIModule.createStatsDisplay(mainListFrame, "🐟 Fish: 0 | ⏰ Session: 0m | 🍀 Luck: Lv1 (0.0%)", 7)

-- Weather display
local weatherDisplay = UIModule.createStatsDisplay(mainListFrame, "☀️ Clear Weather (Normal Luck)", 8)

-- Create Player Frame Content
local playerListFrame = Instance.new("Frame")
playerListFrame.Name = "PlayerListLayoutFrame"
playerListFrame.Parent = frames.Player
playerListFrame.BackgroundTransparency = 1
playerListFrame.Position = UDim2.new(0, 0, 0.022, 0)
playerListFrame.Size = UDim2.new(1, 0, 1, 0)

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Name = "ListLayoutPlayer"
playerListLayout.Parent = playerListFrame
playerListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
playerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
playerListLayout.Padding = UDim.new(0, 8)

-- Player features
local walkSpeedInput = UIModule.createInputField(playerListFrame, "WALK SPEED", "16", 1)
local jumpPowerInput = UIModule.createInputField(playerListFrame, "JUMP POWER", "50", 2)
local espButton = UIModule.createFeatureButton(playerListFrame, "ESP PLAYERS", 3)
local sellAllButton = UIModule.createFeatureButton(playerListFrame, "SELL ALL", 4)

-- Create Security Frame Content
local securityListFrame = Instance.new("Frame")
securityListFrame.Name = "SecurityListLayoutFrame"
securityListFrame.Parent = frames.Security
securityListFrame.BackgroundTransparency = 1
securityListFrame.Position = UDim2.new(0, 0, 0.022, 0)
securityListFrame.Size = UDim2.new(1, 0, 1, 0)

local securityListLayout = Instance.new("UIListLayout")
securityListLayout.Name = "ListLayoutSecurity"
securityListLayout.Parent = securityListFrame
securityListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
securityListLayout.SortOrder = Enum.SortOrder.LayoutOrder
securityListLayout.Padding = UDim.new(0, 8)

-- Security features
local adminDetectionButton = UIModule.createFeatureButton(securityListFrame, "ADMIN DETECTION", 1)
local proximityAlertButton = UIModule.createFeatureButton(securityListFrame, "PROXIMITY ALERT", 2)
local autoHideButton = UIModule.createFeatureButton(securityListFrame, "AUTO HIDE ON ADMIN", 3)
local securityStatsDisplay = UIModule.createStatsDisplay(securityListFrame, "🔒 Admins: 0 | 📡 Alerts: 0 | 🙈 Auto-Hides: 0", 4)

-- Create Advanced Frame Content
local advancedListFrame = Instance.new("Frame")
advancedListFrame.Name = "AdvancedListLayoutFrame"
advancedListFrame.Parent = frames.Advanced
advancedListFrame.BackgroundTransparency = 1
advancedListFrame.Position = UDim2.new(0, 0, 0.022, 0)
advancedListFrame.Size = UDim2.new(1, 0, 1, 0)

local advancedListLayout = Instance.new("UIListLayout")
advancedListLayout.Name = "ListLayoutAdvanced"
advancedListLayout.Parent = advancedListFrame
advancedListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
advancedListLayout.SortOrder = Enum.SortOrder.LayoutOrder
advancedListLayout.Padding = UDim.new(0, 8)

-- Advanced features
local luckBoostButton = UIModule.createFeatureButton(advancedListFrame, "LUCK BOOST", 1)
local weatherBoostButton = UIModule.createFeatureButton(advancedListFrame, "WEATHER BOOST", 2)
local smartFishingButton = UIModule.createFeatureButton(advancedListFrame, "SMART FISHING", 3)
local fishValueInput = UIModule.createInputField(advancedListFrame, "MIN FISH VALUE", "100", 4)
local advancedStatsDisplay = UIModule.createStatsDisplay(advancedListFrame, "💰 Money: ₡0 | 🏆 Rare: 0 | 👑 Legendary: 0", 5)

-- ===================================================================
--                        BUTTON CONNECTIONS
-- ===================================================================

-- Main Frame Buttons
connections[#connections + 1] = autoFishButton.Button.MouseButton1Click:Connect(function()
    if Settings.AutoFishingAFK2 or Settings.AutoFishingExtreme or Settings.AutoFishingBrutal then
        createNotification("❌ Turn off other fishing modes first!", Color3.fromRGB(255, 0, 0))
        return
    end
    
    Settings.AutoFishing = not Settings.AutoFishing
    autoFishButton.Button.Text = Settings.AutoFishing and "ON" or "OFF"
    autoFishButton.StatusFrame.BackgroundColor3 = Settings.AutoFishing and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if Settings.AutoFishing then
        autoFishing()
        createNotification("🎣 Auto Fishing started!", Color3.fromRGB(0, 200, 0))
    else
        createNotification("🎣 Auto Fishing stopped!", Color3.fromRGB(200, 0, 0))
    end
end)

connections[#connections + 1] = autoSellButton.Button.MouseButton1Click:Connect(function()
    Settings.AutoSell = not Settings.AutoSell
    autoSellButton.Button.Text = Settings.AutoSell and "ON" or "OFF"
    autoSellButton.StatusFrame.BackgroundColor3 = Settings.AutoSell and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if Settings.AutoSell then
        createNotification("🛒 Auto Sell enabled!", Color3.fromRGB(0, 200, 0))
    else
        createNotification("🛒 Auto Sell disabled!", Color3.fromRGB(200, 0, 0))
    end
end)

connections[#connections + 1] = noOxygenButton.Button.MouseButton1Click:Connect(function()
    local state = noOxygen.toggle()
    noOxygenButton.Button.Text = state and "ON" or "OFF"
    noOxygenButton.StatusFrame.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if state then
        createNotification("💨 No Oxygen enabled!", Color3.fromRGB(0, 200, 0))
    else
        createNotification("💨 No Oxygen disabled!", Color3.fromRGB(200, 0, 0))
    end
end)

connections[#connections + 1] = afk2Button.Button.MouseButton1Click:Connect(function()
    if Settings.AutoFishing or Settings.AutoFishingExtreme or Settings.AutoFishingBrutal then
        createNotification("❌ Turn off other fishing modes first!", Color3.fromRGB(255, 0, 0))
        return
    end
    
    Settings.AutoFishingAFK2 = not Settings.AutoFishingAFK2
    afk2Button.Button.Text = Settings.AutoFishingAFK2 and "ON" or "OFF"
    afk2Button.StatusFrame.BackgroundColor3 = Settings.AutoFishingAFK2 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if Settings.AutoFishingAFK2 then
        autoFishingAFK2()
        createNotification("🎣 AFK2 AutoFish started! Mode: " .. Settings.AFK2_DelayMode, Color3.fromRGB(0, 200, 0))
    else
        createNotification("🎣 AFK2 AutoFish stopped!", Color3.fromRGB(200, 0, 0))
    end
end)

connections[#connections + 1] = extremeButton.Button.MouseButton1Click:Connect(function()
    if Settings.AutoFishing or Settings.AutoFishingAFK2 or Settings.AutoFishingBrutal then
        createNotification("❌ Turn off other fishing modes first!", Color3.fromRGB(255, 0, 0))
        return
    end
    
    if not Settings.AutoFishingExtreme then
        createNotification("⚠️ WARNING: EXTREME mode has HIGH detection risk!", Color3.fromRGB(255, 255, 0))
        task.wait(0.5)
    end
    
    Settings.AutoFishingExtreme = not Settings.AutoFishingExtreme
    extremeButton.Button.Text = Settings.AutoFishingExtreme and "ON" or "OFF"
    extremeButton.StatusFrame.BackgroundColor3 = Settings.AutoFishingExtreme and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 0, 0)
    
    if Settings.AutoFishingExtreme then
        autoFishingExtreme()
        createNotification("⚡ EXTREME AutoFish started! Speed: " .. Settings.ExtremeSpeed, Color3.fromRGB(255, 0, 0))
    else
        createNotification("⚡ EXTREME AutoFish stopped!", Color3.fromRGB(200, 0, 0))
    end
end)

connections[#connections + 1] = brutalButton.Button.MouseButton1Click:Connect(function()
    if Settings.AutoFishing or Settings.AutoFishingAFK2 or Settings.AutoFishingExtreme then
        createNotification("❌ Turn off other fishing modes first!", Color3.fromRGB(255, 0, 0))
        return
    end
    
    if not Settings.AutoFishingBrutal then
        createNotification("🔥 WARNING: BRUTAL mode has ULTRA detection risk!", Color3.fromRGB(255, 0, 255))
        task.wait(0.5)
    end
    
    Settings.AutoFishingBrutal = not Settings.AutoFishingBrutal
    brutalButton.Button.Text = Settings.AutoFishingBrutal and "ON" or "OFF"
    brutalButton.StatusFrame.BackgroundColor3 = Settings.AutoFishingBrutal and Color3.fromRGB(255, 0, 255) or Color3.fromRGB(0, 0, 0)
    
    if Settings.AutoFishingBrutal then
        autoFishingBrutal()
        createNotification("🔥 BRUTAL AutoFish started! Delay: " .. Settings.BrutalCustomDelay .. "s", Color3.fromRGB(255, 0, 255))
    else
        createNotification("🔥 BRUTAL AutoFish stopped!", Color3.fromRGB(255, 0, 255))
    end
end)

-- Player Frame Buttons
connections[#connections + 1] = walkSpeedInput.TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local speed = tonumber(walkSpeedInput.TextBox.Text)
        if speed and speed >= 1 and speed <= 100 then
            Settings.WalkSpeed = speed
            setWalkSpeed(speed)
            createNotification("🏃 Walk Speed set to " .. speed, Color3.fromRGB(0, 255, 0))
            walkSpeedInput.TextBox.Text = ""
        else
            createNotification("❌ Invalid speed! Use 1-100", Color3.fromRGB(255, 0, 0))
            walkSpeedInput.TextBox.Text = ""
        end
    end
end)

connections[#connections + 1] = jumpPowerInput.TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local power = tonumber(jumpPowerInput.TextBox.Text)
        if power and power >= 1 and power <= 200 then
            Settings.JumpPower = power
            setJumpPower(power)
            createNotification("🦘 Jump Power set to " .. power, Color3.fromRGB(0, 255, 0))
            jumpPowerInput.TextBox.Text = ""
        else
            createNotification("❌ Invalid power! Use 1-200", Color3.fromRGB(255, 0, 0))
            jumpPowerInput.TextBox.Text = ""
        end
    end
end)

local espEnabled = false
connections[#connections + 1] = espButton.Button.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espButton.Button.Text = espEnabled and "ON" or "OFF"
    espButton.StatusFrame.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if espEnabled then
        createNotification("👁️ Player ESP enabled!", Color3.fromRGB(0, 200, 0))
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= player then
                createESP(targetPlayer)
            end
        end
    else
        createNotification("👁️ Player ESP disabled!", Color3.fromRGB(200, 0, 0))
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            removeESP(targetPlayer)
        end
    end
end)

connections[#connections + 1] = sellAllButton.Button.MouseButton1Click:Connect(function()
    safeCall(function()
        sellAll:InvokeServer()
        createNotification("💰 Selling all fish...", Color3.fromRGB(255, 215, 0))
    end)
end)

-- Security Frame Buttons
connections[#connections + 1] = adminDetectionButton.Button.MouseButton1Click:Connect(function()
    SecuritySettings.AdminDetection = not SecuritySettings.AdminDetection
    adminDetectionButton.Button.Text = SecuritySettings.AdminDetection and "ON" or "OFF"
    adminDetectionButton.StatusFrame.BackgroundColor3 = SecuritySettings.AdminDetection and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if SecuritySettings.AdminDetection then
        createNotification("🔒 Admin Detection enabled!", Color3.fromRGB(0, 200, 0))
    else
        createNotification("🔒 Admin Detection disabled!", Color3.fromRGB(200, 0, 0))
    end
end)

connections[#connections + 1] = proximityAlertButton.Button.MouseButton1Click:Connect(function()
    SecuritySettings.PlayerProximityAlert = not SecuritySettings.PlayerProximityAlert
    proximityAlertButton.Button.Text = SecuritySettings.PlayerProximityAlert and "ON" or "OFF"
    proximityAlertButton.StatusFrame.BackgroundColor3 = SecuritySettings.PlayerProximityAlert and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if SecuritySettings.PlayerProximityAlert then
        createNotification("📡 Proximity Alert enabled!", Color3.fromRGB(0, 200, 0))
    else
        createNotification("📡 Proximity Alert disabled!", Color3.fromRGB(200, 0, 0))
    end
end)

connections[#connections + 1] = autoHideButton.Button.MouseButton1Click:Connect(function()
    SecuritySettings.AutoHideOnAdmin = not SecuritySettings.AutoHideOnAdmin
    autoHideButton.Button.Text = SecuritySettings.AutoHideOnAdmin and "ON" or "OFF"
    autoHideButton.StatusFrame.BackgroundColor3 = SecuritySettings.AutoHideOnAdmin and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if SecuritySettings.AutoHideOnAdmin then
        createNotification("🙈 Auto Hide enabled!", Color3.fromRGB(0, 200, 0))
    else
        createNotification("🙈 Auto Hide disabled!", Color3.fromRGB(200, 0, 0))
    end
end)

-- Advanced Frame Buttons
connections[#connections + 1] = luckBoostButton.Button.MouseButton1Click:Connect(function()
    Settings.LuckBoost = not Settings.LuckBoost
    luckBoostButton.Button.Text = Settings.LuckBoost and "ON" or "OFF"
    luckBoostButton.StatusFrame.BackgroundColor3 = Settings.LuckBoost and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if Settings.LuckBoost then
        createNotification("🍀 Luck Boost enabled!", Color3.fromRGB(0, 255, 0))
    else
        createNotification("🍀 Luck Boost disabled!", Color3.fromRGB(200, 0, 0))
    end
end)

connections[#connections + 1] = weatherBoostButton.Button.MouseButton1Click:Connect(function()
    Settings.WeatherBoost = not Settings.WeatherBoost
    weatherBoostButton.Button.Text = Settings.WeatherBoost and "ON" or "OFF"
    weatherBoostButton.StatusFrame.BackgroundColor3 = Settings.WeatherBoost and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if Settings.WeatherBoost then
        createNotification("🌦️ Weather Boost enabled!", Color3.fromRGB(0, 255, 0))
    else
        createNotification("🌦️ Weather Boost disabled!", Color3.fromRGB(200, 0, 0))
    end
end)

connections[#connections + 1] = smartFishingButton.Button.MouseButton1Click:Connect(function()
    Settings.SmartFishing = not Settings.SmartFishing
    smartFishingButton.Button.Text = Settings.SmartFishing and "ON" or "OFF"
    smartFishingButton.StatusFrame.BackgroundColor3 = Settings.SmartFishing and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)
    
    if Settings.SmartFishing then
        createNotification("🧠 Smart Fishing enabled!", Color3.fromRGB(0, 255, 0))
    else
        createNotification("🧠 Smart Fishing disabled!", Color3.fromRGB(200, 0, 0))
    end
end)

connections[#connections + 1] = fishValueInput.TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local value = tonumber(fishValueInput.TextBox.Text)
        if value and value >= 10 and value <= 1000 then
            Settings.MinFishValue = value
            Settings.FishValueFilter = true
            createNotification("💎 Min Fish Value set to ₡" .. value, Color3.fromRGB(0, 150, 255))
            fishValueInput.TextBox.Text = ""
        else
            createNotification("❌ Invalid value! Use 10-1000", Color3.fromRGB(255, 0, 0))
            fishValueInput.TextBox.Text = ""
        end
    end
end)

-- Menu button connections
for name, button in pairs(menuButtons) do
    connections[#connections + 1] = button.MouseButton1Click:Connect(function()
        showPanel(name)
    end)
end

-- Exit button
connections[#connections + 1] = UIComponents.ExitButton.MouseButton1Click:Connect(function()
    gui:Destroy()
    for _, connection in pairs(connections) do
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end
    createNotification("👋 GUI Closed!", Color3.fromRGB(255, 165, 0))
end)

-- Floating button toggle
local isGUIHidden = false
connections[#connections + 1] = floatingButtonClick.MouseButton1Click:Connect(function()
    isGUIHidden = not isGUIHidden
    mainFrame.Visible = not isGUIHidden
    
    if isGUIHidden then
        floatingButtonText.Text = "👁️"
        floatingButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        createNotification("📦 GUI Hidden - Click to show", Color3.fromRGB(255, 165, 0))
    else
        floatingButtonText.Text = "🎣"
        floatingButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
        createNotification("📦 GUI Shown", Color3.fromRGB(0, 255, 0))
    end
end)

-- Hotkey for hiding GUI
connections[#connections + 1] = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == CONFIG.HOTKEY then
        isGUIHidden = not isGUIHidden
        mainFrame.Visible = not isGUIHidden
        
        if isGUIHidden then
            floatingButtonText.Text = "👁️"
            floatingButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            createNotification("📦 GUI Hidden - Press F9 or click floating button", Color3.fromRGB(255, 165, 0))
        else
            floatingButtonText.Text = "🎣"
            floatingButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
            createNotification("📦 GUI Shown", Color3.fromRGB(0, 255, 0))
        end
    end
end)

-- ===================================================================
--                         UPDATE LOOPS
-- ===================================================================

-- Statistics updater
connections[#connections + 1] = RunService.Heartbeat:Connect(function()
    local sessionTime = math.floor((tick() - Stats.sessionStartTime) / 60)
    local currentLuck = calculateCurrentLuck()
    local luckPercent = math.floor(currentLuck * 1000) / 10
    
    -- Update main stats
    statsDisplay.TextLabel.Text = string.format("🐟 Fish: %d | ⏰ Session: %dm | 🍀 Luck: Lv%d (%.1f%%)", 
        Stats.fishCaught, sessionTime, Stats.currentLuckLevel, luckPercent)
    
    -- Update weather display
    local weatherEffect = WeatherEffects[currentWeather]
    if weatherEffect then
        weatherDisplay.TextLabel.Text = weatherEffect.description
    end
    
    -- Update security statistics
    securityStatsDisplay.TextLabel.Text = string.format("🔒 Admins: %d | 📡 Alerts: %d | 🙈 Auto-Hides: %d", 
        SecurityStats.AdminsDetected, SecurityStats.ProximityAlerts, SecurityStats.AutoHides)
    
    -- Update advanced statistics
    advancedStatsDisplay.TextLabel.Text = string.format("💰 Money: ₡%d | 🏆 Rare: %d | 👑 Legendary: %d", 
        Stats.moneyEarned, Stats.rareFishCaught, Stats.legendaryFishCaught)
    
    -- Calculate rates
    if sessionTime > 0 then
        Stats.fishPerMinute = math.floor((Stats.fishCaught / sessionTime) * 10) / 10
        Stats.moneyPerHour = math.floor((Stats.moneyEarned / sessionTime) * 60)
    end
end)

-- Auto sell loop
task.spawn(function()
    while true do
        if Settings.AutoSell then
            safeCall(function()
                sellAll:InvokeServer()
                Stats.moneyEarned = Stats.moneyEarned + (Stats.fishCaught * 10) -- Estimate
            end)
        end
        task.wait(10) -- Sell every 10 seconds
    end
end)

-- Character update handler
connections[#connections + 1] = player.CharacterAdded:Connect(function()
    task.wait(1) -- Wait for character to load
    setWalkSpeed(Settings.WalkSpeed)
    setJumpPower(Settings.JumpPower)
end)

-- Player join/leave handlers for ESP
connections[#connections + 1] = Players.PlayerAdded:Connect(function(targetPlayer)
    if espEnabled and targetPlayer ~= player then
        targetPlayer.CharacterAdded:Connect(function()
            createESP(targetPlayer)
        end)
    end
end)

connections[#connections + 1] = Players.PlayerRemoving:Connect(function(targetPlayer)
    removeESP(targetPlayer)
end)

-- ===================================================================
--                         INITIALIZATION
-- ===================================================================

-- Start systems
antiAFK()
initializeSecurity()
startWeatherCycle()

-- Start with Main panel
showPanel("MAIN")

-- Set initial button states
adminDetectionButton.Button.Text = SecuritySettings.AdminDetection and "ON" or "OFF"
adminDetectionButton.StatusFrame.BackgroundColor3 = SecuritySettings.AdminDetection and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)

proximityAlertButton.Button.Text = SecuritySettings.PlayerProximityAlert and "ON" or "OFF"
proximityAlertButton.StatusFrame.BackgroundColor3 = SecuritySettings.PlayerProximityAlert and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)

autoHideButton.Button.Text = SecuritySettings.AutoHideOnAdmin and "ON" or "OFF"
autoHideButton.StatusFrame.BackgroundColor3 = SecuritySettings.AutoHideOnAdmin and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 0, 0)

-- Welcome notification
createNotification("🎣 " .. CONFIG.GUI_TITLE .. " V2.0 Loaded!", Color3.fromRGB(0, 255, 0))

print("✅ " .. CONFIG.GUI_TITLE .. " V2.0 (Complete) loaded successfully!")
print("🎯 FLOATING BUTTON: Click the blue floating button to hide/show GUI")
print("📌 Hotkey: Press F9 to hide/show GUI")
print("🔗 UI Module loaded from: " .. UI_MODULE_URL)
print("🎣 All Auto Fish modes: Regular, AFK2, Extreme, Brutal")
print("🛒 Auto Sell functionality")
print("💨 No Oxygen feature")
print("🔒 Security Features: Admin Detection, Proximity Alerts, Auto Hide")
print("📦 GUI Features: Enhanced Floating Button, Draggable Interface")
print("🍀 Advanced Features: Luck System, Weather Effects, Smart Fishing")
print("📊 Analytics: Fish Rarity Tracking, Money Counter, Performance Stats")
print("👁️ ESP System for players")
print("🏃 Walk Speed & Jump Power control")

-- Handle player leaving
connections[#connections + 1] = Players.PlayerRemoving:Connect(function(leavingPlayer)
    if leavingPlayer == player then
        for _, connection in pairs(connections) do
            if connection and connection.Connected then
                connection:Disconnect()
            end
        end
    end
end)

end) -- End of main pcall

if not success then
    warn("❌ Script failed to load: " .. tostring(error))
else
    print("🎉 Complete Script loaded successfully!")
end
