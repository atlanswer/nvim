return {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cond = not vim.g.vscode,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
        {
            "<leader>vd",
            function()
                if
                    vim.o.filetype == "DiffviewFiles"
                    or vim.o.filetype == "DiffviewFileHistory"
                then
                    vim.cmd "DiffviewClose"
                else
                    vim.cmd "DiffviewOpen"
                end
            end,
            desc = "Toggle Diffview",
        },
        {
            "<leader>vf",
            function()
                if vim.o.filetype == "DiffviewFileHistory" then
                    vim.cmd "DiffviewClose"
                else
                    vim.cmd "DiffviewFileHistory"
                end
            end,
            desc = "Toggle Diffview FileHistory"
        },
    },
}
