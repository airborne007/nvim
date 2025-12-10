# Neovim 配置文件说明

这是一个现代化的 Neovim 配置，采用模块化设计，使用 Lua 语言编写，提供了良好的用户体验和高效的开发环境。

## 配置特点

- **模块化结构**：按功能分组，便于维护和扩展
- **现代 Lua API**：使用 Neovim 0.11+ 的新特性和 API
- **高效插件管理**：基于 Lazy.nvim 的插件加载系统
- **优化的用户体验**：精心设计的快捷键和自动命令
- **可定制性**：清晰的配置结构，易于调整和扩展

## 配置要求

- Neovim 版本：最新稳定版（推荐使用 0.11+）
- 字体：推荐使用 Nerd Font 以支持图标显示
- 系统：支持 Linux、macOS 和 Windows（WSL）

## 目录结构

```
~/.config/nvim/
├── init.lua              # 配置入口文件
├── README.md             # 配置说明文档
├── LICENSE               # 许可证文件
├── .gitignore            # Git 忽略文件
└── lua/
    ├── basic.lua         # 基础配置（编辑器行为、界面等）
    ├── plugins.lua       # 插件配置（插件加载和管理）
    ├── keybindings.lua   # 快捷键映射
    ├── auto-command.lua  # 自动命令配置
    ├── core/             # 模块化核心配置组件
    │   ├── clipboard.lua     # 剪贴板配置
    │   ├── command.lua       # 命令行配置
    │   ├── completion.lua    # 自动补全配置
    │   ├── config.lua        # 核心配置管理
    │   ├── extension.lua     # 扩展机制
    │   ├── file.lua          # 文件处理配置
    │   ├── folding.lua       # 代码折叠配置
    │   ├── history.lua       # 历史记录配置
    │   ├── hot_reload.lua    # 配置热重载功能
    │   ├── indent.lua        # 缩进配置
    │   ├── keyboard.lua      # 键盘设置
    │   ├── search.lua        # 搜索配置
    │   ├── security.lua      # 安全保护机制
    │   ├── style.lua         # 样式与颜色配置
    │   ├── visual.lua        # 视觉效果配置
    │   └── window.lua        # 窗口管理配置
    ├── extensions/       # 用户扩展目录
    │   └── example.lua   # 扩展示例
    ├── lsp/              # LSP 语言服务器配置
    │   ├── init.lua      # LSP 主配置
    │   ├── bashls.lua    # Bash 语言服务器
    │   ├── bufls.lua     # Buffer 语言服务器
    │   ├── gopls.lua     # Go 语言服务器
    │   ├── jsonls.lua    # JSON 语言服务器
    │   ├── lua.lua       # Lua 语言服务器
    │   ├── pylsp.lua     # Python 语言服务器
    │   └── rust.lua      # Rust 语言服务器
    └── plugin-config/    # 插件配置目录
        ├── advanced-git-search.lua  # 高级 Git 搜索配置
        ├── alpha.lua                 # 启动界面配置
        ├── blink-cmp.lua             # 自动补全配置
        ├── bufferline.lua            # 缓冲区标签配置
        ├── comment.lua               # 代码注释配置
        ├── flash.lua                 # 快速跳转配置
        ├── gemini-cli.lua            # Gemini AI 集成配置
        ├── gitsigns.lua              # Git 状态指示器配置
        ├── lualine.lua               # 状态栏配置
        ├── nvim-autopairs.lua        # 自动括号配置
        ├── nvim-tree.lua             # 文件资源管理器配置
        ├── nvim-treesitter.lua       # 语法高亮配置
        ├── sentiment.lua             # 滚动条增强配置
        ├── telescope.lua             # 模糊搜索配置
        ├── themery.lua               # 主题切换工具配置
        ├── trouble.lua               # 诊断列表配置
        ├── which-key.lua             # 按键提示配置
        └── windsurf.lua              # 窗口导航增强配置
```

## 配置文件说明

### 1. init.lua
配置的入口文件，按顺序加载各个模块：
```lua
-- 模块化核心配置
require('core.config').setup()

-- 核心扩展模块
require('core.extension')

-- 热重载功能
require('core.hot_reload').setup()

-- 安全保护机制
require('core.security').setup()

-- 插件管理
require('plugins')

-- 加载用户扩展
-- 如果存在扩展目录，则加载所有扩展
local extensions_dir = vim.fn.stdpath('config') .. '/lua/extensions'
if vim.loop.fs_stat(extensions_dir) then
  for _, file in ipairs(vim.fn.readdir(extensions_dir)) do
    if file:match('%.lua$') then
      local extension_name = file:gsub('%.lua$', '')
      pcall(require, 'extensions.' .. extension_name)
    end
  end
end

-- 快捷键映射
require('keybindings')

-- LSP 配置
require('lsp')

-- 自动命令
require("auto-command")
```

