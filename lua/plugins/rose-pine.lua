return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
        dark_variant = "moon",
        dim_inactive_windows = true,
        enable = {
            terminal = true,
            legacy_highlights = false,
            migrations = true,
        },
        styles = {
            bold = true,
            italic = false,
            transparency = true,
        },
        highlight_groups = {
            EndOfBuffer = { fg = "base" },
            Folded = { fg = "muted" },
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
