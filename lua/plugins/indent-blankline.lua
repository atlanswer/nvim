return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VimEnter",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    cond = not vim.g.vscode,
}
