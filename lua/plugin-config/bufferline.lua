return {
  'akinsho/bufferline.nvim',
  lazy = false,
  keys = {
    { "<leader>q", "<cmd>BufferLineCyclePrev<cr>", desc = "Switch to previous buffer" },
    { "<leader>w", "<cmd>BufferLineCycleNext<cr>", desc = "Switch to next buffer" },
    { "<leader>c", "<cmd>bd<cr>", desc = "Close current buffer" },
  },
  config = function()
    vim.opt.termguicolors = true
    require("bufferline").setup {
      options = {
        diagnostics = "nvim_lsp",
      }
    }
  end
}
