local mock = require('luassert.mock')
local stub = require('luassert.stub')

describe('Git Wrapper', function()
  local git_wrapper
  local snacks_mock
  local vim_mock

  before_each(function()
    -- Stub specific vim functions
    stub(vim.fn, 'mode')
    stub(vim.fn, 'expand')
    -- Check if function exists before stubbing to avoid errors if api is incomplete in headless
    if vim.api.nvim_buf_get_name then
        stub(vim.api, 'nvim_buf_get_name')
    else
        vim.api.nvim_buf_get_name = stub()
    end
    stub(vim, 'notify')

    -- Mock Snacks global
    snacks_mock = {
      picker = {
        git_log = stub(),
        git_log_line = stub()
      }
    }
    _G.Snacks = snacks_mock

    -- Reload the module
    package.loaded['core.git_wrapper'] = nil
    git_wrapper = require('core.git_wrapper')
  end)

  after_each(function()
    -- Revert stubs
    if vim.fn.mode.revert then vim.fn.mode:revert() end
    if vim.fn.expand.revert then vim.fn.expand:revert() end
    if vim.api.nvim_buf_get_name.revert then vim.api.nvim_buf_get_name:revert() end
    if vim.notify.revert then vim.notify:revert() end
    
    _G.Snacks = nil
  end)

  it('should call snacks.picker.git_log in normal mode', function()
    vim.fn.mode.returns('n')
    vim.fn.expand.returns('/path/to/file')

    git_wrapper.smart_git_history()

    assert.stub(snacks_mock.picker.git_log).was_called()
    assert.stub(snacks_mock.picker.git_log_line).was_not_called()
  end)

  it('should call snacks.picker.git_log_line in visual mode', function()
    vim.fn.mode.returns('v')
    vim.fn.expand.returns('/path/to/file')

    git_wrapper.smart_git_history()

    assert.stub(snacks_mock.picker.git_log_line).was_called()
    assert.stub(snacks_mock.picker.git_log).was_not_called()
  end)

  it('should call snacks.picker.git_log_line in visual line mode', function()
    vim.fn.mode.returns('V')
    vim.fn.expand.returns('/path/to/file')

    git_wrapper.smart_git_history()

    assert.stub(snacks_mock.picker.git_log_line).was_called()
    assert.stub(snacks_mock.picker.git_log).was_not_called()
  end)
end)
