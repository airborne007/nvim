return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      {
        "junegunn/fzf",
        build = function()
          vim.fn["fzf#install"]()
        end,
      },
    },
    opts = {
      auto_enable = true,
      auto_resize_height = true, -- Automatically resize the quickfix window
      preview = {
        win_height = 25,
        win_vheight = 25,
        delay_syntax = 80,
        border = "rounded", -- Consistent with Snacks/other UI
        show_title = true,
        should_preview_callback = function(bufnr, qwinid)
          local ret = true
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(bufname)
          -- Skip preview for large files (>100KB) to keep it snappy
          if fsize > 100 * 1024 then
            ret = false
          end
          return ret
        end
      },
      func_map = {
        -- Custom keybindings inside the quickfix window if needed
        -- 'o' to open, 'p' to toggle preview manually, etc.
        -- Default bindings are usually sufficient:
        -- <CR>/o: open
        -- p: toggle preview
        -- <Tab>: select
      },
    }
  }
}
