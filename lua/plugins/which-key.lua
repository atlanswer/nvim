return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeoutlen = 500
    end,
    cond = not vim.g.vscode,
}
