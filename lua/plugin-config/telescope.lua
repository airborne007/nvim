local M = {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
  }
}

function M.config()
  local status, telescope = pcall(require, "telescope")
  if not status then
    vim.notify("没有找到 telescope")
    return
  end

  local actions = require("telescope.actions")
  local trouble = require("trouble.sources.telescope")

  telescope.setup({
    defaults = {
      -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
      initial_mode = "insert",
      -- vertical , center , cursor
      layout_strategy = "horizontal",
      -- 窗口内快捷键
      mappings = {
        i = {
          -- 上下移动
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["<C-n>"] = "move_selection_next",
          ["<C-p>"] = "move_selection_previous",
          -- 历史记录
          ["<Down>"] = "cycle_history_next",
          ["<Up>"] = "cycle_history_prev",
          -- 关闭窗口
          ["<esc>"] = actions.close,
          -- 预览窗口上下滚动
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
        -- theme = "dropdown", -- 可选参数： dropdown, cursor, ivy
      }
    },
    extensions = {
      advanced_git_search = {}
    },
  })

  require("telescope").load_extension("advanced_git_search")

  pcall(telescope.load_extension, "env")
end

return M
