# Plan: Replace `git_history.lua` with `snacks.nvim`

## Phase 1: Implementation of Mode-Aware Wrapper (Checkpoint SHA: dd19f2e597f04217ed1be72dba74c61389786743)
- [x] Task: Create unit tests for the mode-aware Git history logic (mocking `snacks.picker` and mode detection)
- [x] Task: Implement the "smart" wrapper function in a new or existing core module (e.g., `lua/core/extension.lua` or similar)
- [x] Task: Update `lua/keybindings.lua` to point to the new implementation
- [x] Task: Conductor - User Manual Verification 'Phase 1: Implementation of Mode-Aware Wrapper' (Protocol in workflow.md)

## Phase 2: Optimization, Migration and Cleanup (Checkpoint SHA: afdbf6bf29db7d75eddcb358905ec08e120ae0c0)
- [x] Task: Remove redundant `snacks` Git log keybindings from `lua/keybindings.lua`
- [x] Task: Configure `snacks.picker` to support Ctrl+d/u for preview scrolling
- [x] Task: Verify the new implementation works correctly in both Normal and Visual modes with scrolling
- [x] Task: Delete the legacy extension file `lua/extensions/git_history.lua`
- [x] Task: Ensure no other references to the old extension remain in the codebase
- [x] Task: Conductor - User Manual Verification 'Phase 2: Optimization, Migration and Cleanup' (Protocol in workflow.md)
