return {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    cond = not vim.g.vscode,
    opts = {
        mode = "words", -- words, phrases
        wpm_goal = 60,
    },
    cmd = { "Typr", "TyprStats" },
}
