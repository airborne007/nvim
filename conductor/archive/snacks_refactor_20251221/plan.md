# Track Plan: Project Refactor with snacks.nvim

## Phase 1: Core UI & Notification Refactor [checkpoint: d4f0edd]
启用并配置 snacks.nvim 的核心 UI 模块（通知、输入、选择）。

- [x] Task: Write Tests for `snacks.notifier` integration (Verify `vim.notify` is hijacked).
- [x] Task: Implement `snacks.notifier` configuration in `lua/plugin-config/snacks.lua`.
- [x] Task: Write Tests for `snacks.input` and `snacks.select` (Verify `vim.ui` functions are replaced).
- [x] Task: Implement `snacks.input` and `snacks.select` configurations.
- [x] Task: Conductor - User Manual Verification 'Core UI & Notification Refactor' (Protocol in workflow.md)

## Phase 2: Visual & Movement Enhancements [checkpoint: 30f3e41]
配置平滑滚动、缩进线和作用域高亮。

- [x] Task: Write Tests for `snacks.scroll`, `snacks.indent`, and `snacks.scope` presence in config.
- [x] Task: Implement configurations for `scroll`, `indent`, and `scope` in `lua/plugin-config/snacks.lua`.
- [x] Task: Conductor - User Manual Verification 'Visual & Movement Enhancements' (Protocol in workflow.md)

## Phase 3: Minimalist Dashboard Implementation [checkpoint: 37b197e]
创建极简风格的启动页。

- [x] Task: Write Tests for `snacks.dashboard` configuration (Verify layout and key sections).
- [x] Task: Implement `snacks.dashboard` with minimal style (Recent files, keybindings).
- [x] Task: Conductor - User Manual Verification 'Minimalist Dashboard Implementation' (Protocol in workflow.md)

## Phase 4: Final Polish & Cleanup [checkpoint: 97c2079]
清理冗余配置并进行最终测试。

- [x] Task: Identify and remove any redundant configurations from older UI plugins (if any).
- [x] Task: Run full test suite and ensure configuration stability.
- [x] Task: Conductor - User Manual Verification 'Final Polish & Cleanup' (Protocol in workflow.md)
