return {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    -- cond = not vim.g.vscode,
    cond = false,
    opts = {
        dependencies_bin = {
            ["tinymist"] = "tinymist",
            ["websocat"] = "websocat",
        },
    },
}
