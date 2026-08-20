#!/usr/bin/env bash
# Launch hyprlock with the current Flawed-Shell wallpaper as background.
# Generates a per-run config so the lock screen always matches the desktop.

set -euo pipefail

SETTINGS="$HOME/.config/Flawed-Shell/settings.json"
TEMPLATE="$HOME/.config/hypr/hyprlock.conf"
OUT="/tmp/hyprlock-current.conf"

path="$(python3 -c "import json,sys; print(json.load(open(sys.argv[1])).get('wallpaperCurrent',''))" "$SETTINGS" 2>/dev/null || true)"
[ -n "$path" ] || path="$HOME/Pictures/Wallpapers/one-legged-herdazian.jpg"

# Escape for sed replacement (paths can contain / and special chars)
esc="$(printf '%s' "$path" | sed 's/[&/\\]/\\&/g')"
sed 's|^\([[:space:]]*\)path = .*|\1path = '"$esc"'|' "$TEMPLATE" > "$OUT"

exec hyprlock -c "$OUT" "$@"