# 现代 Neovim 配置

一份追求极致效率、高度模块化且功能丰富的 Neovim 配置。基于 [lazy.nvim](https://github.com/folke/lazy.nvim) 构建，集成了全功能 LSP 支持、Git 管理以及现代化的 UI 界面。

## ✨ 特性

- **⚡ 极致性能：** 基于 `lazy.nvim` 的懒加载优化，启动速度极快。
- **🧩 模块化架构：** 代码结构清晰，易于定制和扩展。
- **🧠 智能编程：**
    - 完整的 **LSP** 支持 (Go, Rust, Python, Lua, Bash, JSON)。
    - 集成 **DAP** 调试环境 (Go 使用 Delve, Python 使用 Debugpy)。
    - **Blink.cmp** 提供高性能自动补全。
    - **Treesitter** 提供更精准的语法高亮和代码导航。
    - **Trouble.nvim** 集中管理代码诊断信息。

- **🔍 快速导航：**
    - **Snacks.picker** 模糊查找文件、文本和缓冲区。
    - **Snacks.picker.explorer** 文件资源管理器。
    - **Flash.nvim** 光标快速跳转移动。
- **🛡️ Git 集成：**
    - **Gitsigns** 提供行内 Blame、代码块预览/暂存/重置。
    - 自定义 **Git History** 查看器。
- **💻 终端体验：** **Snacks.nvim** 悬浮终端，随时调出命令行。
- **🎨 精美 UI：** 集成现代化 **lualine** (全局状态、LSP 信息)、**bufferline** 和 **which-key**。

## 🛠️ 前置要求

在安装之前，请确保你的系统已满足以下要求：

- **Neovim** >= **0.9.0** (推荐 0.10.0+)
- **Git** (用于插件管理)
- **Ripgrep** (Snacks.picker 文本搜索依赖)
- **Nerd Font** (推荐安装，用于显示图标)
- **C Compiler** (gcc/clang, Treesitter 解析器编译依赖)
- **Language Servers (语言服务器):**
    - **Go:** `gopls` 与 `delve` (调试专用)
    - **Python:** `pylsp`/`pyright` 与 `debugpy` (调试专用)
    - **Rust:** `rust-analyzer`
    - **Lua:** `lua-language-server`
    - **Node.js:** (用于支持 `bashls`, `jsonls` 等)

## 🚀 安装指南

### Arch Linux (推荐)

如果你使用的是 Arch Linux 或其衍生发行版 (如 Manjaro, EndeavourOS 等)，可以使用提供的安装脚本一键完成所有依赖和配置的安装：

```bash
git clone https://github.com/airborne007/nvim.git ~/projects/nvim
cd ~/projects/nvim
make install
```

该脚本将自动执行以下操作：
- 检测并安装 `paru` (AUR 助手)。
- 安装所有必要的系统包 (Neovim, LSPs, 运行时等)。
- 备份现有的 `~/.config/nvim` (如果存在)。
- 将配置链接到 `~/.config/nvim`。

如需卸载：
```bash
make uninstall
```

### 手动安装 (其他发行版)

1.  **备份现有配置（如果有）：**

    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    mv ~/.local/state/nvim ~/.local/state/nvim.bak
    mv ~/.cache/nvim ~/.cache/nvim.bak
    ```

2.  **克隆仓库：**

    ```bash
    git clone https://github.com/airborne007/nvim.git ~/.config/nvim
    ```

3.  **启动 Neovim：**

    ```bash
    nvim
    ```

    *首次启动时，Lazy.nvim 会自动下载并安装所有插件。安装完成后请重启 Neovim 以确保生效。*

### 📋 关于剪贴板支持

Neovim 需要外部工具来实现与系统剪贴板的交互（即 `"+y`, `"+p`）。

- **Linux (X11):** 需要 `xclip` 或 `xsel`（安装脚本会自动安装）
- **Linux (Wayland):** 需要 `wl-clipboard`（安装脚本会自动安装）
- **WSL2:** 如果你想与 Windows 剪贴板同步，请参考 [wsl-clipboard](https://github.com/memoryInject/wsl-clipboard)

## ⌨️ 常用快捷键

Leader 键设置为 **空格 (Space)**。

### 📂 文件管理

| 按键 | 说明 |
| :--- | :--- |
| `<F3>` | 切换文件浏览器 (Snacks Explorer) |
| `<Leader>e` | 查找文件 (Snacks.picker) |
| `<Leader>f` | 全局搜索文本 (Snacks.picker) |
| `<Leader>b` | 查找缓冲区 (Snacks.picker) |

### 🖥️ 窗口与缓冲区

| 按键 | 说明 |
| :--- | :--- |
| `<Leader>h` / `<Leader>v` | 水平 / 垂直 分割窗口 |
| `<Ctrl-h/j/k/l>` | 在窗口间导航 |
| `<Leader>q` / `<Leader>w` | 切换 上一个 / 下一个 缓冲区 |
| `<Leader>c` | 关闭当前缓冲区 |
| `sc` | 关闭当前窗口 |
| `so` | 关闭其他窗口 (只保留当前) |

### 🧠 LSP 与 代码开发

| 按键 | 说明 |
| :--- | :--- |
| `gd` | 跳转到定义 (Definition) |
| `gr` | 查看引用 (References) |
| `K` | 查看悬浮文档 |
| `<Leader>rn` | 变量/符号重命名 |
| `<Leader>a` | 代码操作 (Code Action) |
| `<Leader>=` | 代码格式化 |
| `<Leader>xx` | 打开诊断面板 (Trouble) |

### 🌳 代码选区 (Treesitter)

| 按键 | 说明 |
| :--- | :--- |
| `<Enter>` | 增量选择 (扩大选区) |
| `<Backspace>` | 缩小选区 |

### 🌯 包围字符 (Surround)

| 按键 | 说明 |
| :--- | :--- |
| `ys{动作}{字符}` | 添加包围 (例如 `ysiw"`) |
| `ds{字符}` | 删除包围 (例如 `ds"`) |
| `cs{旧}{新}` | 修改包围 (例如 `cs"'`) |
| `gS{字符}` | 添加包围 (Visual 模式) |

### 🐞 调试 (DAP)

| 按键 | 说明 |
| :--- | :--- |
| `<F5>` | 启动调试 / 继续 (Continue) |
| `<F9>` | 切换断点 (Toggle Breakpoint) |
| `<F10>` | 单步跳过 (Step Over) |
| `<F11>` | 单步进入 (Step Into) |
| `<F12>` | 单步跳出 (Step Out) |
| `<Leader>du` | 开启/关闭 调试 UI |
| `<Leader>dt` | 终止调试会话 |

### 🛡️ Git 操作

| 按键 | 说明 |
| :--- | :--- |
| `]c` / `[c` | 跳转到 下一个 / 上一个 变更块 |
| `<Leader>gl` | 查看 Git 历史 (Normal模式:当前文件 / Visual模式:当前行) |
| `<Leader>gs` | 查看 Git 状态 (Snacks) |
| `<Leader>gp` | 预览当前变更块 (Hunk) |
| `<Leader>gS` | 暂存当前变更块 |
| `<Leader>gr` | 重置当前变更块 (撤销修改) |
| `<Leader>gb` | 查看行 Blame 信息 |

### ⚡ 其他工具

| 按键 | 说明 |
| :--- | :--- |
| `<Alt-d>` | 打开悬浮终端 |
| `s` | Flash 快速跳转 |
| `<Leader><Space>` | 清除搜索高亮 |

*按下 `<Space>` (Leader) 键并稍等片刻，会弹出 `which-key` 菜单显示更多可用命令。*

## 🛠️ 开发指南

### 运行测试

本配置使用 [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) 对核心逻辑进行单元测试。

要在无头模式（headless mode）下运行所有测试：

```bash
make test
```

测试文件位于 `tests/` 目录中，并遵循 `lua/` 目录的模块结构。

## 📂 项目结构

```text
~/.config/nvim/
├── init.lua              # 入口文件
├── lua/
│   ├── auto-command.lua  # 自动命令 (Autocommands)
│   ├── keybindings.lua   # 快捷键配置
│   ├── plugins.lua       # Lazy.nvim 插件入口
│   ├── core/             # 核心配置 (UI, 选项, 安全等)
│   ├── extensions/       # 本地自定义扩展
│   ├── lsp/              # LSP 语言服务器配置
│   └── plugin-config/    # 各个插件的具体配置
```

## 📜 许可证

MIT
