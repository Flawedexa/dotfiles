#!/usr/bin/env fish

set -l win (hyprctl clients -j | jq '.[] | select(.class == "Spotify" or .initialClass == "Spotify")')

if test -z "$win"
    spotify-launcher &
else
    hyprctl dispatch togglespecialworkspace music
end
