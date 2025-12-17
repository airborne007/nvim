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
      mappings = {
        i = {
          -- Move up/down
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["<C-n>"] = "move_selection_next",
          ["<C-p>"] = "move_selection_previous",
          -- History
          ["<Down>"] = "cycle_history_next",
          ["<Up>"] = "cycle_history_prev",
          -- Close window
          ["<esc>"] = actions.close,
          -- Scroll preview window up/down
          ["<C-u>"] = "preview_scrolling_up",
          ["<C-d>"] = "preview_scrolling_down",
          -- Trouble
          ["<c-t>"] = trouble.open,
        },
        n = {
          -- Trouble
          ["<c-t>"] = trouble.open,
        }
      },
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