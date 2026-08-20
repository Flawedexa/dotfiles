#!/usr/bin/env bash
# Pick a random wallpaper from the shared wallpaper folder and apply it
# to the sddm-astronaut-theme login screen at every boot.
# Runs as root via the sddm-wallpaper.service oneshot (Before=sddm.service).

set -euo pipefail

THEME_DIR="/usr/share/sddm/themes/sddm-astronaut-theme"
CONF="$THEME_DIR/Themes/custom.conf"
BG_DIR="$THEME_DIR/Backgrounds"
SRC_DIR="/home/flawed/Pictures/Wallpapers"
MATUGEN_CONF="/home/flawed/dotfiles/hypr/scripts/sddm-matugen.conf"

mapfile -t candidates < <(find "$SRC_DIR" -maxdepth 1 -type f \
    \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \
       -o -iname '*.webp' -o -iname '*.gif' \) -printf '%p\n')

if [ "${#candidates[@]}" -eq 0 ]; then
    echo "sddm-wallpaper: no wallpapers found in $SRC_DIR" >&2
    exit 0
fi

selected="${candidates[RANDOM % ${#candidates[@]}]}"
ext="${selected##*.}"
ext="${ext,,}"
dest="$BG_DIR/current.$ext"

rm -f "$BG_DIR"/current.*
cp -f "$selected" "$dest"
chmod 644 "$dest"

sed -i 's|^Background=.*|Background="Backgrounds/current.'"$ext"'"|' "$CONF"

if command -v matugen >/dev/null 2>&1; then
    mjson="$(mktemp /tmp/sddm-matu.XXXXXX.json)"
    matugen -c "$MATUGEN_CONF" image "$selected" \
        --json hex --prefer darkness >"$mjson" 2>/dev/null || true
    python3 - "$CONF" "$mjson" <<'PY'
import json, re, sys

conf_path, json_path = sys.argv[1], sys.argv[2]
with open(json_path) as f:
    data = json.load(f)
c = data["colors"]
def hexv(key):
    try:
        return c[key]["default"]["color"]
    except KeyError:
        return None

colors = {
    "HeaderTextColor":             hexv("on_surface"),
    "DateTextColor":               hexv("on_surface_variant"),
    "TimeTextColor":               hexv("on_surface"),
    "FormBackgroundColor":         hexv("surface_container"),
    "BackgroundColor":             hexv("background"),
    "DimBackgroundColor":          hexv("background"),
    "LoginFieldBackgroundColor":   hexv("surface_container_high"),
    "PasswordFieldBackgroundColor":hexv("surface_container_high"),
    "LoginFieldTextColor":         hexv("on_surface"),
    "PasswordFieldTextColor":      hexv("on_surface"),
    "UserIconColor":               hexv("on_surface"),
    "PasswordIconColor":           hexv("on_surface"),
    "PlaceholderTextColor":        hexv("on_surface_variant"),
    "WarningColor":                hexv("error"),
    "LoginButtonTextColor":        hexv("on_primary"),
    "LoginButtonBackgroundColor":  hexv("primary"),
    "SystemButtonsIconsColor":     hexv("on_surface"),
    "SessionButtonTextColor":      hexv("on_surface"),
    "VirtualKeyboardButtonTextColor": hexv("on_surface"),
    "DropdownTextColor":           hexv("on_surface"),
    "DropdownSelectedBackgroundColor": hexv("secondary_container"),
    "DropdownBackgroundColor":     hexv("surface_container"),
    "HighlightTextColor":          hexv("on_surface_variant"),
    "HighlightBackgroundColor":    hexv("secondary_container"),
    "HighlightBorderColor":        hexv("outline"),
    "HoverUserIconColor":          hexv("primary"),
    "HoverPasswordIconColor":      hexv("primary"),
    "HoverSystemButtonsIconsColor":hexv("primary"),
    "HoverSessionButtonTextColor": hexv("primary"),
    "HoverVirtualKeyboardButtonTextColor": hexv("primary"),
}

with open(conf_path) as f:
    lines = f.readlines()
for i, line in enumerate(lines):
    m = re.match(r'^(\w+)=(.*)$', line.rstrip("\n"))
    if not m:
        continue
    key, val = m.group(1), m.group(2)
    if key in colors and colors[key]:
        lines[i] = f'{key}="{colors[key]}"\n'
with open(conf_path, "w") as f:
    f.writelines(lines)
PY
    rm -f "$mjson"
    echo "sddm-wallpaper: colors applied from matugen"
fi

echo "sddm-wallpaper: $selected -> $dest"