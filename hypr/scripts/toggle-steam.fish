#!/usr/bin/env fish

set -l win (hyprctl clients -j | jq '.[] | select(.class == "steam")')

if test -z "$win"
    steam &
else
    hyprctl dispatch togglespecialworkspace special
end
