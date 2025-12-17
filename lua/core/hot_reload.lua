--[[
Configuration hot-reload feature
Listens for changes in configuration files and automatically reloads them without restarting Neovim
--]]

local api = vim.api
local M = {}

-- Stores the file types to watch
local watched_files = {
  '*.lua',
  '*.vim',
  '*.json',
  '*.yaml',
  '*.yml',
}

-- Stores the modules to reload
local modules_to_reload = {
  'basic',
  'keybindings',
  'auto-command',
  'core.extension',
}

-- Flag to prevent recursive reloading
local is_reloading = false

-- Clears the module cache
local function clear_module_cache(module_name)
  if package.loaded[module_name] then
    package.loaded[module_name] = nil
    return true
  end
  return false
end

-- Reloads a single module
local function reload_module(module_name)
  if is_reloading then
    return
  end
  
  is_reloading = true
  
  local success, err = pcall(function()
    -- Clear module cache
    clear_module_cache(module_name)
    
    -- Reload the module
    require(module_name)
    
    vim.notify(string.format("Module reloaded: %s", module_name), vim.log.levels.INFO)
  end)
  
  if not success then
    vim.notify(string.format("Failed to reload module: %s\n%s", module_name, err), vim.log.levels.ERROR)
  end
  
  is_reloading = false
end

-- Reloads all configuration modules
local function reload_all_modules()
  if is_reloading then
    return
  end
  
  is_reloading = true
  
  vim.notify("Starting to reload all configurations...", vim.log.levels.INFO)
  
  -- Reload basic configuration
  for _, module_name in ipairs(modules_to_reload) do
    pcall(clear_module_cache, module_name)
  end
  
  -- Reload all modules
  local success, err = pcall(function()
    -- Reload basic configuration
    require('basic')
    
    -- Reload core extension module
    require('core.extension')
    
    -- Reload auto-commands
    require('auto-command')
    
    -- Reload keybindings
    require('keybindings')
    
    -- Reload LSP configuration
    if package.loaded['lsp'] then
      require('lsp')
    end
    
    -- Reload plugin configuration
    if package.loaded['plugins'] then
      require('plugins')
    end
    
    -- Reload user extensions
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
    vim.notify("All configurations reloaded successfully!", vim.log.levels.INFO)
  else
    vim.notify(string.format("Failed to reload configurations: %s", err), vim.log.levels.ERROR)
  end
  
  is_reloading = false
end

-- Watches for configuration file changes
local function setup_watchers()
  local group = api.nvim_create_augroup('ConfigHotReload', { clear = true })
  
  -- Watch the configuration directory
  local config_dir = vim.fn.stdpath('config')
  local lua_dir = config_dir .. '/lua'
  
  -- Add a watcher for configuration file modifications
  api.nvim_create_autocmd('BufWritePost', {
    group = group,
    pattern = vim.tbl_map(function(pattern) return lua_dir .. '/**/' .. pattern end, watched_files),
    callback = function(event)
      local file_path = event.file
      
      vim.notify(string.format("Configuration file modified: %s", file_path), vim.log.levels.INFO)
      
      -- A more robust way to parse the module name
      -- Match the part after the lua/ directory
      local module_match = file_path:match('.*/lua/(.*)%.lua$')
      local module_name
      
      if module_match then
        module_name = module_match:gsub('/', '.')
      else
        -- Try another pattern match
        local lua_dir_pattern = vim.fn.escape(lua_dir, '/'):gsub('([%.%*%+%-%?%[%]%^%$%(%)%{%}%|])', '\\%1')
        module_name = file_path:gsub(lua_dir_pattern .. '/', ''):gsub('%.lua$', ''):gsub('/', '.')
      end
      
      -- Check if the module name is valid
      if module_name and module_name ~= '' then
        -- Reload the modified module
        reload_module(module_name)
        
        -- If a core module is modified, reload all related modules
        if module_name:match('^core%.') or module_name:match('^basic$') or module_name:match('^plugins$') then
          vim.notify("Core configuration modified, reloading all configurations...", vim.log.levels.INFO)
          reload_all_modules()
        end
      else
        vim.notify(string.format("Failed to parse module name: %s", file_path), vim.log.levels.ERROR)
      end
    end,
    desc = 'Watches for configuration file changes and automatically reloads them'
  })
  
  -- Add a watcher for init.lua
  api.nvim_create_autocmd('BufWritePost', {
    group = group,
    pattern = config_dir .. '/init.lua',
    callback = function()
      vim.notify("init.lua modified, reloading all configurations...", vim.log.levels.INFO)
      reload_all_modules()
    end,
    desc = 'Watches for init.lua changes and automatically reloads all configurations'
  })
  
  -- Comment out the notification to reduce startup noise
  -- vim.notify("Configuration hot-reload feature enabled", vim.log.levels.INFO)
end

-- Manually triggers reloading of all configurations
function M.reload_all()
  reload_all_modules()
end

-- Manually triggers reloading of a specific module
function M.reload_module(module_name)
  reload_module(module_name)
end

-- Initializes the hot-reload feature
function M.setup(opts)
  opts = opts or {}
  
  -- Merge configurations
  watched_files = vim.tbl_extend('force', watched_files, opts.watched_files or {})
  modules_to_reload = vim.tbl_extend('force', modules_to_reload, opts.modules_to_reload or {})
  
  -- Set up manual reload commands
  api.nvim_create_user_command('ReloadConfig', M.reload_all, {
    desc = 'Manually reload all configurations'
  })
  
  api.nvim_create_user_command('ReloadModule', function(args)
    if args.args then
      M.reload_module(args.args)
    else
      vim.notify("Please specify the module name to reload", vim.log.levels.ERROR)
    end
  end, {
    desc = 'Manually reload a specific module',
    nargs = 1,
    complete = function()
      return modules_to_reload
    end
  })
  
  -- Start watching
  setup_watchers()
end

return M
