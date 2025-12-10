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
        jump_labels = true,
      }
    }
  },
  keys = {
    { "<leader>d", mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
    { "<c-s>",     mode = { "c" },           function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}

return M
