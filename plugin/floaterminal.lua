---@class FloatState
---@field floating { buf: number, win: number }

---@type FloatState
-- local state = {
--     floating = {
--         buf = -1,
--         win = -1,
--     },
-- }

---@return vim.api.keyset.win_config
-- local function get_float_win_config()
--     local nvim_width = vim.o.columns
--     local nvim_height = vim.o.lines

--     local width = math.floor(nvim_width * 0.8)
--     local height = math.floor(nvim_height * 0.8)

--     local col = math.floor((nvim_width - width) / 2)
--     local row = math.floor((nvim_height - height) / 2)

--     return {
--         width = width,
--         height = height,
--         col = col,
--         row = row,
--         relative = "editor",
--         style = "minimal",
--         border = "rounded",
--     }
-- end

---@return FloatState
-- local function create_floating_window(opts)
--     opts = opts or {}

--     local buf = nil
--     if vim.api.nvim_buf_is_valid(opts.buf) then
--         buf = opts.buf
--     else
--         buf = vim.api.nvim_create_buf(false, true)
--     end

--     local win = vim.api.nvim_open_win(buf, true, get_float_win_config())

--     return { buf = buf, win = win }
-- end

-- vim.api.nvim_create_autocmd("VimResized", {
--     desc = "Resize floating terminal",
--     group = vim.api.nvim_create_augroup("nvim-term-custom", { clear = false }),
--     callback = function()
--         if vim.api.nvim_win_is_valid(state.floating.win) then
--             vim.api.nvim_win_set_config(
--                 state.floating.win,
--                 get_float_win_config()
--             )
--         end
--     end,
-- })

-- vim.api.nvim_create_user_command("Floaterm", function(args)
--     if not vim.api.nvim_win_is_valid(state.floating.win) then
--         state.floating = create_floating_window { buf = state.floating.buf }
--         if vim.bo[state.floating.buf].buftype ~= "terminal" then
--             vim.cmd.terminal()
--         end
--         vim.cmd "normal i"
--     else
--         vim.api.nvim_win_hide(state.floating.win)
--     end
-- end, {})

-- vim.keymap.set({ "n", "t" }, "<A-t>", function()
--     vim.cmd "Floaterm"
-- end, { desc = "Toggle floating terminal" })
