-- Detech Python venv and inform LSP

local client = vim.lsp.get_clients({ name = "basedpyright" })[1]

local function find_venv_python()
    local current_dir = vim.uv.cwd()
    if not current_dir then
        return nil
    end

    local is_windows = vim.uv.os_uname().sysname == "Windows_NT"
    local python_exe = is_windows and "Scripts\\python.exe" or "bin/python"
    local path_sep = package.config:sub(1, 1) -- Get OS-specific path separator

    -- Loop until root directory
    while true do
        -- Construct paths
        local venv_dir = current_dir .. path_sep .. ".venv"
        local python_path = venv_dir
            .. path_sep
            .. python_exe:gsub("/", path_sep)

        -- Check if Python executable exists
        local stat = vim.uv.fs_stat(python_path)
        if stat and stat.type == "file" then
            return python_path
        end

        -- Move to parent directory
        local parent_dir = vim.fn.fnamemodify(current_dir, ":h")

        -- Exit if we've reached the filesystem root
        if parent_dir == current_dir then
            break
        end
        current_dir = parent_dir
    end

    return nil -- No valid venv found
end

local python_path = find_venv_python()

if python_path and client then
    if client.settings then
        client.settings = vim.tbl_deep_extend("force", client.settings, {
            python = { pythonPath = python_path },
        })

        client.notify("workspace/didChangeConfiguration", { settings = nil })
    end
end
