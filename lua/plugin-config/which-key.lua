return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = "modern", -- modern, classic, helix
    -- delay = 0, 
    spec = {
      { "<leader>f", group = "file/find", icon = "🔍" },
      { "<leader>b", group = "buffer", icon = "📝" },
      { "<leader>g", group = "git", icon = "📦" },
      { "<leader>h", desc = "Split Horizontal", icon = "➖" },
      { "<leader>c", group = "code", icon = "💻" },
      { "<leader>s", group = "search/session", icon = "🔦" },
      { "<leader>x", group = "diagnostics", icon = "🚨" },
      { "<leader>q", group = "quit/session", icon = "🚪" },
      { "<leader>w", group = "window", icon = "🪟" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
    },
    win = {
      border = "rounded", -- none, single, double, shadow
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
  }
}
