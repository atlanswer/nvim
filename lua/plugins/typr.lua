return {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {
        mode = "words", -- words, phrases
        wpm_goal = 60,
    },
    cmd = { "Typr", "TyprStats" },
    cond = not vim.g.vscode,
}
