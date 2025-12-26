# Specification: 集成 DAP 调试环境 (Go & Python)

## Overview
为 Neovim 配置集成功能完善的调试环境 (DAP)，重点支持 Go 和 Python 语言，提供类似 IDE 的可视化调试体验。

## Functional Requirements
- **多语言支持**: 
  - 集成 Go 语言调试支持 (使用 `delve`)。
  - 集成 Python 语言调试支持 (使用 `debugpy`)。
- **调试适配器管理**: 
  - 使用 `mason.nvim` 和 `mason-nvim-dap.nvim` 自动安装和管理 `delve` 与 `debugpy`。
- **可视化界面**:
  - 集成 `nvim-dap-ui` 提供布局管理器（堆栈、变量、监视点、终端）。
  - 集成 `nvim-dap-virtual-text` 在代码行内实时显示变量值。
- **交互与快捷键**:
  - 采用标准功能键映射 (Standard Function Keys):
    - `F5`: 开始调试 / 继续 (Continue)
    - `F9`: 切换断点 (Toggle Breakpoint)
    - `F10`: 单步跳过 (Step Over)
    - `F11`: 单步进入 (Step Into)
    - `F12`: 单步跳出 (Step Out)
- **特定语言增强**:
  - 使用 `nvim-dap-go` 简化 Go 调试配置。
  - 使用 `nvim-dap-python` 简化 Python 调试配置。

## Acceptance Criteria
- [ ] 可以在 Go 文件中通过 `F9` 设置断点，`F5` 启动调试并正确停在断点处。
- [ ] 可以在 Python 文件中启动调试并使用 `F10/F11` 进行单步操作。
- [ ] 调试开始时自动打开 `nvim-dap-ui` 界面，调试结束时自动关闭。
