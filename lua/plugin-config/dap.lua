return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = { "delve", "debugpy" },
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end,
        },
      })
      
      require("dap-go").setup({
        -- Additional delve configurations
        delve = {
          path = "dlv",
        },
        -- Higher level configuration
        dap_configurations = {
          {
            type = "go",
            name = "Debug (Build)",
            request = "launch",
            program = "${file}",
          },
          {
            type = "go",
            name = "Debug Package",
            request = "launch",
            program = "${fileDirname}",
          },
        },
      })
      
      -- Python setup
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(mason_path)

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}