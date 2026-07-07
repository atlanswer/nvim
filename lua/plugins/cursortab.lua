return {
    "cursortab/cursortab.nvim",
    -- version = "*",  -- Use latest tagged version for more stability
    lazy = false, -- The server is already lazy loaded
    build = "cd server && go build",
    cond = not vim.g.vscode,
    ---@module "cursortab.config"
    ---@type CursortabConfig
    opts = {
        provider = {
            -- Mercury API (hosted)
            -- type = "mercuryapi",
            -- api_key_env = "MERCURY_AI_TOKEN",

            -- temperature = 0,
            -- context_size = 8192,
            -- max_tokens = 512,
            max_tokens = 2048,

            url = "http://localhost:8080",

            -- Zeta-2 (best local)
            -- model = "zeta-2",
            type = "zeta-2",

            -- Qwen3.5-0.8B (fastest local, defaults to "inline")
            -- url = "http://localhost:8080",

            -- sweep-next-edit-0.5B/1.5B (fastest local)
            -- model = "sweep-next-edit-v2-7B",
            -- type = "sweep",
        },
        contribute_data = true,
        keymaps = {
            trigger = "<C-/>",
        },
    },
}
