local M = {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    label = {
      uppercase = false,
      rainbow = {
        enabled = true,
      }
    },
    modes = {
      char = {
        enabled = false,
      }
    }
  },
  keys = {
    -- Disable default mappings
    { "s", mode = { "n", "x", "o" }, false },
    { "S", mode = { "n", "x", "o" }, false },
    { "r", mode = "o", false },
    { "R", mode = { "o", "x" }, false },
    { "<c-s>", mode = { "c" }, false },
  },
}

return M
