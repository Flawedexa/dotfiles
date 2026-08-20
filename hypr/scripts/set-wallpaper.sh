#!/usr/bin/env bash
# Apply the wallpaper currently saved in Flawed-Shell settings.json.
# Called at boot (hyprland.lua) so the desktop always matches the shell's choice.
# Falls back to awww, then swww, then swaybg like the shell's picker does.

set -euo pipefail

SETTINGS="$HOME/.config/Flawed-Shell/settings.json"

if [ ! -f "$SETTINGS" ]; then
    echo "set-wallpaper: no settings.json at $SETTINGS" >&2
    exit 0
fi

path="$(python3 -c "import json,sys; print(json.load(open(sys.argv[1])).get('wallpaperCurrent',''))" "$SETTINGS" 2>/dev/null || true)"

if [ -z "$path" ]; then
    echo "set-wallpaper: no wallpaperCurrent in settings.json" >&2
    exit 0
fi

if [ ! -f "$path" ]; then
    echo "set-wallpaper: $path does not exist" >&2
    exit 0
fi

if command -v awww >/dev/null 2>&1; then
    awww img "$path" 2>/dev/null
elif command -v swww >/dev/null 2>&1; then
    swww img "$path" 2>/dev/null
else
    pkill -x swaybg 2>/dev/null || true
    swaybg -i "$path" -m fill &
fi

echo "set-wallpaper: $path"