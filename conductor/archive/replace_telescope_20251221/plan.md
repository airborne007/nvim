# Track Plan: Replace Telescope with snacks.picker

## Phase 1: Cleanup & Infrastructure Setup [checkpoint: 16f9a28]
移除 Telescope 及其依赖，并准备测试环境.

- [x] Task: Write Tests to verify the absence of Telescope and the initial failure of existing keybindings.
- [x] Task: Remove `lua/plugin-config/telescope.lua`.
- [x] Task: Remove Telescope entries from `lua/plugins.lua` (if explicit) or ensure it's not being loaded.
- [x] Task: Identify and remove any Telescope-specific logic in `lua/keybindings.lua` (e.g., `pluginKeys.telescopeMappings`).
- [~] Task: Conductor - User Manual Verification 'Cleanup & Infrastructure Setup' (Protocol in workflow.md)

## Phase 2: Keybindings & Feature Migration [checkpoint: 10de68a]
将现有的查找功能迁移到 `snacks.picker`。

- [x] Task: Write Tests for new `snacks.picker` keybindings (`<leader>e`, `<leader>f`, `<leader>b`, `<leader>s`).
- [x] Task: Update `lua/keybindings.lua` to map `<leader>e`, `<leader>f`, `<leader>b`, `<leader>s` to `Snacks.picker`.
- [x] Task: Update `lua/keybindings.lua` to add mappings for `snacks.picker.git_status()`, `git_log()`, and `diagnostics()`.
- [x] Task: Update `lua/plugin-config/snacks.lua` to ensure the `picker` module is optimally configured (layout, themes).
- [~] Task: Conductor - User Manual Verification 'Keybindings & Feature Migration' (Protocol in workflow.md)

## Phase 3: Final Integration & Stability [checkpoint: 01b7e74]
验证所有功能并清理冗余依赖。

- [x] Task: Run full test suite to ensure no breakage in other modules (LSP, AI, etc.).
- [x] Task: Verify that `blink.cmp` and other plugins that might have interacted with Telescope are functioning correctly.
- [x] Task: Conductor - User Manual Verification 'Final Integration & Stability' (Protocol in workflow.md)
