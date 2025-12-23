describe("uninstall.sh", function()
  it("should exist and be executable", function()
    local code = os.execute("test -x ./uninstall.sh")
    assert.are.equal(0, code)
  end)

  it("should remove config and data directories when YES_TO_ALL=true", function()
    local temp_home = vim.fn.tempname()
    local config_dir = temp_home .. "/.config/nvim"
    local share_dir = temp_home .. "/.local/share/nvim"
    local state_dir = temp_home .. "/.local/state/nvim"
    local cache_dir = temp_home .. "/.cache/nvim"
    
    vim.fn.mkdir(config_dir, "p")
    vim.fn.mkdir(share_dir, "p")
    vim.fn.mkdir(state_dir, "p")
    vim.fn.mkdir(cache_dir, "p")
    
    -- Create dummy files
    local f = io.open(config_dir .. "/init.lua", "w")
    f:write("-- test")
    f:close()
    
    local cmd = string.format(
      "env YES_TO_ALL=true NVIM_CONFIG_DIR='%s' NVIM_SHARE_DIR='%s' NVIM_STATE_DIR='%s' NVIM_CACHE_DIR='%s' ./uninstall.sh 2>&1",
      config_dir, share_dir, state_dir, cache_dir
    )
    
    local output = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error
    
    assert.are.equal(0, exit_code, "Script failed: " .. output)
    assert.matches("Removing " .. config_dir, output)
    assert.matches("Removing " .. share_dir, output)
    
    -- Verify directories are gone
    assert.are.equal(0, vim.fn.isdirectory(config_dir))
    assert.are.equal(0, vim.fn.isdirectory(share_dir))
    assert.are.equal(0, vim.fn.isdirectory(state_dir))
    assert.are.equal(0, vim.fn.isdirectory(cache_dir))
  end)
end)
