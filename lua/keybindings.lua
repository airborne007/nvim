--[[
快捷键映射配置文件
按功能分组管理快捷键，提高可读性和可维护性
--]]

-- 设置 leader 键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 本地变量定义
local map = vim.keymap.set  -- 快捷键映射函数别名

-- 默认快捷键选项
local default_opts = {
  noremap = true,  -- 非递归映射
  silent = true    -- 不显示执行信息
}

-- 模式说明
-- n: normal_mode (普通模式)
-- i: insert_mode (插入模式)
-- v: visual_mode (可视模式)
-- x: visual_block_mode (可视块模式)
-- t: term_mode (终端模式)
-- c: command_mode (命令模式)


-- ============================================
-- 基础编辑快捷键
-- ============================================

-- 清除搜索高亮
map("n", "<leader><space>", ":noh<CR>", {
  noremap = true,
  silent = true,
  desc = "清除搜索高亮"
})

-- 可视模式下缩进代码（保持选中状态）
map("v", "<", "<gv", {
  noremap = true,
  silent = true,
  desc = "向左缩进"
})
map("v", ">", ">gv", {
  noremap = true,
  silent = true,
  desc = "向右缩进"
})

-- 可视模式下上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", {
  noremap = true,
  silent = true,
  desc = "向下移动选中文本"
})
map("v", "K", ":move '<-2<CR>gv-gv", {
  noremap = true,
  silent = true,
  desc = "向上移动选中文本"
})

-- 可视模式下粘贴不复制被替换内容
map("v", "p", '"_dP', {
  noremap = true,
  silent = true,
  desc = "粘贴不复制被替换内容"
})


-- ============================================
-- 窗口管理快捷键
-- ============================================

-- 创建新窗口
map("n", "<leader>h", ":split<CR>", {
  noremap = true,
  silent = true,
  desc = "水平分割窗口"
})
map("n", "<leader>v", ":vsplit<CR>", {
  noremap = true,
  silent = true,
  desc = "垂直分割窗口"
})

-- 关闭窗口
map("n", "sc", "<C-w>c", {
  noremap = true,
  silent = true,
  desc = "关闭当前窗口"
})
map("n", "so", "<C-w>o", {
  noremap = true,
  silent = true,
  desc = "关闭其他窗口"
})

-- 窗口间跳转
map("n", "<C-h>", "<C-w>h", {
  noremap = true,
  silent = true,
  desc = "跳转到左侧窗口"
})
map("n", "<C-j>", "<C-w>j", {
  noremap = true,
  silent = true,
  desc = "跳转到下方窗口"
})
map("n", "<C-k>", "<C-w>k", {
  noremap = true,
  silent = true,
  desc = "跳转到上方窗口"
})
map("n", "<C-l>", "<C-w>l", {
  noremap = true,
  silent = true,
  desc = "跳转到右侧窗口"
})

-- 调整窗口大小
map("n", "<C-Left>", ":vertical resize -2<CR>", {
  noremap = true,
  silent = true,
  desc = "缩小窗口宽度"
})
map("n", "<C-Right>", ":vertical resize +2<CR>", {
  noremap = true,
  silent = true,
  desc = "增加窗口宽度"
})
map("n", "<C-Down>", ":resize +2<CR>", {
  noremap = true,
  silent = true,
  desc = "增加窗口高度"
})
map("n", "<C-Up>", ":resize -2<CR>", {
  noremap = true,
  silent = true,
  desc = "缩小窗口高度"
})
map("n", "s=", "<C-w>=", {
  noremap = true,
  silent = true,
  desc = "窗口大小平均分配"
})


-- ============================================
-- 插件快捷键映射表
-- ============================================
local pluginKeys = {}

-- ============================================
-- 文件资源管理器 (nvim-tree)
-- ============================================
map('n', '<F3>', ':NvimTreeToggle<CR>', {
  noremap = true,
  silent = true,
  desc = "切换文件资源管理器"
})


-- ============================================
-- 缓冲区管理 (bufferline)
-- ============================================
map("n", "<leader>q", ":BufferLineCyclePrev<CR>", {
  noremap = true,
  silent = true,
  desc = "切换到上一个缓冲区"
})
map("n", "<leader>w", ":BufferLineCycleNext<CR>", {
  noremap = true,
  silent = true,
  desc = "切换到下一个缓冲区"
})
map("n", "<leader>c", ":bd<CR>", {
  noremap = true,
  silent = true,
  desc = "关闭当前缓冲区"
})


-- ============================================
-- 浮动终端 (FTerm)
-- ============================================
map('n', '<A-d>', '<CMD>lua require("FTerm").toggle()<CR>', {
  noremap = true,
  silent = true,
  desc = "切换浮动终端"
})
map('t', '<A-d>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', {
  noremap = true,
  silent = true,
  desc = "在终端中切换浮动终端"
})


