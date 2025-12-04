return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VimEnter",
    cond = not vim.g.vscode,
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
}
