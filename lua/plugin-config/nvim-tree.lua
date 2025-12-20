local M = {
  'kyazdani42/nvim-tree.lua'
}

--
-- This function has been generated from your
--   view.mappings.list
--   view.mappings.custom_only
--   remove_keymaps
--
-- You should add this function to your configuration and set on_attach = on_attach in the nvim-tree setup call.
--
-- Although care was taken to ensure correctness and completeness, your review is required.
--
-- Please check for the following issues in auto generated content:
--   "Mappings removed" is as you expect
--   "Mappings migrated" are correct
--
-- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
--


function M.config()
  -- htps://github.com/kyazdani42/nvim-tree.lua
  -- local nvim_tree = require'nvim-tree'
  local status, nvim_tree = pcall(require, 'nvim-tree')
  if not status then
    vim.notify('nvim-tree not found')
    return
  end

  nvim_tree.setup({
    -- Do not show git status icons
    git = {
      enable = false,
    },
    -- Required for project plugin
    update_cwd = false,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    -- Hide files that don't need to be displayed
    filters = {
      dotfiles = true,
      custom = { 'node_modules', '.idea', '__pycache__' },
    },
    view = {
      -- Width
      width = 40,
      -- Can also be 'right'
      side = 'left',
      -- Do not show line numbers
      number = false,
      relativenumber = false,
      -- Show icons
      signcolumn = 'yes',
    },
    actions = {
      open_file = {
        -- Adapt window size on first open
        resize_window = true,
        -- Close tree when opening file
        quit_on_open = true,
      },
    },
    -- wsl install -g wsl-open
    -- https://github.com/4U6U57/wsl-open/
    system_open = {
      cmd = 'open',
    },
    on_attach = require('keybindings').nvimTreeOnAttach,
  })
end

return M