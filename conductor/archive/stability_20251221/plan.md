# Track Plan: Stability & Testing Framework

## Phase 1: Infrastructure Setup [checkpoint: b017ba2]
Establish the environment required to run Lua tests within Neovim.

- [x] Task: Create `tests/` directory structure and a minimal `tests/minimal_init.lua` to bootstrap `lazy.nvim` and `plenary.nvim` for the test environment.
- [x] Task: Create a test runner script (e.g., `scripts/test.sh` or `Makefile`) that launches Neovim in headless mode and executes tests using `plenary.test`.
- [x] Task: Create a dummy test file `tests/core/sanity_spec.lua` to verify the test runner is working correctly.
- [x] Task: Conductor - User Manual Verification 'Infrastructure Setup' (Protocol in workflow.md)

## Phase 2: Core Module Testing [checkpoint: d816f50]
Write actual tests for the critical logic in the configuration.

- [x] Task: Analyze `lua/core/extension.lua` (or similar utility) and create a corresponding test file `tests/core/extension_spec.lua`.
- [x] Task: Implement unit tests for `extension.lua` covering loading logic and error handling.
- [x] Task: Analyze `lua/plugin-config/editor-utils.lua` (if applicable) and create `tests/plugin-config/editor_utils_spec.lua`.
- [x] Task: Implement unit tests for editor utility functions.
- [x] Task: Conductor - User Manual Verification 'Core Module Testing' (Protocol in workflow.md)

## Phase 3: Documentation & Finalization [checkpoint: 6f59f0d]
Ensure the testing process is documented and easy to use.

- [x] Task: Update `README.md` with a "Development" section explaining how to run tests.
- [x] Task: Conductor - User Manual Verification 'Documentation & Finalization' (Protocol in workflow.md)
