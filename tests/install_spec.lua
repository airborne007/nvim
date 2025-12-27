local system = require("core.git_wrapper").system

describe("install.sh", function()
  it("should exist and be executable", function()
    local code = os.execute("test -x ./install.sh")
    assert.are.equal(0, code)
  end)

  it("should fail on non-Arch systems", function()
    local cmd = "env OS_RELEASE_FILE=tests/fixtures/os-release-ubuntu ./install.sh 2>&1"
    local output = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error
    
    assert.are_not.equal(0, exit_code, "Script should have failed with non-zero exit code. Output: " .. (output or ""))
    assert.matches("intended for Arch Linux", output)
  end)

  it("should succeed on Arch systems", function()
    local cmd = "env DRY_RUN=true OS_RELEASE_FILE=tests/fixtures/os-release-arch ./install.sh 2>&1"
    local output = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error
    
    assert.are.equal(0, exit_code, "Script should have succeeded with exit code 0. Output: " .. (output or ""))
    assert.matches("Detected Arch Linux", output)
  end)

  it("should list packages in DRY_RUN mode on Arch", function()
    local cmd = "env DRY_RUN=true OS_RELEASE_FILE=tests/fixtures/os-release-arch ./install.sh 2>&1"
    local output = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error
    
    assert.are.equal(0, exit_code)
    assert.matches("Installing dependencies", output)
    assert.matches("neovim make gcc ripgrep fd", output)
    assert.matches("go rustup python nodejs npm", output)
    assert.matches("python%-pynvim xclip", output)
  end)

  it("should backup existing config and link new one", function()
    local temp_home = vim.fn.tempname()
    vim.fn.mkdir(temp_home .. "/.config/nvim", "p")
    vim.fn.mkdir(temp_home .. "/bin", "p")
    
    -- Mock yay
    local yay_mock = temp_home .. "/bin/yay"
    local f_yay = io.open(yay_mock, "w")
    f_yay:write("#!/bin/sh\necho 'mock yay' $@")
    f_yay:close()
    os.execute("chmod +x " .. yay_mock)

    local existing_file = temp_home .. "/.config/nvim/init.lua"
    local f = io.open(existing_file, "w")
    f:write("-- existing config")
    f:close()

    local nvim_config_dir = temp_home .. "/.config/nvim"
    local path = temp_home .. "/bin:" .. os.getenv("PATH")
    local cmd = string.format("PATH='%s' NVIM_CONFIG_DIR='%s' OS_RELEASE_FILE=tests/fixtures/os-release-arch ./install.sh 2>&1", path, nvim_config_dir)
    
    local output = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error
    
    assert.are.equal(0, exit_code, "Script failed: " .. output)
    assert.matches("Backing up existing configuration", output)
    assert.matches("Linking configuration", output)

    -- Verify backup exists
    local backup_count = 0
    local p = io.popen("ls " .. temp_home .. "/.config/")
    for file in p:lines() do
      if file:match("nvim%.bak_") then
        backup_count = backup_count + 1
      end
    end
    p:close()
    assert.are.equal(1, backup_count)

    -- Verify link exists
    local link_target = vim.fn.resolve(nvim_config_dir)
    -- link_target should be the current working directory
    local cwd = vim.fn.getcwd()
    assert.are.equal(cwd, link_target)
  end)
end)
