return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    event = "VeryLazy",
    cond = not vim.g.vscode,
    opts = {},
    init = function()
        local mc = require "multicursor-nvim"

        mc.addKeymapLayer(function(layerSet)
            layerSet(
                { "n", "x" },
                "<left>",
                mc.prevCursor,
                { desc = "[Multicursor] Previous cursor" }
            )
            layerSet(
                { "n", "x" },
                "<right>",
                mc.nextCursor,
                { desc = "[Multicursor] Next cursor" }
            )
            layerSet(
                { "n", "x" },
                "<leader>x",
                mc.deleteCursor,
                { desc = "[Multicursor] Delete cursor" }
            )
            layerSet({ "n" }, "<esc>", function()
                if mc.cursorsEnabled() then
                    mc.clearCursors()
                end
            end, { desc = "[Multicursor] Clear cursors" })
            layerSet(
                { "n" },
                "<M-a>",
                mc.alignCursors,
                { desc = "[Multicursor] Align cursors" }
            )
        end)
    end,
    keys = {
        {
            "<A-d>",
            function()
                require("multicursor-nvim").searchAddCursor(1)
            end,
            mode = { "n", "x" },
            desc = "[Multicursor] Add new cursor and go to next search result",
        },
        {
            "<A-S-d>",
            function()
                require("multicursor-nvim").searchSkipCursor(1)
            end,
            mode = { "n", "x" },
            desc = "[Multicursor] Skip adding new cursor and go to next search result",
        },
        {
            "<A-u>",
            function()
                require("multicursor-nvim").searchAddCursor(-1)
            end,
            mode = { "n", "x" },
            desc = "[Multicursor] Add new cursor and go to previous search result",
        },
        {
            "<A-S-u>",
            function()
                require("multicursor-nvim").searchSkipCursor(-1)
            end,
            mode = { "n", "x" },
            desc = "[Multicursor] Skip adding new cursor and go to previous search result",
        },
        {
            "<A-m>",
            function()
                require("multicursor-nvim").matchCursors()
            end,
            mode = "x",
            desc = "[Multicursor] Visual match cursors interactively",
        },
        {
            "S",
            function()
                require("multicursor-nvim").splitCursors()
            end,
            mode = "x",
            desc = "[Multicursor] Split visual selections interactively",
        },
        {
            "<A-a>",
            function()
                require("multicursor-nvim").searchAllAddCursors()
            end,
            desc = "[Multicursor] Add cursors to all search results",
        },
        {
            "<A-leftmouse>",
            function()
                require("multicursor-nvim").handleMouse()
            end,
            desc = "[Multicursor] Add/remove cursors with mouse",
        },
        {
            "<A-leftdrag>",
            function()
                require("multicursor-nvim").handleMouseDrag()
            end,
            desc = "[Multicursor] Add/remove cursors with vertical mouse drag",
        },
        {
            "<A-leftrelease>",
            function()
                require("multicursor-nvim").handleMouseRelease()
            end,
            desc = "[Multicursor] Use in a mouse mapping to improve mouse support when dragging with a modifier after having already clicked without it",
        },
        {
            "<A-q>",
            function()
                require("multicursor-nvim").toggleCursor()
            end,
            mode = { "n", "x" },
            desc = "[Multicursor] Toggle cursors",
        },
        {
            "<leader>gv",
            function()
                require("multicursor-nvim").restoreCursors()
            end,
            desc = "[Multicursor] Restore cursors",
        },
    },
}
