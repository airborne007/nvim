# Track Specification: Project Refactor with snacks.nvim

## Overview
重构项目配置，深度集成 `snacks.nvim` 插件的多个核心模块。通过替换现有的（或添加缺失的）UI 组件和实用工具，提升 Neovim 的交互体验、视觉美感和运行性能。

## Goals
- 统一 UI 交互标准（通知、输入框、选择框）。
- 增强视觉反馈（平滑滚动、缩进线、作用域高亮）。
- 提供极速的极简启动页。

## Functional Requirements
1. **Notifier (通知系统)**: 
   - 启用 `snacks.notifier`。
   - 配置通知弹窗的样式与位置，确保其非阻塞且美观。
2. **Dashboard (启动页)**:
   - 启用 `snacks.dashboard`。
   - 实现极简风格布局，包含：最近使用的文件 (Recent Files)、常用功能快捷键。
3. **UI Enhancements (Input/Select)**:
   - 启用 `snacks.input` 和 `snacks.select`。
   - 确保所有调用 `vim.ui.input` 和 `vim.ui.select` 的操作（如 LSP 重命名、代码操作）都使用 `snacks` 提供的 UI。
4. **Visual & Movement**:
   - 启用 `snacks.scroll`：实现高性能的平滑滚动效果。
   - 启用 `snacks.indent`：提供清晰的缩进线。
   - 启用 `snacks.scope`：动态高亮当前代码块的作用域。

## Non-Functional Requirements
- **性能**: 保持配置的快速启动。`snacks.nvim` 模块应仅在需要时加载（利用其自带的懒加载机制）。
- **一致性**: 确保所有新组件的边框样式（如 rounded）与现有 UI 保持一致。

## Acceptance Criteria
- [ ] 所有的 `vim.notify` 调用都通过 `snacks.notifier` 显示。
- [ ] 启动 Neovim 时显示极简风格的 `snacks.dashboard`。
- [ ] LSP 重命名 (Rename) 和代码操作 (Code Action) 弹出 `snacks` 风格的窗口。
- [ ] 页面滚动时有明显的平滑动画效果。
- [ ] 缩进线显示正确，且能根据光标位置高亮当前作用域。

## Out of Scope
- 替换 `telescope.nvim`：目前保留 Telescope 作为主要的模糊查找工具。
- 复杂的 Dashboard 艺术字定制。
