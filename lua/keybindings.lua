-- setting leader key to " "
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 本地变量
local map = vim.keymap.set

local opt = {
  noremap = true,
  silent = true
}

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

------------------------------------------------------------------
-- Clean search (highlight)
map("n", "<leader><space>", ":noh<CR>", opt)
-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 在visual mode 里粘贴不要复制
map("v", "p", '"_dP', opt)

------------------------------------------------------------------
-- windows 分屏快捷键
map("n", "<leader>h", ":split<CR>", opt)
map("n", "<leader>v", ":vsplit<CR>", opt)

-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt) -- close others
-- ctrl + hjkl  窗口之间跳转
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
map("n", "<C-l>", "<C-w>l", opt)

-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
-- 上下比例
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 相等比例
map("n", "s=", "<C-w>=", opt)

--------------------------------------------------------------------

-- 插件快捷键
local pluginKeys = {}

-- nvimTree
map('n', '<F3>', ':NvimTreeToggle<CR>', opt)

-- bufferline
-- Buffer nav
map("n", "<leader>q", ":BufferLineCyclePrev<CR>", opt)
map("n", "<leader>w", ":BufferLineCycleNext<CR>", opt)
-- Close buffer
map("n", "<leader>c", ":bd<CR>", opt)

-- floating terminal
map('n', '<A-d>', '<CMD>lua require("FTerm").toggle()<CR>', opt)
map('t', '<A-d>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opt)

-- gitsigns
pluginKeys.mapgit = function(mapbuf)
  local gitsigns = require('gitsigns')

  -- Navigation
  mapbuf('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal({ ']c', bang = true })
    else
      gitsigns.nav_hunk('next')
    end
  end)

  mapbuf('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal({ '[c', bang = true })
    else
      gitsigns.nav_hunk('prev')
    end
  end)

  -- Actions
  mapbuf('n', '<leader>hs', gitsigns.stage_hunk)
  mapbuf('n', '<leader>hr', gitsigns.reset_hunk)
  mapbuf('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
  mapbuf('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
  mapbuf('n', '<leader>hS', gitsigns.stage_buffer)
  mapbuf('n', '<leader>hu', gitsigns.undo_stage_hunk)
  mapbuf('n', '<leader>hR', gitsigns.reset_buffer)
  mapbuf('n', '<leader>hp', gitsigns.preview_hunk)
  mapbuf('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
  mapbuf('n', '<leader>tb', gitsigns.toggle_current_line_blame)
  mapbuf('n', '<leader>hd', gitsigns.diffthis)
  mapbuf('n', '<leader>hD', function() gitsigns.diffthis('~') end)
  mapbuf('n', '<leader>td', gitsigns.toggle_deleted)

  -- Text object
  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

-- Telescope
map("n", "<leader>e", ":Telescope find_files<CR>", opt)
map("n", "<leader>f", ":Telescope live_grep<CR>", opt)
map("n", "<leader>b", ":Telescope buffers<CR>", opt)
map("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", opt)

-- Advanced Git Search
map("n", "<leader>gs", ":AdvancedGitSearch diff_commit_file<CR>", opt)
map("v", "<leader>gs", ":AdvancedGitSearch diff_commit_line<CR>", opt)

-- Trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

-- lsp
-- lsp 回调函数快捷键设置
pluginKeys.maplsp = function(mapbuf)
  -- rename
  mapbuf('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
  -- code action
  mapbuf('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
  -- go xx
  mapbuf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  mapbuf('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  mapbuf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
  mapbuf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
  -- diagnostic
  mapbuf('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
  mapbuf('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
  mapbuf('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- leader + =
  mapbuf('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
  -- mapbuf('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

return pluginKeys
