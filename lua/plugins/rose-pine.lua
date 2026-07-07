return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    cond = not vim.g.vscode,
    opts = {
        -- variant = "auto", -- auto, main, moon, or dawn
        -- dark_variant = "main", -- main, moon, or dawn
        -- dim_inactive_windows = true,
        -- enable = {
        --     terminal = true,
        --     legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        --     migrations = true, -- Handle deprecated options automatically
        -- },
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
