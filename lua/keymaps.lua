-- Move selection
vim.keymap.set(
    "n",
    "<A-j>",
    "<cmd>execute 'move .+' . v:count1<cr>==",
    { desc = "Move line down" }
)
vim.keymap.set(
    "n",
    "<A-k>",
    "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==",
    { desc = "Move line up" }
)
-- vim.keymap.set(
--     "i",
--     "<A-j>",
--     "<esc><cmd>m .+1<cr>==gi",
--     { desc = "Move line down" }
-- )
-- vim.keymap.set(
--     "i",
--     "<A-k>",
--     "<esc><cmd>m .-2<cr>==gi",
--     { desc = "Move line up" }
-- )
vim.keymap.set(
    "v",
    "<A-j>",
    ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv",
    { desc = "Move selection down" }
)
vim.keymap.set(
    "v",
    "<A-k>",
    ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv",
    { desc = "Move selection up" }
)

-- Page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move to window
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move to the left window" })
vim.keymap.set(
    "n",
    "<C-l>",
    "<C-w><C-l>",
    { desc = "Move to the right window" }
)
vim.keymap.set(
    "n",
    "<C-j>",
    "<C-w><C-j>",
    { desc = "Move to the lower window" }
)
vim.keymap.set(
    "n",
    "<C-k>",
    "<C-w><C-k>",
    { desc = "Move to the upper window" }
)

-- Resize window
vim.keymap.set(
    "n",
    "<C-Up>",
    "<cmd>resize +2<cr>",
    { desc = "Increase window height" }
)
vim.keymap.set(
    "n",
    "<C-Down>",
    "<cmd>resize -2<cr>",
    { desc = "Decrease window height" }
)
vim.keymap.set(
    "n",
    "<C-Left>",
    "<cmd>vertical resize -2<cr>",
    { desc = "Decrease window width" }
)
vim.keymap.set(
    "n",
    "<C-Right>",
    "<cmd>vertical resize +2<cr>",
    { desc = "Increase window width" }
)

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Preserve copy
vim.keymap.set(
    "n",
    "<leader>p",
    '"+p',
    { desc = "Paste from system clipboard" }
)
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("x", "<leader>p", '"_d"+P')

-- System clipboard
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Delete into void
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete into void" })
vim.keymap.set("v", "<leader>d", '"_d')

-- Oil file explorer
if not vim.g.vscode then
    vim.keymap.set(
        "n",
        "-",
        require("oil").open,
        { desc = "(Oil) Open parent directory" }
    )
end

-- Search
vim.keymap.set(
    { "i", "n" },
    "<ESC>",
    "<cmd>nohlsearch<cr><esc>",
    { desc = "Clear hlsearch and escape" }
)

-- Diagnostic
vim.keymap.set(
    "n",
    "<leader>e",
    vim.diagnostic.open_float,
    { desc = "Show diagnostic [E]rror messages" }
)
vim.keymap.set(
    "n",
    "<leader>q",
    vim.diagnostic.setloclist,
    { desc = "Open diagnostic [Q]uickfix list" }
)

-- Exit
vim.keymap.set(
    "t",
    "<Esc><Esc>",
    "<C-\\><C-n>",
    { desc = "Exit terminal mode" }
)
