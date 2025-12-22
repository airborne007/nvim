# Track Specification: Replace Telescope with snacks.picker

## Overview
彻底移除项目中的 `telescope.nvim` 插件及其相关配置，并使用 `snacks.nvim` 的 `picker` 模块作为全新的模糊查找和导航引擎。

## Goals
- 清理项目依赖，移除 Telescope 及其相关的 FZF 原生依赖。
- 迁移核心查找功能至 `snacks.picker`。
- 保持现有的快捷键映射一致性，确保无缝切换。

## Functional Requirements
1. **Plugin Cleanup**:
   - 从 `lua/plugins.lua` (或自动导入的目录) 中移除 `nvim-telescope/telescope.nvim` 及其依赖。
   - 删除 `lua/plugin-config/telescope.lua` 配置文件。
2. **Feature Migration**:
   - 文件查找: 迁移 `<leader>e` 至 `Snacks.picker.files()`。
   - 文本搜索: 迁移 `<leader>f` 至 `Snacks.picker.grep()`。
   - 缓冲区管理: 迁移 `<leader>b` 至 `Snacks.picker.buffers()`。
   - LSP 符号查找: 迁移 `<leader>s` 至 `Snacks.picker.lsp_symbols()`。
   - Git 增强: 添加/迁移 Git 状态和日志查找功能。
   - 诊断查找: 集成 `Snacks.picker.diagnostics()`。
3. **UI/UX Consistency**:
   - 配置 `snacks.picker` 的样式（如布局、边框），确保其与项目整体审美一致。
   - 确保 `snacks.picker` 中的快捷键（如打开方式、预览切换）符合预期。

## Non-Functional Requirements
- **启动性能**: 移除 Telescope 应有助于进一步提升 Neovim 的启动速度。
- **运行性能**: `snacks.picker` 基于 Rust/C 级优化（如果涉及搜索）和 Lua 高效渲染，应提供极速的交互体验。

## Acceptance Criteria
- [ ] `telescope` 插件已卸载，相关配置文件夹/文件已删除。
- [ ] 原有的快捷键（`<leader>e`, `<leader>f`, `<leader>b`, `<leader>s`）均能正常工作并触发 `snacks.picker`。
- [ ] 能够通过 `snacks.picker` 查找文件、搜索文本、切换缓冲区和查看 LSP 符号。
- [ ] 能够查看 Git 状态和诊断信息。

## Out of Scope
- 迁移所有可能的 Telescope 扩展（如 `telescope-env` 等，除非有明确需求）。
- 重新设计全新的快捷键体系。
