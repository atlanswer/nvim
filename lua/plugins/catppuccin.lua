return {
    "catppuccin/nvim",
    name = "catppuccin",
    cond = not vim.g.vscode,
    opts = {
        term_colors = true,
        transparent_background = false,
        dim_inactive = {
            enabled = true, -- dims the background color of inactive window
            shade = "light",
            percentage = 0.5, -- percentage of the shade to apply to the inactive window
        },
        styles = {
            functions = { "bold" },
        },
        integrations = {
            blink_cmp = true,
            diffview = true,
            fidget = true,
            harpoon = true,
            mason = true,
            notify = true,
            nvim_surround = true,
            which_key = true,
        },
        custom_highlights = function(colors)
            return {
                BlinkCmpLabelMatch = {
                    fg = "None",
                    standout = true,
                },
                Pmenu = {
                    fg = colors.blue,
                    bg = "None",
                },
                NormalFloat = {
                    fg = colors.blue,
                    bg = "None",
                },
            }
        end,
    },
}
