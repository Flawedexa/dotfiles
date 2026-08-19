-- Hand-converted from rules.conf
-- NOTE: legacy percent expressions (`size 60% 70%`, `move 100%-w-2% ...`) were
-- silently broken on 0.56 (muParser can't parse "%"/"w"). They are restored
-- here as real muParser expressions:
--   size 60% 70%            -> size = {"monitor_w*0.6", "monitor_h*0.7"}
--   move 100%-w-2% 100%-w-3% -> move = {"monitor_w*0.98 - window_w", "monitor_h*0.97 - window_h"}

-- ######## Window rules ########
hl.window_rule({ match = { fullscreen = false }, opacity = tostring(windowOpacity) .. " override" })

hl.window_rule({ match = { class = "equibop|org\\.quickshell|imv|swappy" }, opaque = true })  -- They use native transparency or we want them opaque
hl.window_rule({ match = { float = true, xwayland = false }, center = true })  -- Center all floating windows (not xwayland cause popups)

-- Float
hl.window_rule({ match = { class = "guifetch" }, float = true })  -- FlafyDev/guifetch
hl.window_rule({ match = { class = "yad" }, float = true })
hl.window_rule({ match = { class = "zenity" }, float = true })
hl.window_rule({ match = { class = "wev" }, float = true })
hl.window_rule({ match = { class = "org\\.gnome\\.FileRoller" }, float = true })
hl.window_rule({ match = { class = "file-roller" }, float = true })  -- WHY IS THERE TWOOOOOOOOOOOOOOOO
hl.window_rule({ match = { class = "blueman-manager" }, float = true })
hl.window_rule({ match = { class = "com\\.github\\.GradienceTeam\\.Gradience" }, float = true })
hl.window_rule({ match = { class = "feh" }, float = true })
hl.window_rule({ match = { class = "imv" }, float = true })
hl.window_rule({ match = { class = "system-config-printer" }, float = true })
hl.window_rule({ match = { class = "org\\.quickshell" }, float = true })

-- Float, resize and center
hl.window_rule({ match = { class = "foot", title = "nmtui" }, float = true })
hl.window_rule({ match = { class = "foot", title = "nmtui" }, size = { "monitor_w*0.6", "monitor_h*0.7" } })
hl.window_rule({ match = { class = "foot", title = "nmtui" }, center = true })
hl.window_rule({ match = { class = "org\\.gnome\\.Settings" }, float = true })
hl.window_rule({ match = { class = "org\\.gnome\\.Settings" }, size = { "monitor_w*0.7", "monitor_h*0.8" } })
hl.window_rule({ match = { class = "org\\.gnome\\.Settings" }, center = true })
hl.window_rule({ match = { class = "org\\.pulseaudio\\.pavucontrol|yad-icon-browser" }, float = true })
hl.window_rule({ match = { class = "org\\.pulseaudio\\.pavucontrol|yad-icon-browser" }, size = { "monitor_w*0.6", "monitor_h*0.7" } })
hl.window_rule({ match = { class = "org\\.pulseaudio\\.pavucontrol|yad-icon-browser" }, center = true })
hl.window_rule({ match = { class = "nwg-look" }, float = true })
hl.window_rule({ match = { class = "nwg-look" }, size = { "monitor_w*0.5", "monitor_h*0.6" } })
hl.window_rule({ match = { class = "nwg-look" }, center = true })

-- Special workspaces
hl.window_rule({ match = { class = "btop" }, workspace = "special:sysmon" })
hl.window_rule({ match = { class = "feishin|Spotify|Supersonic|Cider|com.github.th_ch.youtube_music|Plexamp|com-maxrave-simpmusic-MainKt" }, workspace = "special:music" })
hl.window_rule({ match = { initial_title = "Spotify( Free)?" }, workspace = "special:music" })  -- Spotify wayland, it has no class for some reason
hl.window_rule({ match = { class = "discord|equibop|vesktop|whatsapp" }, workspace = "special:communication" })
hl.window_rule({ match = { class = "Todoist" }, workspace = "special:todo" })
hl.window_rule({ match = { class = "steam" }, workspace = "special:special" })

-- Dialogs
hl.window_rule({ match = { title = "(Select|Open)( a)? (File|Folder)(s)?" }, float = true })
hl.window_rule({ match = { title = "File (Operation|Upload)( Progress)?" }, float = true })
hl.window_rule({ match = { title = ".* Properties" }, float = true })
hl.window_rule({ match = { title = "Export Image as PNG" }, float = true })
hl.window_rule({ match = { title = "GIMP Crash Debug" }, float = true })
hl.window_rule({ match = { title = "Save As" }, float = true })
hl.window_rule({ match = { title = "Library" }, float = true })

-- Picture in picture (resize and move done via script)
hl.window_rule({ match = { title = "Picture(-| )in(-| )[Pp]icture" }, move = { "monitor_w*0.98 - window_w", "monitor_h*0.97 - window_h" } })  -- Initial move so window doesn't shoot across the screen from the center
hl.window_rule({ match = { title = "Picture(-| )in(-| )[Pp]icture" }, keep_aspect_ratio = true })
hl.window_rule({ match = { title = "Picture(-| )in(-| )[Pp]icture" }, float = true })
hl.window_rule({ match = { title = "Picture(-| )in(-| )[Pp]icture" }, pin = true })

-- Creative software
hl.window_rule({ match = { class = "krita|gimp|inkscape|darktable|resolve|kdenlive|shotcut|blender|godot" }, opaque = true })

-- Ueberzugpp
hl.window_rule({ match = { class = "^(ueberzugpp_.*)$" }, float = true })
hl.window_rule({ match = { class = "^(ueberzugpp_.*)$" }, no_initial_focus = true })

-- Steam
hl.window_rule({ match = { class = "steam" }, rounding = 10 })
hl.window_rule({ match = { title = "Friends List", class = "steam" }, float = true })

-- Games (Steam, Lutris/Wine, Gamescope)
hl.window_rule({ match = { class = "(steam_app_(default|[0-9]+))|gamescope" }, opaque = true })
hl.window_rule({ match = { class = "(steam_app_(default|[0-9]+))|gamescope" }, immediate = true })  -- Allow tearing for games
hl.window_rule({ match = { class = "(steam_app_(default|[0-9]+))|gamescope" }, idle_inhibit = "always" })  -- Always idle inhibit when playing a game

-- Minecraft launcher consoles
hl.window_rule({ match = { class = "com-atlauncher-App", title = "ATLauncher Console" }, float = true })
hl.window_rule({ match = { class = "PandoraLauncher", title = "Minecraft Game Output" }, float = true })

-- Autodesk Fusion 360
hl.window_rule({ match = { title = "Fusion360|(Marking Menu)", class = "fusion360\\.exe" }, no_blur = true })

-- Ugh xwayland popups
hl.window_rule({ match = { xwayland = true, title = "win[0-9]+" }, no_dim = true })
hl.window_rule({ match = { xwayland = true, title = "win[0-9]+" }, no_shadow = true })
hl.window_rule({ match = { xwayland = true, title = "win[0-9]+" }, rounding = 10 })

-- ######## Workspace rules ########
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = singleWindowGapsOut })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = singleWindowGapsOut })

-- ######## Layer rules ########
hl.layer_rule({ match = { namespace = "hyprpicker" }, animation = "fade" })  -- Colour picker out animation
hl.layer_rule({ match = { namespace = "logout_dialog" }, animation = "fade" })  -- wlogout
hl.layer_rule({ match = { namespace = "selection" }, animation = "fade" })  -- slurp
hl.layer_rule({ match = { namespace = "wayfreeze" }, animation = "fade" })

-- Fuzzel
hl.layer_rule({ match = { namespace = "launcher" }, animation = "popin 80%" })
hl.layer_rule({ match = { namespace = "launcher" }, blur = true })

-- Flawed-Shell
hl.layer_rule({ match = { namespace = "flawed-(border-exclusion|area-picker)" }, no_anim = true })
hl.layer_rule({ match = { namespace = "flawed-(drawers|background)" }, animation = "fade" })
