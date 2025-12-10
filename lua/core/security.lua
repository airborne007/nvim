--[[
安全保护机制模块
提供文件保护、插件验证、安全命令执行等功能
]]

local M = {}

-- 保护重要文件不被意外修改
M.protect_files = function()
    -- 获取Neovim配置目录
    local config_dir = vim.fn.stdpath("config")

    -- 定义需要保护的重要文件列表（使用相对路径）
    local protected_files = {
        config_dir .. "/init.lua",
        config_dir .. "/lua/core/config.lua",
        config_dir .. "/lua/core/security.lua",
        config_dir .. "/lua/core/extension.lua"
    }

    -- 为每个受保护文件添加自动命令
    local augroup = vim.api.nvim_create_augroup("FileProtection", { clear = true })

    for _, file_path in ipairs(protected_files) do
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            group = augroup,
            pattern = file_path,
            callback = function()
                -- 提示用户确认修改
                local choice = vim.fn.confirm("警告：您正在修改受保护的核心配置文件。确定要继续吗？", "&y\n&n", 2)
                if choice ~= 1 then
                    vim.api.nvim_command("cancel")
                    return
                end

                -- 创建备份
                local backup_path = file_path .. ".backup." .. os.date("%Y%m%d%H%M%S")
                local status_ok, err = pcall(vim.fn.writefile, vim.fn.readfile(file_path), backup_path)
                if not status_ok then
                    vim.notify("无法创建备份文件：" .. err, vim.log.levels.WARN)
                else
                    vim.notify("已创建配置备份：" .. backup_path, vim.log.levels.INFO)
                end
            end
        })
    end
end

-- 验证插件来源安全性
M.validate_plugins = function()
    -- 定义允许的插件来源
    local allowed_sources = {
        "https://github.com/",
        "https://gitlab.com/"
    }

    -- 检查plugins.lua中的插件来源
    local config_dir = vim.fn.stdpath("config")
    local plugins_file = config_dir .. "/lua/plugins.lua"
    if vim.fn.filereadable(plugins_file) == 1 then
        local content = vim.fn.readfile(plugins_file)
        for i, line in ipairs(content) do
            -- 查找插件URL
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
                    vim.notify("警告：插件来源可能不安全：" .. url .. " (行 " .. i .. ")", vim.log.levels.WARN)
                end
            end
        end
    end
end

-- 安全执行命令
M.safe_execute = function(cmd, opts)
    opts = opts or {}
    local silent = opts.silent or false
    local log_error = opts.log_error or true

    -- 如果需要静默执行，在命令前加上silent
    local cmd_to_execute = silent and "silent " .. cmd or cmd
    local status_ok, result = pcall(vim.api.nvim_command, cmd_to_execute)
    if not status_ok and log_error then
        vim.notify("命令执行失败：" .. cmd .. "\n错误：" .. result, vim.log.levels.ERROR)
    end
    return status_ok
end

-- 限制危险命令的执行
M.restrict_dangerous_commands = function()
    -- 定义危险命令列表
    local dangerous_commands = {
        "!rm -rf",
        "!sudo",
        "!chmod",
        "!chown",
        ":%!rm",
        ":%!dd",
        ":%!mv"
    }

    -- 创建自动命令来拦截危险命令
    local augroup = vim.api.nvim_create_augroup("DangerousCommandProtection", { clear = true })

    vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
        group = augroup,
        pattern = ":",
        callback = function()
            local cmd = vim.fn.getcmdline()
            for _, dangerous_cmd in ipairs(dangerous_commands) do
                if string.find(cmd, dangerous_cmd) then
                    vim.notify("警告：您正在尝试执行危险命令：" .. cmd, vim.log.levels.WARN)
                    -- 提供确认选项
                    vim.schedule(function()
                        local choice = vim.fn.confirm("确定要执行这个危险命令吗？", "&y\n&n", 2)
                        if choice ~= 1 then
                            vim.api.nvim_feedkeys("\x1b", "n", false) -- 发送ESC取消命令
                        end
                    end)
                    break
                end
            end
        end
    })
end

-- 设置安全的权限和属性
M.set_secure_permissions = function()
    -- 获取Neovim配置目录
    local config_dir = vim.fn.stdpath("config")

    -- 确保配置文件具有适当的权限
    local config_dirs = {
        config_dir,
        config_dir .. "/lua",
        config_dir .. "/lua/core"
    }

    for _, dir in ipairs(config_dirs) do
        if vim.fn.isdirectory(dir) == 1 then
            -- 确保目录存在并设置权限
            M.safe_execute("!chmod -R 700 " .. dir, { silent = true })
        end
    end
end

-- 初始化所有安全保护机制
M.setup = function()
    M.protect_files()
    M.validate_plugins()
    M.restrict_dangerous_commands()
    M.set_secure_permissions()

    -- 注释掉通知以减少启动提示
    -- vim.notify("安全保护机制已启用", vim.log.levels.INFO)
end

return M
