return {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.nvim", opts = {} } },
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {
        columns = {
            { "mtime", format = "%y/%m/%d %H:%M" },
            "size",
            "icon",
        },
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ["<C-x>"] = { "actions.select", opts = { horizontal = true } },
            ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        },
        float = {
            padding = 12,
        },
    },
    cond = not vim.g.vscode,
}