### 2. basic.lua
包含 Neovim 的基础配置，按功能分组管理：
- **历史记录与编码**：命令历史长度、UTF-8 编码设置
- **视觉与界面**：行号显示、光标高亮、符号列、参考线
- **缩进与制表符**：Tab 宽度、自动缩进、智能缩进
- **搜索**：忽略大小写、智能搜索、实时搜索
- **命令行与界面**：命令行高度、标签栏显示
- **文件处理**：自动读取、隐藏缓冲区、备份设置
- **键盘与输入**：快捷键延迟、鼠标支持
- **窗口与分割**：窗口分割方向
- **补全**：补全菜单设置
- **样式与颜色**：深色背景、真彩色支持、不可见字符显示
- **代码折叠**：折叠方式、折叠级别
- **剪贴板**：系统剪贴板集成
- **WSL 特定设置**：Windows Subsystem for Linux 适配

**注意**：basic.lua 中的配置也被拆分为模块化的核心组件（位于 `lua/core/` 目录），可以通过 `core.config` 进行统一管理和加载。

### 3. plugins.lua
使用 Lazy.nvim 管理所有插件，按功能分组：
- 插件管理器自身
- 基础依赖插件
- 主题与外观
- UI 组件
- 编辑增强
- Git 工具
- 模糊搜索
- 语法解析
- LSP 相关
- 自动补全
- AI 辅助

### 4. keybindings.lua
定义了所有自定义快捷键，按功能分组：
- 基础编辑快捷键
- 窗口管理快捷键
- 插件快捷键（nvim-tree、bufferline、telescope 等）

### 5. auto-command.lua
管理自动命令，按功能分组：
- 复制高亮组
- 光标行管理组
- 文件位置记忆组
- 文件更新检测组
- 临时文件处理组
- 格式选项设置组
- 语言特定设置组
- 文件类型识别组
- WSL 特定设置组

### 6. lsp/init.lua
LSP 语言服务器配置，使用 Mason 和 mason-lspconfig 管理：
- 支持的语言服务器：gopls、pylsp、rust_analyzer、lua_ls、bashls、jsonls
- 自动安装和配置
- 默认 on_attach 函数（绑定 LSP 快捷键）

### 7. plugin-config/
每个插件的单独配置文件，采用统一的配置风格，便于管理和扩展。

## 安装和使用

