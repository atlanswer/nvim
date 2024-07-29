return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "j-hui/fidget.nvim", },
        { "folke/neodev.nvim", },
    },
    cond = not vim.g.vscode,
}
