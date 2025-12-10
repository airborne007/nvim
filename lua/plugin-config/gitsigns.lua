local M = {
  'lewis6991/gitsigns.nvim'
}

function M.config()
  require('gitsigns').setup {
    on_attach = function(bufnr)
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end
      -- 绑定快捷键
      require("keybindings").mapgit(map)
    end
  }
end

return M
