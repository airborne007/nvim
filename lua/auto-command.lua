--[[
自动命令配置文件
使用现代 Lua API 管理自动命令，按功能分组提高可维护性
--]]

local api = vim.api

-- ============================================
-- 自动命令组定义
-- ============================================

-- 1. 复制高亮组
local yank_group = api.nvim_create_augroup('YankHighlight', {
  clear = true
})

api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',  -- 使用搜索高亮的颜色
      timeout = 200,          -- 高亮持续时间(毫秒)
      on_visual = true        -- 可视化模式下也生效
    })
  end,
  desc = '复制内容时显示高亮'
})


-- 2. 光标行管理组
local cursorline_group = api.nvim_create_augroup('CursorLineManagement', {
  clear = true
})

api.nvim_create_autocmd({'InsertLeave', 'WinEnter'}, {
  group = cursorline_group,
  pattern = '*',
  callback = function()
    local ok, cl = pcall(api.nvim_win_get_var, 0, 'auto-cursorline')
    if ok and cl then
      vim.wo.cursorline = true
      api.nvim_win_del_var(0, 'auto-cursorline')
    end
  end,
  desc = '插入模式离开或窗口进入时显示光标行'
})

api.nvim_create_autocmd({'InsertEnter', 'WinLeave'}, {
  group = cursorline_group,
  pattern = '*',
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      api.nvim_win_set_var(0, 'auto-cursorline', cl)
      vim.wo.cursorline = false
    end
  end,
  desc = '插入模式进入或窗口离开时隐藏光标行'
})


-- 3. 文件位置记忆组
local file_pos_group = api.nvim_create_augroup('FilePositionMemory', {
  clear = true
})

api.nvim_create_autocmd('BufReadPost', {
  group = file_pos_group,
  pattern = '*',
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
  desc = '打开文件时跳转到上次编辑位置'
})


-- 4. 文件更新检测组
local file_update_group = api.nvim_create_augroup('FileUpdateDetection', {
  clear = true
})

api.nvim_create_autocmd('FocusGained', {
  group = file_update_group,
  pattern = '*',
  callback = function()
    vim.cmd('checktime')
  end,
  desc = '获取焦点时检查文件是否被外部修改'
})


-- 5. 临时文件处理组
local temp_file_group = api.nvim_create_augroup('TempFileHandling', {
  clear = true
})

api.nvim_create_autocmd('FileType', {
  group = temp_file_group,
  pattern = {
    'qf',
    'help',
    'man',
    'notify',
    'lspinfo',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'PlenaryTestPopup',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false  -- 不显示在缓冲区列表中
    vim.keymap.set('n', 'q', '<cmd>close<cr>', {
      buffer = event.buf,
      silent = true,
      desc = '关闭当前窗口'
    })
  end,
  desc = '为临时文件添加q键关闭功能'
})


-- 6. 格式选项设置组
local format_opts_group = api.nvim_create_augroup('FormatOptions', { clear = true })

api.nvim_create_autocmd('BufEnter', {
  group = format_opts_group,
  pattern = '*',
  callback = function()
    -- 只在普通文件类型中应用，避免影响特殊缓冲区
    if vim.bo.buftype == '' then
      vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end
  end,
  desc = '取消自动注释新行'
})

api.nvim_create_autocmd('FileType', {
  group = format_opts_group,
  pattern = { 'markdown' },
  callback = function()
    vim.opt.formatoptions:append('t')  -- 允许文本自动换行
  end,
  desc = 'Markdown文件启用文本自动换行'
})


-- 7. 语言特定设置组
local lang_specific_group = api.nvim_create_augroup('LangSpecificSettings', { clear = true })

-- 合并缩进设置为单个自动命令
api.nvim_create_autocmd('FileType', {
  group = lang_specific_group,
  pattern = { 'python', 'ruby', 'javascript', 'html', 'css' },
  callback = function()
    local filetype = vim.bo.filetype
    if filetype == 'python' then
      -- Python使用4空格缩进
      vim.bo.tabstop = 4
      vim.bo.softtabstop = 4
      vim.bo.shiftwidth = 4
    else
      -- 其他语言使用2空格缩进
      vim.bo.tabstop = 2
      vim.bo.softtabstop = 2
      vim.bo.shiftwidth = 2
    end
  end,
  desc = '根据文件类型设置缩进宽度'
})

api.nvim_create_autocmd('FileType', {
  group = lang_specific_group,
  pattern = { 'vue' },
  callback = function()
    vim.bo.filetype = 'vue.html.javascript'
  end,
  desc = 'Vue文件设置复合文件类型'
})


-- 8. 文件类型识别组
local filetype_detection_group = api.nvim_create_augroup('FileTypeDetection', { clear = true })

-- 使用一个自动命令处理多种文件类型识别
api.nvim_create_autocmd('BufRead', {
  group = filetype_detection_group,
  pattern = { '*.md', '*.part' },
  callback = function(event)
    local filename = vim.fn.expand(event.match)
    local extension = vim.fn.fnamemodify(filename, ':e')
    
    if extension == 'md' then
      vim.bo.filetype = 'markdown.mkd'
    elseif extension == 'part' then
      vim.bo.filetype = 'html'
    end
  end,
  desc = '根据文件扩展名识别特定文件类型'
})


-- 9. WSL特定设置组 (Windows Subsystem for Linux)
local wsl_group = api.nvim_create_augroup('WSLSettings', {
  clear = true
})

-- 复制到系统剪贴板 (WSL)
local is_wsl = vim.fn.has("wsl") == 1
if is_wsl then
  api.nvim_create_autocmd('TextYankPost', {
    group = wsl_group,
    pattern = '*',
    callback = function()
      vim.fn.system('clip.exe', vim.fn.getreg('"'))
    end,
    desc = 'WSL环境下将复制内容同步到系统剪贴板'
  })
end
