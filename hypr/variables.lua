-- Hand-converted from variables.conf
-- Old "$var = value" becomes a Lua global. Modules reference these directly.
-- NOTE: globals are shared across require()'d files (same Lua state).

-- ### Hyprland ###
-- Apps
terminal = "foot"
browser = "zen-browser"
editor = "codium"
fileExplorer = "dolphin"

-- Touchpad
touchpadDisableTyping = true
touchpadScrollFactor = 0.3
workspaceSwipeFingers = 4
gestureFingers = 3
gestureFingersMore = 4

-- Blur
blurEnabled = true
blurSpecialWs = false
blurPopups = true
blurInputMethods = true
blurSize = 8
blurPasses = 2
blurXray = false

-- Shadow
shadowEnabled = true
shadowRange = 20
shadowRenderPower = 3
shadowColour = "rgb(" .. scheme.surfaceDim .. ")"

-- Gaps
workspaceGaps = 20
windowGapsIn = 5
windowGapsOut = 10
singleWindowGapsOut = 20

-- Window styling
windowOpacity = 0.95
windowRounding = 15

windowBorderSize = 1
activeWindowBorderColour = "rgb(" .. scheme.primary .. ")"
inactiveWindowBorderColour = "rgb(" .. scheme.onSurfaceVariant .. ")"

-- Misc
volumeStep = 10  -- In percent
cursorTheme = "sweet-cursors"
cursorSize = 24

-- ### Keybinds ###
-- Workspaces (mods strings; keys are appended/combined in keybinds.lua)
kbMoveWinToWs = "SUPER + ALT"
kbMoveWinToWsGroup = "CTRL + SUPER + ALT"
kbGoToWs = "SUPER"
kbGoToWsGroup = "CTRL + SUPER"

kbNextWs = "CTRL + SUPER + right"
kbPrevWs = "CTRL + SUPER + left"

kbToggleSpecialWs = "SUPER + S"

-- Window groups
kbWindowGroupCycleNext = "ALT + Tab"
kbWindowGroupCyclePrev = "SHIFT + ALT + Tab"
kbUngroup = "SUPER + U"
kbToggleGroup = "SUPER + Comma"

-- Window actions
kbMoveWindow = "SUPER + Z"
kbResizeWindow = "SUPER + X"
kbWindowPip = "SUPER + ALT + Backslash"
kbPinWindow = "SUPER + P"
kbWindowFullscreen = "SUPER + F"
kbWindowBorderedFullscreen = "SUPER + ALT + F"
kbToggleWindowFloating = "SUPER + ALT + Space"
kbCloseWindow = "SUPER + Q"

-- Special workspace toggles
kbSystemMonitor = "CTRL + SHIFT + Escape"
kbMusic = "SUPER + M"
kbCommunication = "SUPER + D"
kbTodo = "SUPER + R"

-- Apps
kbTerminal = "SUPER + T"
kbBrowser = "SUPER + W"
kbEditor = "SUPER + C"
kbFileExplorer = "SUPER + E"

-- Misc
kbSession = "CTRL + ALT + Delete"
kbShowSidebar = "SUPER + N"
kbClearNotifs = "CTRL + ALT + C"
kbShowPanels = "SUPER + K"
kbLock = "SUPER + L"
kbRestoreLock = "SUPER + ALT + L"
