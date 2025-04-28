return {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    init = function()
        vim.keymap.set("n", "<leader>vd", function()
            if vim.o.filetype ~= "DiffviewFiles" then
                vim.cmd "DiffviewOpen"
            else
                vim.cmd "DiffviewClose"
            end
        end, { desc = "[V]iew [D]iffview" })
    end,
    cond = not vim.g.vscode,
}
