-- Hand-converted from keybinds.conf
-- Old "$wsaction = ..." was a keybinds-local var.
-- Replicates wsaction.fish: SUPER+N = within current group of 10,
-- CTRL+SUPER+N = switch to group N keeping current position.
local function wsGroupTarget(keyNum, isGroup)
    local aws = hl.get_active_workspace()
    local active = aws and aws.id or 1
    if isGroup then
        return (keyNum - 1) * 10 + (active % 10)
    else
        return math.floor((active - 1) / 10) * 10 + keyNum
    end
end

-- Launcher
hl.bind("SUPER + space", hl.dsp.exec_cmd("wofi --show drun"))

-- Session
hl.bind(kbSession, hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(kbLock, hl.dsp.exec_cmd("hyprlock"))
hl.bind(kbRestoreLock, hl.dsp.exec_cmd("hyprlock"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true })

-- Media
hl.bind("CTRL + SUPER + Space", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"), { locked = true })
hl.bind("CTRL + SUPER + Equal", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("CTRL + SUPER + Minus", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output"), { locked = true })
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("SUPER + SHIFT + ALT + S", hl.dsp.exec_cmd("hyprshot -m region --freeze"))

-- Clipboard
hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind("SUPER + ALT + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu -p \"History\" | cliphist decode | wl-copy"))
hl.bind("CTRL + SHIFT + ALT + V", hl.dsp.exec_cmd("sleep 0.5s && ydotool type -d 1 \"$(cliphist list | head -1 | cliphist decode)\""), { locked = true })

-- Emoji picker
hl.bind("SUPER + Period", hl.dsp.exec_cmd("wofi --show emoji"))

-- Screen recording
hl.bind("SUPER + ALT + R", hl.dsp.exec_cmd("wf-recorder -f ~/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4 -a"))
hl.bind("CTRL + ALT + R", hl.dsp.exec_cmd("wf-recorder -f ~/Videos/recording-$(date +%Y%m%d-%H%M%S).mp4"))

-- Special workspace toggles
hl.bind(kbToggleSpecialWs, hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-steam.fish"))
hl.bind(kbSystemMonitor, hl.dsp.workspace.toggle_special("sysmon"))
hl.bind(kbMusic, hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-spotify.fish"))
hl.bind(kbCommunication, hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-discord.fish"))
hl.bind(kbTodo, hl.dsp.workspace.toggle_special("todo"))

-- Apps
hl.bind(kbTerminal, hl.dsp.exec_cmd(terminal))
hl.bind(kbBrowser, hl.dsp.exec_cmd(browser))
hl.bind(kbEditor, hl.dsp.exec_cmd(editor))
hl.bind("SUPER + G", hl.dsp.exec_cmd("github-desktop"))
hl.bind(kbFileExplorer, hl.dsp.exec_cmd(fileExplorer))
hl.bind("SUPER + ALT + E", hl.dsp.exec_cmd("nemo"))
hl.bind("CTRL + ALT + Escape", hl.dsp.exec_cmd("qps"))
hl.bind("CTRL + ALT + V", hl.dsp.exec_cmd("pavucontrol"))

-- Volume
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ " .. volumeStep .. "%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. volumeStep .. "%-"), { locked = true, repeating = true })

-- Sleep
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("systemctl suspend-then-hibernate"), { locked = true })

-- Go to workspace (0 == 10 in old keybinds)
for i = 1, 10 do
    local key = i == 10 and "0" or tostring(i)
    hl.bind(kbGoToWs .. " + " .. key, function()
        return hl.dispatch(hl.dsp.focus({ workspace = tostring(wsGroupTarget(i, false)) }))
    end)
    hl.bind(kbGoToWsGroup .. " + " .. key, function()
        return hl.dispatch(hl.dsp.focus({ workspace = tostring(wsGroupTarget(i, true)) }))
    end)
end

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "-1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "+1" }))
hl.bind(kbPrevWs, hl.dsp.focus({ workspace = "-1" }), { repeating = true })
hl.bind(kbNextWs, hl.dsp.focus({ workspace = "+1" }), { repeating = true })
hl.bind("SUPER + Page_Up", hl.dsp.focus({ workspace = "-1" }), { repeating = true })
hl.bind("SUPER + Page_Down", hl.dsp.focus({ workspace = "+1" }), { repeating = true })
hl.bind("CTRL + SUPER + mouse_down", hl.dsp.focus({ workspace = "-10" }))
hl.bind("CTRL + SUPER + mouse_up", hl.dsp.focus({ workspace = "+10" }))

-- Move window to workspace
for i = 1, 10 do
    local key = i == 10 and "0" or tostring(i)
    hl.bind(kbMoveWinToWs .. " + " .. key, function()
        return hl.dispatch(hl.dsp.window.move({ workspace = tostring(wsGroupTarget(i, false)) }))
    end)
    hl.bind(kbMoveWinToWsGroup .. " + " .. key, function()
        return hl.dispatch(hl.dsp.window.move({ workspace = tostring(wsGroupTarget(i, true)) }))
    end)
end

hl.bind("SUPER + ALT + Page_Up", hl.dsp.window.move({ workspace = "-1" }), { repeating = true })
hl.bind("SUPER + ALT + Page_Down", hl.dsp.window.move({ workspace = "+1" }), { repeating = true })
hl.bind("SUPER + ALT + mouse_down", hl.dsp.window.move({ workspace = "-1" }))
hl.bind("SUPER + ALT + mouse_up", hl.dsp.window.move({ workspace = "+1" }))
hl.bind("CTRL + SUPER + SHIFT + right", hl.dsp.window.move({ workspace = "+1" }), { repeating = true })
hl.bind("CTRL + SUPER + SHIFT + left", hl.dsp.window.move({ workspace = "-1" }), { repeating = true })
hl.bind("CTRL + SUPER + SHIFT + up", hl.dsp.window.move({ workspace = "special:special" }))
hl.bind("CTRL + SUPER + SHIFT + down", hl.dsp.window.move({ workspace = "e+0" }))
hl.bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special:special" }))

-- Window groups
hl.bind(kbWindowGroupCycleNext, hl.dsp.window.cycle_next(), { repeating = true })
hl.bind(kbWindowGroupCyclePrev, hl.dsp.window.cycle_next({ next = false }), { repeating = true })
hl.bind("CTRL + ALT + Tab", hl.dsp.group.next(), { repeating = true })
hl.bind("CTRL + SHIFT + ALT + Tab", hl.dsp.group.prev(), { repeating = true })
hl.bind(kbToggleGroup, hl.dsp.group.toggle())
hl.bind(kbUngroup, hl.dsp.window.move({ out_of_group = true }))
hl.bind("SUPER + SHIFT + Comma", hl.dsp.group.lock_active({ action = "toggle" }))

-- Window actions
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Percent-based resizing (replaces old `resizeactive -10% 0` / `exact 55% 70%`)
local function resizePct(xpct, ypct)
    local w = hl.get_active_window()
    if not w then return end
    hl.dispatch(hl.dsp.window.resize({ x = w.size.x * xpct / 100, y = w.size.y * ypct / 100, relative = true }))
end
local function resizeExactPct(wpct, hpct)
    local m = hl.get_active_monitor()
    local w = hl.get_active_window()
    if not m or not w then return end
    hl.dispatch(hl.dsp.window.resize({ x = m.size.width * wpct / 100, y = m.size.height * hpct / 100, relative = false }))
end

hl.bind("SUPER + Minus", function() resizePct(-10, 0) end, { repeating = true })
hl.bind("SUPER + Equal", function() resizePct(10, 0) end, { repeating = true })
hl.bind("SUPER + SHIFT + Minus", function() resizePct(0, -10) end, { repeating = true })
hl.bind("SUPER + SHIFT + Equal", function() resizePct(0, 10) end, { repeating = true })
hl.bind("SUPER + ALT + left", function() resizePct(-10, 0) end, { repeating = true })
hl.bind("SUPER + ALT + right", function() resizePct(10, 0) end, { repeating = true })
hl.bind("SUPER + ALT + up", function() resizePct(0, -10) end, { repeating = true })
hl.bind("SUPER + ALT + down", function() resizePct(0, 10) end, { repeating = true })

-- Mouse drag/resize (old bindm)
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(kbMoveWindow, hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(kbResizeWindow, hl.dsp.window.resize(), { mouse = true })

hl.bind("CTRL + SUPER + Backslash", hl.dsp.window.center())
hl.bind("CTRL + SUPER + ALT + Backslash", function()
    resizeExactPct(55, 70)
    hl.dispatch(hl.dsp.window.center())
end)
hl.bind(kbPinWindow, hl.dsp.window.pin())
hl.bind(kbWindowFullscreen, hl.dsp.window.fullscreen({ mode = "fullscreen" }))       -- old `fullscreen, 0`
hl.bind(kbWindowBorderedFullscreen, hl.dsp.window.fullscreen({ mode = "maximized" })) -- old `fullscreen, 1`
hl.bind(kbToggleWindowFloating, hl.dsp.window.float())
hl.bind(kbCloseWindow, hl.dsp.window.close())

-- From hyprland.conf (not duplicated in keybinds.conf)
hl.bind("SUPER + o", hl.dsp.window.float())

-- Test notification
hl.bind("SUPER + ALT + f12", hl.dsp.exec_cmd("notify-send -u low -i dialog-information-symbolic 'Test notification' \"Here's a really long message to test truncation and wrapping\\nYou can middle click or flick this notification to dismiss it!\" -a 'Flawed-Shell' -A \"Test1=I got it!\" -A \"Test2=Another action\""), { locked = true })
