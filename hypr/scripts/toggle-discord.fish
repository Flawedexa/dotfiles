#!/usr/bin/env fish

set -l win (hyprctl clients -j | jq '.[] | select(.class == "discord")')

if test -z "$win"
    discord &
else
    hyprctl dispatch "hl.dsp.workspace.toggle_special('communication')"
end
