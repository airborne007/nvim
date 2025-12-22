# Specification: Replace `git_history.lua` with `snacks.nvim`

## Overview
This track aims to replace the custom `lua/extensions/git_history.lua` extension with the built-in Git picker functionality from `snacks.nvim`. The goal is to reduce custom code maintenance while preserving the "smart" mode-aware behavior that switches between File History and Line History based on the current Vim mode.

## Functional Requirements
- **File History**: Provide a picker for the history of the current file (equivalent to `git log --follow -- <file>`).
- **Line History**: Provide a picker for the history of selected lines (equivalent to `git log -L`).
- **Smart Mode Detection**: 
    - In **Normal Mode**, the history command should trigger the File History picker.
    - In **Visual/Visual-Line Mode**, the history command should trigger the Line History picker for the selection.
- **Preview & Diff**: Utilize `snacks.nvim`'s native picker UI for previews and diffing.
- **Action Integration**: Selecting a commit in the picker should open that version of the file (mimicking `Gedit <hash>:<path>`).

## Non-Functional Requirements
- **Maintainability**: Remove the custom `git_history.lua` file and associated logic to simplify the codebase.
- **Consistency**: Align with the project's shift towards using `snacks.nvim` for core UI components.

## Acceptance Criteria
- [ ] Executing the "Git History" command in Normal mode opens the `snacks.picker.git_log` for the current file.
- [ ] Executing the "Git History" command in Visual mode opens the `snacks.picker.git_log_line` for the selected range.
- [ ] The `lua/extensions/git_history.lua` file is deleted.
- [ ] All existing keybindings previously pointing to `git_history.lua` now point to the new `snacks`-based wrapper.
- [ ] No regression in functionality for viewing commit diffs or opening specific commit versions.

## Out of Scope
- Porting the Quickfix fallback (assuming `snacks.nvim` is stable enough).
- Adding new Git features beyond what `git_history.lua` currently provides.
