return {
    "cursortab/cursortab.nvim",
    -- version = "*",  -- Use latest tagged version for more stability
    lazy = false, -- The server is already lazy loaded
    build = "cd server && go build",
    cond = function()
        if vim.g.vscode then
            return false
        end

        if vim.fn.executable "curl" == 0 then
            vim.notify("[cursortab] curl not found", vim.log.levels.INFO)
            return false
        end

        local suc, exitcode, code =
            os.execute "curl -fsS --out-null localhost:9931/health"
        if suc and exitcode == "exit" and code == 0 then
            return true
        else
            vim.notify(
                "[cursortab] curl localhost:9931/health failed",
                vim.log.levels.INFO
            )
            return false
        end
    end,
    ---@module "cursortab.config"
    ---@type CursortabConfig
    opts = {
        provider = {
            -- Mercury API (hosted)
            -- type = "mercuryapi",
            -- api_key_env = "MERCURY_AI_TOKEN",

            -- temperature = 0,
            -- context_size = 0,
            max_tokens = 16384,

            url = "http://localhost:9931",

            -- Zeta-2.1 (best local)
            model = "zeta-2.1",
            type = "zeta-2.1",
        },
        contribute_data = true,
        keymaps = {
            accept = false,
            -- trigger = "<C-/>",
        },
        blink = {
            enabled = true,
            ghost_text = false,
        },
    },
}
