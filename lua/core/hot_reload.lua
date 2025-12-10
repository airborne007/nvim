--[[
配置热重载功能
用于监听配置文件的变化并自动重新加载，无需重启Neovim
--]]

local api = vim.api
local M = {}

-- 存储需要监听的文件类型
local watched_files = {
  '*.lua',
  '*.vim',
  '*.json',
  '*.yaml',
  '*.yml',
}

-- 存储需要重载的模块
local modules_to_reload = {
  'basic',
  'keybindings',
  'auto-command',
  'core.extension',
}

-- 标记是否正在重载中，避免递归重载
local is_reloading = false

-- 清除模块的缓存
local function clear_module_cache(module_name)
  if package.loaded[module_name] then
    package.loaded[module_name] = nil
    return true
  end
  return false
end

-- 重载单个模块
local function reload_module(module_name)
  if is_reloading then
    return
  end
  
  is_reloading = true
  
  local success, err = pcall(function()
    -- 清除模块缓存
    clear_module_cache(module_name)
    
    -- 重新加载模块
    require(module_name)
    
    vim.notify(string.format("模块已重新加载: %s", module_name), vim.log.levels.INFO)
  end)
  
  if not success then
    vim.notify(string.format("模块重载失败: %s\n%s", module_name, err), vim.log.levels.ERROR)
  end
  
  is_reloading = false
end

-- 重载所有配置模块
local function reload_all_modules()
  if is_reloading then
    return
  end
  
  is_reloading = true
  
  vim.notify("开始重新加载所有配置...", vim.log.levels.INFO)
  
  -- 重新加载基本配置
  for _, module_name in ipairs(modules_to_reload) do
    pcall(clear_module_cache, module_name)
  end
  
  -- 重新加载所有模块
  local success, err = pcall(function()
    -- 重新加载基本配置
    require('basic')
    
    -- 重新加载核心扩展模块
    require('core.extension')
    
    -- 重新加载自动命令
    require('auto-command')
    
    -- 重新加载快捷键映射
    require('keybindings')
    
    -- 重新加载LSP配置
    if package.loaded['lsp'] then
      require('lsp')
    end
    
    -- 重新加载插件配置
    if package.loaded['plugins'] then
      require('plugins')
    end
    
    -- 重新加载用户扩展
    local extensions_dir = vim.fn.stdpath('config') .. '/lua/extensions'
    if vim.loop.fs_stat(extensions_dir) then
      for _, file in ipairs(vim.fn.readdir(extensions_dir)) do
        if file:match('%.lua$') then
          local extension_name = file:gsub('%.lua$', '')
          pcall(require, 'extensions.' .. extension_name)
        end
      end
    end
  end)
  
  if success then
    vim.notify("所有配置已重新加载完成!", vim.log.levels.INFO)
  else
    vim.notify(string.format("配置重载失败: %s", err), vim.log.levels.ERROR)
  end
  
  is_reloading = false
end

-- 监听配置文件变化
local function setup_watchers()
  local group = api.nvim_create_augroup('ConfigHotReload', { clear = true })
  
  -- 监听配置文件目录
  local config_dir = vim.fn.stdpath('config')
  local lua_dir = config_dir .. '/lua'
  
  -- 为配置文件添加修改监听
  api.nvim_create_autocmd('BufWritePost', {
    group = group,
    pattern = vim.tbl_map(function(pattern) return lua_dir .. '/**/' .. pattern end, watched_files),
    callback = function(event)
      local file_path = event.file
      
      vim.notify(string.format("配置文件已修改: %s", file_path), vim.log.levels.INFO)
      
      -- 解析模块名的更健壮方式
      -- 匹配 lua/ 目录后的部分
      local module_match = file_path:match('.*/lua/(.*)%.lua$')
      local module_name
      
      if module_match then
        module_name = module_match:gsub('/', '.')
      else
        -- 尝试另一种模式匹配
        local lua_dir_pattern = vim.fn.escape(lua_dir, '/'):gsub('([%.%*%+%-%?%[%]%^%$%(%)%{%}%|])', '\\%1')
        module_name = file_path:gsub(lua_dir_pattern .. '/', ''):gsub('%.lua$', ''):gsub('/', '.')
      end
      
      -- 检查模块名是否有效
      if module_name and module_name ~= '' then
        -- 重载修改的模块
        reload_module(module_name)
        
        -- 如果修改的是核心模块，重载所有相关模块
        if module_name:match('^core%.') or module_name:match('^basic$') or module_name:match('^plugins$') then
          vim.notify("检测到核心配置修改，重新加载所有配置...", vim.log.levels.INFO)
          reload_all_modules()
        end
      else
        vim.notify(string.format("无法解析模块名: %s", file_path), vim.log.levels.ERROR)
      end
    end,
    desc = '监听配置文件变化并自动重新加载'
  })
  
  -- 为init.lua添加监听
  api.nvim_create_autocmd('BufWritePost', {
    group = group,
    pattern = config_dir .. '/init.lua',
    callback = function()
      vim.notify("init.lua已修改，重新加载所有配置...", vim.log.levels.INFO)
      reload_all_modules()
    end,
    desc = '监听init.lua变化并自动重新加载'
  })
  
  -- 注释掉通知以减少启动提示
  -- vim.notify("配置热重载功能已启用", vim.log.levels.INFO)
end

-- 手动触发重载所有配置
function M.reload_all()
  reload_all_modules()
end

-- 手动触发重载特定模块
function M.reload_module(module_name)
  reload_module(module_name)
end

-- 初始化热重载功能
function M.setup(opts)
  opts = opts or {}
  
  -- 合并配置
  watched_files = vim.tbl_extend('force', watched_files, opts.watched_files or {})
  modules_to_reload = vim.tbl_extend('force', modules_to_reload, opts.modules_to_reload or {})
  
  -- 设置手动重载命令
  api.nvim_create_user_command('ReloadConfig', M.reload_all, {
    desc = '手动重新加载所有配置'
  })
  
  api.nvim_create_user_command('ReloadModule', function(args)
    if args.args then
      M.reload_module(args.args)
    else
      vim.notify("请指定要重载的模块名称", vim.log.levels.ERROR)
    end
  end, {
    desc = '手动重新加载特定模块',
    nargs = 1,
    complete = function()
      return modules_to_reload
    end
  })
  
  -- 启动监听
  setup_watchers()
end

return M