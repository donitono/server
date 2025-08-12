-- ===================================================================
--                    KONFIGURASI COMPLETE VERSION
--                 BERDASARKAN SCRIPT SPIN.LUA ASLI
-- ===================================================================

--[[
    INI ADALAH VERSI COMPLETE YANG MENGGUNAKAN SEMUA FITUR DARI SPIN.LUA:
    
    ✅ Semua Auto Fish modes (Regular, AFK2, Extreme, Brutal)
    ✅ Security system (Admin Detection, Proximity Alert, Auto Hide)
    ✅ Advanced features (Luck System, Weather Effects, Smart Fishing)
    ✅ Player features (Walk Speed, Jump Power, ESP)
    ✅ Statistics tracking (Fish count, Money, Rarity tracking)
    ✅ Enhanced UI (Floating button, Drag & drop, Notifications)
    
    CARA PENGGUNAAN:
    1. Upload ui_module_complete.lua ke GitHub
    2. Upload main_script_complete.lua ke GitHub
    3. Edit URL di bawah dengan GitHub raw URL Anda
    4. Upload config file ini ke GitHub
    5. Share URL config ini: loadstring(game:HttpGet("YOUR_CONFIG_URL"))()
]]

-- ===================================================================
--                           GITHUB URLS
-- ===================================================================

-- GANTI URL INI DENGAN GITHUB RAW URL ANDA
local GITHUB_CONFIG = {
    -- URL untuk UI Module Complete (WAJIB GANTI)
    UI_MODULE = "https://raw.githubusercontent.com/donitono/server/refs/heads/main/ui_module_complete.lua",
    
    -- URL untuk Main Script Complete (WAJIB GANTI)
    MAIN_SCRIPT = "https://raw.githubusercontent.com/donitono/server/refs/heads/main/main_script_complete.lua",
    
    -- Informasi Repository
    REPO_NAME = "server",
    USERNAME = "donitono",
    BRANCH = "main"
}

-- ===================================================================
--                        SCRIPT CONFIGURATION
-- ===================================================================

local SCRIPT_CONFIG = {
    -- Nama GUI
    GUI_NAME = "SpinnerFISHIT",
    GUI_TITLE = "FISH SCRIPT",
    
    -- Hotkey untuk hide/show (F1-F12)
    HOTKEY = "F9",
    
    -- Auto save settings
    AUTO_SAVE = true,
    
    -- Notification duration (detik)
    NOTIFICATION_TIME = 3,
    
    -- Fishing delays (detik)
    FISHING_DELAYS = {
        MIN = 0.1,
        MAX = 0.3
    },
    
    -- Default player stats
    DEFAULT_WALK_SPEED = 16,
    DEFAULT_JUMP_POWER = 50,
    
    -- Security settings
    SECURITY_ENABLED = true,
    ADMIN_DETECTION = true,
    PROXIMITY_ALERT = true,
    AUTO_HIDE = true,
    
    -- Advanced features
    LUCK_SYSTEM = true,
    WEATHER_EFFECTS = true,
    SMART_FISHING = true,
    ESP_ENABLED = false
}

-- ===================================================================
--                           FEATURE FLAGS
-- ===================================================================

local FEATURES = {
    -- Auto Fishing Modes
    BASIC_AUTOFISH = true,
    AFK2_AUTOFISH = true,
    EXTREME_AUTOFISH = true,  -- Tinggi risk detection
    BRUTAL_AUTOFISH = true,   -- Ultra risk detection
    
    -- Security Features
    ADMIN_DETECTION = true,
    PROXIMITY_ALERTS = true,
    AUTO_HIDE_ON_ADMIN = true,
    
    -- Advanced Features
    LUCK_BOOST_SYSTEM = true,
    WEATHER_BOOST_SYSTEM = true,
    SMART_FISHING_AI = true,
    FISH_VALUE_FILTER = true,
    
    -- Player Features
    WALK_SPEED_CONTROL = true,
    JUMP_POWER_CONTROL = true,
    ESP_SYSTEM = true,
    TELEPORTATION = true,
    
    -- GUI Features
    FLOATING_BUTTON = true,
    DRAG_AND_DROP = true,
    NOTIFICATIONS = true,
    STATISTICS_DISPLAY = true,
    MULTI_PANEL_INTERFACE = true,
    
    -- Safety Features
    ANTI_AFK = true,
    ERROR_HANDLING = true,
    SAFE_CALLS = true
}

-- ===================================================================
--                           LOADER LOGIC
-- ===================================================================

