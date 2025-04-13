return {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
        dim_inactive_windows = true,
        styles = {
            bold = true,
            italic = false,
            transparency = false,
        },
        highlight_groups = {
            EndOfBuffer = { fg = "base" },
            BlinkCmpMenuSelection = { bg = "overlay", inherit = false },
            BlinkCmpLabelMatch = {
                bold = true,
                cterm = {
                    bold = true,
                },
                inherit = false,
            },
        },
    },
}