-- ============================================
-- AI助手 (Gemini CLI)
-- ============================================
map("n", "<leader>g", "<cmd>Gemini toggle<cr>", {
  noremap = true,
  silent = true,
  desc = "切换 Gemini CLI"
})
map({"n", "v"}, "<leader>ga", "<cmd>Gemini ask<cr>", {
  noremap = true,
  silent = true,
  desc = "向 Gemini 提问"
})
map("n", "<leader>gf", "<cmd>Gemini add_file<cr>", {
  noremap = true,
  silent = true,
  desc = "添加文件到 Gemini"
})


-- ============================================
-- Git 状态管理 (gitsigns)
-- ============================================
pluginKeys.mapgit = function(mapbuf)
  local gitsigns = require('gitsigns')

  -- 导航到下一个/上一个 Git hunk
  mapbuf('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal({ ']c', bang = true })
    else
      gitsigns.nav_hunk('next')
    end
  end, {
    noremap = true,
    silent = true,
    desc = "下一个 Git hunk"
  })

  mapbuf('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal({ '[c', bang = true })
    else
      gitsigns.nav_hunk('prev')
    end
  end, {
    noremap = true,
    silent = true,
    desc = "上一个 Git hunk"
  })

  -- 切换当前行的 Git blame 显示
  mapbuf('n', '<leader>tb', gitsigns.toggle_current_line_blame, {
    noremap = true,
    silent = true,
    desc = "切换当前行 Git blame"
  })
end


-- ============================================
-- 模糊搜索 (telescope)
-- ============================================
map("n", "<leader>e", ":Telescope find_files<CR>", {
  noremap = true,
  silent = true,
  desc = "查找文件"
})
map("n", "<leader>f", ":Telescope live_grep<CR>", {
  noremap = true,
  silent = true,
  desc = "内容搜索"
})
map("n", "<leader>b", ":Telescope buffers<CR>", {
  noremap = true,
  silent = true,
  desc = "查找缓冲区"
})
map("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", {
  noremap = true,
  silent = true,
  desc = "查找文档符号"
})


-- ============================================
-- 高级 Git 搜索 (advanced-git-search)
-- ============================================
map("n", "<leader>gs", ":AdvancedGitSearch diff_commit_file<CR>", {
  noremap = true,
  silent = true,
  desc = "Git 文件提交历史"
})
map("v", "<leader>gs", ":AdvancedGitSearch diff_commit_line<CR>", {
  noremap = true,
  silent = true,
  desc = "Git 行提交历史"
})


-- ============================================
-- 诊断管理 (trouble)
-- ============================================
map("n", "<leader>xx", function() require("trouble").toggle() end, {
  noremap = true,
  silent = true,
  desc = "切换诊断面板"
})
map("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, {
  noremap = true,
  silent = true,
  desc = "工作区诊断"
})
map("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, {
  noremap = true,
  silent = true,
  desc = "文档诊断"
})
map("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, {
  noremap = true,
  silent = true,
  desc = "快速修复列表"
})
map("n", "<leader>xl", function() require("trouble").toggle("loclist") end, {
  noremap = true,
  silent = true,
  desc = "位置列表"
})
map("n", "gR", function() require("trouble").toggle("lsp_references") end, {
  noremap = true,
  silent = true,
  desc = "LSP 引用列表"
})


-- ============================================
-- LSP 相关快捷键
-- ============================================
pluginKeys.maplsp = function(mapbuf)
  -- 重命名符号
  mapbuf('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {
    noremap = true,
    silent = true,
    desc = "重命名符号"
  })
  
  -- 代码操作
  mapbuf('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', {
    noremap = true,
    silent = true,
    desc = "代码操作"
  })
  
  -- 跳转到定义
  mapbuf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {
    noremap = true,
    silent = true,
    desc = "跳转到定义"
  })
  
  -- 显示悬浮文档
  mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', {
    noremap = true,
    silent = true,
    desc = "显示文档"
  })
  
  -- 跳转到声明
  mapbuf('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {
    noremap = true,
    silent = true,
    desc = "跳转到声明"
  })
  
  -- 跳转到实现
  mapbuf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {
    noremap = true,
    silent = true,
    desc = "跳转到实现"
  })
  
  -- 跳转到引用
  mapbuf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {
    noremap = true,
    silent = true,
    desc = "跳转到引用"
  })
  
  -- 显示诊断信息
  mapbuf('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', {
    noremap = true,
    silent = true,
    desc = "显示诊断信息"
  })
  
  -- 跳转到上一个诊断
  mapbuf('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {
    noremap = true,
    silent = true,
    desc = "上一个诊断"
  })
  
  -- 跳转到下一个诊断
  mapbuf('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', {
    noremap = true,
    silent = true,
    desc = "下一个诊断"
  })
  
  -- 代码格式化
  mapbuf('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', {
    noremap = true,
    silent = true,
    desc = "代码格式化"
  })
end


-- 返回插件快捷键映射表
return pluginKeys
