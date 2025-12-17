local M = {
  'akinsho/bufferline.nvim'
}

function M.config()
  vim.opt.termguicolors = true
  require("bufferline").setup {
    options = {
      -- Use nvim built-in lsp
      diagnostics = "nvim_lsp",
      -- Offset left for nvim-tree
      offsets = { {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left"
      } },
      -- show_buffer_icons = false,
      -- show_buffer_close_icons = false,
    }
  }
end

return M