local M = {
  'akinsho/bufferline.nvim'
}

function M.config()
  vim.opt.termguicolors = true
  require("bufferline").setup {
    options = {
      -- Use nvim built-in lsp
      diagnostics = "nvim_lsp",
    }
  }
end

return M