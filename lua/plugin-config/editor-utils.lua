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

      -- Disable default visual S mapping (conflicts with Flash)
      vim.g.nvim_surround_no_visual_mappings = true
      -- Map visual surround to gS
      vim.keymap.set("x", "gS", "<Plug>(nvim-surround-visual)", { desc = "Surround visual selection" })
    end
  },
}