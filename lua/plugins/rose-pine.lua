return {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
        dark_variant = "moon",
        dim_inactive_windows = true,
        styles = {
            bold = true,
            italic = false,
            transparency = true,
        },
        highlight_groups = {
            EndOfBuffer = { fg = "base" },
            -- BlinkCmpLabelMatch = {
            --     bold = true,
            --     cterm = {
            --         bold = true,
            --     },
            --     inherit = false,
            -- },
        },
    },
}
