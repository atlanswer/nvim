return {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    config = function()
        require("typst-preview").setup {
            partial_rendering = false,
            dependencies_bin = {
                ["tinymist"] = "tinymist",
                ["websocat"] = "websocat",
            },
        }
    end,
}
