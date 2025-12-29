return {
  {
    'echasnovski/mini.comment',
    version = '*',
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          visual = "gS", -- Remap visual surround to gS to save S for Flash
        }
      })
    end
  },
}