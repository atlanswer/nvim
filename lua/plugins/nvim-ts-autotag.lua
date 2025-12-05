return {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    cond = not vim.g.vscode,
    opts = {
        enable_rename = false,
    },
}
