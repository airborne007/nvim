local M = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
  }
}

function M.config()
  local status, telescope = pcall(require, "telescope")
  if not status then
    vim.notify("telescope not found")
    return
  end

  local actions = require("telescope.actions")
  local trouble = require("trouble.sources.telescope")

  telescope.setup({
    defaults = {
      -- Initial mode when opening the popup, defaults to insert, can also be normal
      initial_mode = "insert",
      -- vertical, center, cursor
      layout_strategy = "horizontal",
      -- Keybindings within the window
      mappings = require("keybindings").telescopeMappings(actions, trouble),
    },
    pickers = {
      find_files = {
        -- theme = "dropdown", -- Optional parameters: dropdown, cursor, ivy
      }
    },
    extensions = {
    }
  })


  pcall(telescope.load_extension, "env")
end

return M