1. 确保安装了 Neovim 0.11+
2. 备份现有的 Neovim 配置（如果有）：
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```
3. 克隆或复制此配置到 `~/.config/nvim/`
4. 启动 Neovim，Lazy.nvim 会自动安装所需插件：
   ```bash
   nvim
   ```
5. 等待插件安装完成，即可开始使用

## 主要插件

### 插件管理器
- **Lazy.nvim**：现代化的插件管理器，支持延迟加载、自动安装和更新

### 语法与LSP
- **nvim-treesitter**：语法高亮和解析，支持多种编程语言
- **nvim-lspconfig**：LSP 客户端配置，提供代码补全、诊断和重构功能
- **mason.nvim**：LSP 服务器和工具安装器，简化 LSP 配置
- **mason-lspconfig.nvim**：Mason 和 lspconfig 的桥接，自动配置 LSP 服务器

### 自动补全
- **blink.cmp**：高性能自动补全，支持多种补全源
- **vim-vsnip**：代码片段引擎
- **friendly-snippets**：通用代码片段集合

### 搜索与导航
- **telescope.nvim**：模糊搜索工具，支持文件、缓冲区、命令等搜索
- **flash.nvim**：快速跳转插件，提高编辑效率

### UI 组件
- **nvim-tree.lua**：文件资源管理器，提供直观的文件导航
- **lualine.nvim**：状态栏，显示当前文件信息、LSP 状态等
- **bufferline.nvim**：缓冲区标签栏，方便切换和管理多个文件
- **FTerm.nvim**：浮动终端，提供便捷的命令行访问

### Git 工具
- **gitsigns.nvim**：Git 状态指示器，显示行级别的 Git 变更
- **advanced-git-search.nvim**：高级 Git 搜索功能

### 编辑增强
- **nvim-autopairs**：自动括号补全
- **comment.nvim**：代码注释工具
- **vim-sandwich**：括号、引号等环绕操作增强
- **trouble.nvim**：诊断列表，集中显示 LSP 诊断信息

### AI 辅助
- **gemini-cli.nvim**：Gemini AI 集成，提供代码生成和解释功能

## 快捷键参考

### 基础快捷键
- `<Leader>w`：保存文件
- `<Leader>q`：关闭当前窗口
- `<Leader>c`：关闭当前缓冲区
- `<C-h>`/`<C-j>`/`<C-k>`/`<C-l>`：窗口切换

### 插件快捷键
- `<Leader>e`：打开/关闭文件资源管理器
- `<Leader>ff`：查找文件
- `<Leader>fg`：搜索字符串
- `<Leader>fb`：查找缓冲区
- `<Leader>fh`：查找帮助文档

### LSP 快捷键
- `K`：显示文档
- `gd`：跳转到定义
- `gD`：跳转到声明
- `gi`：跳转到实现
- `go`：跳转到类型定义
- `gr`：查找引用
- `<C-k>`：显示签名帮助
- `<F2>`：重命名
- `<F4>`：代码操作
- `gl`：显示诊断信息

## 定制和扩展

### 添加新插件
1. 在 `plugins.lua` 中添加插件声明，包括名称、描述、加载条件和依赖
2. （可选）在 `plugin-config/` 目录下创建插件配置文件，使用统一的配置格式：

```lua
local M = {
  '插件名称',
  -- 加载条件
  event = 'InsertEnter',
  -- 依赖
  dependencies = { '其他插件' },
}

function M.config()
  -- 插件配置代码
  require('插件名称').setup({
    -- 配置选项
  })
end

return M
```

### 修改快捷键
编辑 `keybindings.lua` 文件，按照现有格式添加或修改快捷键映射：

```lua
-- 基础编辑快捷键
vim.keymap.set('n', '<Leader>w', '<cmd>w<CR>', { desc = '保存文件' })
```

### 修改基础配置
编辑 `basic.lua` 文件，修改相应的配置项，配置按功能分组，便于查找和修改：

```lua
-- 行号设置
vim.opt.number = true          -- 显示绝对行号
vim.opt.relativenumber = true  -- 显示相对行号
```

### 添加自动命令
编辑 `auto-command.lua` 文件，添加新的自动命令组和自动命令：

```lua
-- 文件类型特定设置
local filetype_grp = vim.api.nvim_create_augroup('user_filetype', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = filetype_grp,
  pattern = { 'lua', 'python' },
  callback = function()
    vim.opt_local.shiftwidth = 4
  end,
})
```

## 性能优化

### 插件加载策略
- **延迟加载**：所有插件都配置了明确的加载条件（event/ft/keys），减少启动时间
- **按需加载**：只有在需要时才加载插件及其依赖
- **分组管理**：插件按功能分组，便于管理和优化

### 启动性能指标
- 平均启动时间：< 300ms（取决于系统性能和已安装插件数量）
- 内存占用：启动时约 50MB，编辑大型文件时约 100-150MB

### 优化建议
- 定期清理不需要的插件
- 避免使用过多的自动命令和事件监听器
- 为大型项目配置合适的 LSP 服务器设置

## 插件加载条件说明

所有插件都配置了明确的加载条件，以提高启动性能：

- **event**：在特定事件发生时加载（如 InsertEnter、BufReadPre）
- **ft**：在特定文件类型打开时加载（如 lua、python）
- **keys**：在按下特定快捷键时加载
- **lazy**：仅在明确调用时加载

示例：
```lua
{
  'hrsh7th/vim-vsnip',
  event = 'InsertEnter', -- 在进入插入模式时加载
  description = "代码片段引擎",
}
```

## 问题排查

1. 如果启动出现错误，检查 Neovim 版本是否符合要求
2. 查看插件安装日志：`:Lazy log`
3. 检查语法错误：`nvim --headless +qa`
4. 禁用部分插件以定位问题：在 `plugins.lua` 中注释掉插件声明

## 更新日志

- **v2.0**：全面重构为模块化 Lua 配置
- **v1.0**：基于 Vimscript 的初始配置

## 许可证

MIT License
