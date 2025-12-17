--[[
Security protection mechanism module
Provides file protection, plugin validation, safe command execution, etc.
]]

local M = {}

-- Protect important files from accidental modification
M.protect_files = function()
    -- Get the Neovim configuration directory
    local config_dir = vim.fn.stdpath("config")

    -- Define a list of important files to protect (using relative paths)
    local protected_files = {
        config_dir .. "/init.lua",
        config_dir .. "/lua/core/config.lua",
        config_dir .. "/lua/core/security.lua",
        config_dir .. "/lua/core/extension.lua"
    }

    -- Add an autocommand for each protected file
    local augroup = vim.api.nvim_create_augroup("FileProtection", { clear = true })

    for _, file_path in ipairs(protected_files) do
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            group = augroup,
            pattern = file_path,
            callback = function()
                -- Prompt the user to confirm the modification
                local choice = vim.fn.confirm("Warning: You are modifying a protected core configuration file. Are you sure you want to continue?", "&y\n&n", 2)
                if choice ~= 1 then
                    vim.api.nvim_command("cancel")
                    return
                end

                -- Create a backup
                local backup_path = file_path .. ".backup." .. os.date("%Y%m%d%H%M%S")
                local status_ok, err = pcall(vim.fn.writefile, vim.fn.readfile(file_path), backup_path)
                if not status_ok then
                    vim.notify("Could not create backup file: " .. err, vim.log.levels.WARN)
                else
                    vim.notify("Configuration backup created: " .. backup_path, vim.log.levels.INFO)
                end
            end
        })
    end
end

-- Validate the security of plugin sources
M.validate_plugins = function()
    -- Define allowed plugin sources
    local allowed_sources = {
        "https://github.com/",
        "https://gitlab.com/"
    }

    -- Check plugin sources in plugins.lua
    local config_dir = vim.fn.stdpath("config")
    local plugins_file = config_dir .. "/lua/plugins.lua"
    if vim.fn.filereadable(plugins_file) == 1 then
        local content = vim.fn.readfile(plugins_file)
        for i, line in ipairs(content) do
            -- Find plugin URL
            local url = string.match(line, 'url%s*=%s*["\'"]([^"]*)["\'"]')
            if url then
                local is_allowed = false
                for _, source in ipairs(allowed_sources) do
                    if string.sub(url, 1, #source) == source then
                        is_allowed = true
                        break
                    end
                end
                if not is_allowed then
                    vim.notify("Warning: Plugin source may be insecure: " .. url .. " (line " .. i .. ")", vim.log.levels.WARN)
                end
            end
        end
    end
end

-- Safely execute a command
M.safe_execute = function(cmd, opts)
    opts = opts or {}
    local silent = opts.silent or false
    local log_error = opts.log_error or true

    -- Add silent to the command if needed
    local cmd_to_execute = silent and "silent " .. cmd or cmd
    local status_ok, result = pcall(vim.api.nvim_command, cmd_to_execute)
    if not status_ok and log_error then
        vim.notify("Command execution failed: " .. cmd .. "\nError: " .. result, vim.log.levels.ERROR)
    end
    return status_ok
end

-- Restrict the execution of dangerous commands
M.restrict_dangerous_commands = function()
    -- Define a list of dangerous commands
    local dangerous_commands = {
        "!rm -rf",
        "!sudo",
        "!chmod",
        "!chown",
        ":%!rm",
        ":%!dd",
        ":%!mv"
    }

    -- Create an autocommand to intercept dangerous commands
    local augroup = vim.api.nvim_create_augroup("DangerousCommandProtection", { clear = true })

    vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
        group = augroup,
        pattern = ":",
        callback = function()
            local cmd = vim.fn.getcmdline()
            for _, dangerous_cmd in ipairs(dangerous_commands) do
                if string.find(cmd, dangerous_cmd) then
                    vim.notify("Warning: You are trying to execute a dangerous command: " .. cmd, vim.log.levels.WARN)
                    -- Provide a confirmation option
                    vim.schedule(function()
                        local choice = vim.fn.confirm("Are you sure you want to execute this dangerous command?", "&y\n&n", 2)
                        if choice ~= 1 then
                            vim.api.nvim_feedkeys("\x1b", "n", false) -- Send ESC to cancel the command
                        end
                    end)
                    break
                end
            end
        end
    })
end

-- Set secure permissions and attributes
M.set_secure_permissions = function()
    -- Get the Neovim configuration directory
    local config_dir = vim.fn.stdpath("config")

    -- Ensure that configuration files have appropriate permissions
    local config_dirs = {
        config_dir,
        config_dir .. "/lua",
        config_dir .. "/lua/core"
    }

    for _, dir in ipairs(config_dirs) do
        if vim.fn.isdirectory(dir) == 1 then
            -- Ensure that the directory exists and set permissions
            M.safe_execute("!chmod -R 700 " .. dir, { silent = true })
        end
    end
end

-- Initialize all security protection mechanisms
M.setup = function()
    M.protect_files()
    M.validate_plugins()
    M.restrict_dangerous_commands()
    M.set_secure_permissions()

    -- Comment out the notification to reduce startup noise
    -- vim.notify("Security protection mechanisms enabled", vim.log.levels.INFO)
end

return M