local M = {}

function M.on_attach(client, bufnr)
  -- 禁用格式化功能，交给专门插件插件处理
  -- client.resolved_capabilities.document_formatting = false
  -- client.resolved_capabilities.document_range_formatting = false

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- 绑定快捷键
  require("keybindings").maplsp(buf_set_keymap)
  -- 保存时自动格式化
  vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
end

return M
