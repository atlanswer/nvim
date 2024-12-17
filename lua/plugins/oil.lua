return {
    "stevearc/oil.nvim",
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {
        columns = {
            { "mtime", format = "%y/%m/%d %H:%M" }, "size", "icon",
        },
        view_options = {
            show_hidden = true,
        },
        keymaps = {
            ["<C-x>"] = { "actions.select", opts = { horizontal = true }, },
            ["<C-v>"] = { "actions.select", opts = { vertical = true }, },
        },
        float = {
            padding = 12,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cond = not vim.g.vscode,
}
