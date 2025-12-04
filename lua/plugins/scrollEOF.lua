return {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    cond = not vim.g.vscode,
    opts = {},
}
