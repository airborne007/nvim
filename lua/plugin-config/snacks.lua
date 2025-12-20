return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      terminal = { 
        enabled = true,
        win = {
          position = "float",
          backdrop = 60, -- Background dimming (0-100)
          width = 0.8,   -- 80% of screen width
          height = 0.8,  -- 80% of screen height
          border = "rounded",
          wo = {
            winblend = 15, -- Window transparency (0-100)
          },
        },
      },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
}