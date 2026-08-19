-- Hyprland Lua config (replaces hyprland.conf)
-- Lua wins over .conf; the old .conf files are kept as rollback.

require("scheme.current")
require("variables")

-- Monitors
hl.monitor({ output = "eDP-1", mode = "2560x1440@165", position = "0x0", scale = "1.33" })

-- Modules (mirror the old source = $hl/*.conf split)
require("hyprland.env")
require("hyprland.general")
require("hyprland.input")
require("hyprland.misc")
require("hyprland.animations")
require("hyprland.decoration")
require("hyprland.group")
require("hyprland.execs")
require("hyprland.rules")
require("hyprland.gestures")
require("hyprland.keybinds")
require("hyprland.scrolling")

-- env overrides from hyprland.conf (loaded last, wins over env.lua values)
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("XCURSOR_SIZE", "24")

-- Flawed-Shell autostart (was exec-once in hyprland.conf)
hl.on("hyprland.start", function()
    hl.exec_cmd("sleep 1; env MALLOC_CONF='narenas:2,background_thread:true,dirty_decay_ms:1000,muzzy_decay_ms:1000' qs -p '/home/flawed/.config/Flawed-Shell/shell.qml'")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("awww img /home/flawed/Pictures/Wallpapers/wallpaperflare.com_wallpaper.jpg")
    hl.exec_cmd("xwayland-satellite")
end)