local function loadCompleteScript()
    print("🚀 Loading FISH SCRIPT Complete Version...")
    print("📡 Repository: " .. GITHUB_CONFIG.USERNAME .. "/" .. GITHUB_CONFIG.REPO_NAME)
    print("🔧 Features: All features from spin.lua included")
    
    -- Cek apakah GUI sudah ada
    local player = game.Players.LocalPlayer
    if player.PlayerGui:FindFirstChild(SCRIPT_CONFIG.GUI_NAME) then
        print("🔄 Destroying existing GUI...")
        player.PlayerGui[SCRIPT_CONFIG.GUI_NAME]:Destroy()
        wait(0.5)
    end
    
    -- Load main script yang akan load UI module
    local success, error_msg = pcall(function()
        -- Inject configuration ke main script
        _G.ZayrosFishConfig = {
            GitHub = GITHUB_CONFIG,
            Script = SCRIPT_CONFIG,
            Features = FEATURES
        }
        
        print("🔄 Loading main script...")
        
        -- Test URL terlebih dahulu
        local testSuccess, testResult = pcall(function()
            return game:HttpGet(GITHUB_CONFIG.MAIN_SCRIPT)
        end)
        
        if not testSuccess then
            error("Failed to fetch main script: " .. tostring(testResult))
        end
        
        if #testResult < 100 then
            error("Main script file is too small or empty")
        end
        
        -- Load main script complete
        loadstring(testResult)()
    end)
    
    if success then
        print("✅ FISH SCRIPT Complete loaded successfully!")
        print("🎣 All features from spin.lua are available!")
        print("🔧 Available modes:")
        print("   - Regular Auto Fish")
        print("   - AFK2 Auto Fish (customizable delays)")  
        print("   - Extreme Auto Fish (high speed, high risk)")
        print("   - Brutal Auto Fish (ultra speed, ultra risk)")
        print("🛡️ Security features:")
        print("   - Admin Detection")
        print("   - Proximity Alerts") 
        print("   - Auto Hide on Admin")
        print("🍀 Advanced features:")
        print("   - Luck Boost System")
        print("   - Weather Effects")
        print("   - Smart Fishing AI")
        print("👁️ Player features:")
        print("   - ESP System")
        print("   - Walk Speed Control")
        print("   - Jump Power Control")
        print("📊 Statistics & Analytics")
        print("📦 Enhanced GUI with floating button")
    else
        warn("❌ Failed to load script: " .. tostring(error_msg))
        warn("💡 Possible solutions:")
        warn("   1. Check your GitHub URLs")
        warn("   2. Make sure files exist on GitHub")
        warn("   3. Check internet connection")
        warn("   4. Verify file names are correct:")
        warn("      - ui_module_complete.lua")
        warn("      - main_script_complete.lua")
        warn("🔗 Current URLs:")
        warn("   UI: " .. GITHUB_CONFIG.UI_MODULE)
        warn("   Main: " .. GITHUB_CONFIG.MAIN_SCRIPT)
    end
end

-- ===================================================================
--                           VALIDATION
-- ===================================================================

local function validateCompleteConfig()
    -- Cek apakah URL sudah diganti (sekarang menggunakan donitono/server yang valid)
    if GITHUB_CONFIG.USERNAME == "XSan" or GITHUB_CONFIG.REPO_NAME == "SpinnerFISHIT" then
        warn("❌ Please edit the GitHub URLs in this config file!")
        warn("📝 Change 'yourusername' and 'yourrepo' to your actual GitHub info")
        warn("📝 Also update 'fish-script' to your actual repository name")
        return false
    end
    
    -- Cek format URL
    if not string.match(GITHUB_CONFIG.UI_MODULE, "raw%.githubusercontent%.com") then
        warn("❌ Invalid GitHub raw URL format!")
        warn("📝 URL should start with: https://raw.githubusercontent.com/")
        return false
    end
    
    -- Cek apakah menggunakan file complete
    if not string.match(GITHUB_CONFIG.UI_MODULE, "ui_module_complete") then
        warn("⚠️ Warning: URL should point to ui_module_complete.lua for full features")
    end
    
    if not string.match(GITHUB_CONFIG.MAIN_SCRIPT, "main_script_complete") then
        warn("⚠️ Warning: URL should point to main_script_complete.lua for full features")
    end
    
    return true
end

-- ===================================================================
--                           EXECUTION
-- ===================================================================

-- Validasi dan load script
if validateCompleteConfig() then
    loadCompleteScript()
else
    print("🔧 Please configure your GitHub URLs first!")
    print("📖 Instructions:")
    print("1. Upload ui_module_complete.lua to your GitHub repository")
    print("2. Upload main_script_complete.lua to your GitHub repository") 
    print("3. Get the raw URLs for both files")
    print("4. Replace the URLs in GITHUB_CONFIG above")
    print("5. Upload this config file to GitHub")
    print("6. Share the raw URL of this config file")
end

--[[
    EXAMPLE GITHUB RAW URLS:
    
    UI Module Complete:
    https://raw.githubusercontent.com/username/fish-script/main/ui_module_complete.lua
    
    Main Script Complete:
    https://raw.githubusercontent.com/username/fish-script/main/main_script_complete.lua
    
    Config File:
    https://raw.githubusercontent.com/username/fish-script/main/config_complete.lua
    
    FINAL USAGE:
    loadstring(game:HttpGet("https://raw.githubusercontent.com/username/fish-script/main/config_complete.lua"))()
    
    PERBEDAAN DENGAN VERSI SEDERHANA:
    - Versi ini memiliki SEMUA fitur dari spin.lua original
    - UI lebih kompleks dengan banyak panel
    - Security system yang lengkap
    - Advanced features seperti luck system, weather effects
    - Multiple auto fish modes dengan berbagai tingkat kecepatan
    - Statistics tracking yang detail
    - ESP system untuk players
    - Dan masih banyak lagi...
]]
