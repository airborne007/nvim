-- Custom Theme Manager Extension
-- Replaces 'themery.nvim' with a lightweight implementation

local M = {}
local theme_cache_file = vim.fn.stdpath('data') .. '/current_theme.txt'

-- Configuration for each theme
-- Defines special setup logic (like background settings) for specific themes
local themes = {
  ["onedark"] = function()
    vim.g.onedark_style = 'darker'
    vim.cmd.colorscheme("onedark")
  end,
  ["gruvbox"] = function()
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
  ["everforest"] = function()
    vim.g.everforest_background = 'soft'
    vim.g.everforest_better_performace = 1
    vim.cmd.colorscheme("everforest")
  end,
  ["tokyonight"] = function()
    vim.cmd.colorscheme("tokyonight")
  end,
}

-- Save theme name to cache file
local function save_theme(name)
  local file = io.open(theme_cache_file, "w")
  if file then
    file:write(name)
    file:close()
  end
end

-- Load theme from cache file
local function load_theme()
  local file = io.open(theme_cache_file, "r")
  local name = nil
  if file then
    name = file:read("*a")
    -- Trim whitespace/newlines just in case
    if name then name = name:gsub("%s+", "") end
    file:close()
  end
  
  if name and themes[name] then
    -- Apply the saved theme
    local ok, err = pcall(themes[name])
    if not ok then
      vim.notify("Failed to load saved theme: " .. name .. "\n" .. err, vim.log.levels.WARN)
    end
    return
  end
  
  -- Fallback default
  pcall(themes["tokyonight"])
end

-- Picker UI
function M.pick_theme()
  local theme_names = vim.tbl_keys(themes)
  table.sort(theme_names)
  
  -- Use vim.ui.select (which Snacks.picker overrides if installed)
  vim.ui.select(theme_names, {
    prompt = "Select Theme (Custom Extension)",
    format_item = function(item) 
      return item:gsub("^%l", string.upper) -- Capitalize first letter for display
    end,
  }, function(selected)
    if selected then
      themes[selected]()
      save_theme(selected)
      vim.notify("Theme switched to " .. selected, vim.log.levels.INFO)
    end
  end)
end

-- Create user command :ThemeSwitch
vim.api.nvim_create_user_command("ThemeSwitch", M.pick_theme, {})

-- Initialize (Load theme immediately when this file is required)
load_theme()

return M
