return {
    "atlanswer/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    config = function()
        require("typst-preview.fetch").tinymist_bin_name = "tinymist"
        require("typst-preview.fetch").websocat_bin_name = "websocat"

        require("typst-preview").setup {
            partial_rendering = false,
            dependencies_bin = {
                ["tinymist"] = "tinymist",
                ["websocat"] = "websocat",
            },
        }
    end,
}
