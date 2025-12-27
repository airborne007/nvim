local M = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>xx", function() require("trouble").toggle() end, desc = "Toggle diagnostics panel" },
    { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "Workspace diagnostics" },
    { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, desc = "Document diagnostics" },
    { "<leader>xq", function() require("trouble").toggle("quickfix") end, desc = "Quickfix list" },
    { "<leader>xl", function() require("trouble").toggle("loclist") end, desc = "Location list" },
    { "<leader>xr", function() require("trouble").toggle("lsp_references") end, desc = "LSP references list" },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}

return M
