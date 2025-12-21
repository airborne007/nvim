# Track Plan: Stability & Testing Framework

## Phase 1: Infrastructure Setup
Establish the environment required to run Lua tests within Neovim.

- [ ] Task: Create `tests/` directory structure and a minimal `tests/minimal_init.lua` to bootstrap `lazy.nvim` and `plenary.nvim` for the test environment.
- [ ] Task: Create a test runner script (e.g., `scripts/test.sh` or `Makefile`) that launches Neovim in headless mode and executes tests using `plenary.test`.
- [ ] Task: Create a dummy test file `tests/core/sanity_spec.lua` to verify the test runner is working correctly.
- [ ] Task: Conductor - User Manual Verification 'Infrastructure Setup' (Protocol in workflow.md)

## Phase 2: Core Module Testing
Write actual tests for the critical logic in the configuration.

- [ ] Task: Analyze `lua/core/extension.lua` (or similar utility) and create a corresponding test file `tests/core/extension_spec.lua`.
- [ ] Task: Implement unit tests for `extension.lua` covering loading logic and error handling.
- [ ] Task: Analyze `lua/plugin-config/editor-utils.lua` (if applicable) and create `tests/plugin-config/editor_utils_spec.lua`.
- [ ] Task: Implement unit tests for editor utility functions.
- [ ] Task: Conductor - User Manual Verification 'Core Module Testing' (Protocol in workflow.md)

## Phase 3: Documentation & Finalization
Ensure the testing process is documented and easy to use.

- [ ] Task: Update `README.md` with a "Development" section explaining how to run tests.
- [ ] Task: Conductor - User Manual Verification 'Documentation & Finalization' (Protocol in workflow.md)
