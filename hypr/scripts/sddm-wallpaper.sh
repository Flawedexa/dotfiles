#!/usr/bin/env bash
# Pick a random wallpaper from the shared wallpaper folder and apply it
# to the sddm-astronaut-theme login screen at every boot.
# Runs as root via the sddm-wallpaper.service oneshot (Before=sddm.service).

set -euo pipefail

THEME_DIR="/usr/share/sddm/themes/sddm-astronaut-theme"
CONF="$THEME_DIR/Themes/custom.conf"
BG_DIR="$THEME_DIR/Backgrounds"
SRC_DIR="/home/flawed/Pictures/Wallpapers"

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

echo "sddm-wallpaper: $selected -> $dest"