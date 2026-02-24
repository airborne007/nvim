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
      require("nvim-surround").setup()

      -- Remap visual surround to gS to save S for Flash
      vim.keymap.set("v", "gS", "<Plug>(nvim-surround-visual)", { desc = "Surround visual selection" })
    end
  },
}
