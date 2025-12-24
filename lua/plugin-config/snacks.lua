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
      notifier = {
        enabled = true,
        timeout = 3000, -- Default timeout in ms
      },
      input = { enabled = true },
      picker = {
        enabled = true,
        ui_select = true, -- replace vim.ui.select
        win = {
          input = {
            keys = {
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
            },
          },
        },
      },
      select = { enabled = true },
      scroll = { enabled = true },
      indent = { enabled = true },
      scope = { enabled = true },
      animate = { enabled = true },
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "recent_files", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
}
