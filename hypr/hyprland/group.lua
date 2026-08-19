-- Hand-converted from group.conf

hl.config({
    group = {
        col = {
            border_active = activeWindowBorderColour,
            border_inactive = inactiveWindowBorderColour,
            border_locked_active = activeWindowBorderColour,
            border_locked_inactive = inactiveWindowBorderColour,
        },

        groupbar = {
            font_family = "JetBrains Mono NF",
            font_size = 15,
            gradients = true,
            gradient_round_only_edges = false,
            gradient_rounding = 5,
            height = 25,
            indicator_height = 0,
            gaps_in = 3,
            gaps_out = 3,

            text_color = "rgb(" .. scheme.onPrimary .. ")",
            col = {
                active = "rgb(" .. scheme.primary .. ")",
                inactive = "rgb(" .. scheme.outline .. ")",
                locked_active = "rgb(" .. scheme.primary .. ")",
                locked_inactive = "rgb(" .. scheme.secondary .. ")",
            },
        },
    },
})
