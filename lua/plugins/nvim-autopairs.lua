return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    cond = not vim.g.vscode,
    opts = {
        check_ts = true,
        disable_filetype = {
            "TelescopePrompt",
            "spectre_panel",
            "snacks_picker_input",
            "typr",
        },
    },
}
