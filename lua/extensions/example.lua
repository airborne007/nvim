--[[
Plugin extension example file
Demonstrates how to use the extension mechanism to add new plugins and configurations
--]]

local extension = require("core.extension")

-- Add an example extension
extension.add_extension({
    name = "example_extension",
    description = "This is a plugin extension example",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    -- Extension plugin list
    {
        "tpope/vim-surround",
        keys = {
            "c",
            "d",
            "s",
        },
        description = "Plugin for quickly modifying surrounding characters",
    },

    -- Configuration function
    config = function()
        -- You can add extension configuration code here
        vim.notify("Example extension loaded", vim.log.levels.INFO)
    end,
})

-- Example of disabling a core plugin
extension.disable_plugin("nvim-tree/nvim-tree.lua")

-- Example of overriding a core plugin's configuration
extension.override_plugin_config("nvim-lualine/lualine.nvim", function(plugin)
    plugin.opts = {
        theme = "onedark",
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
    }
    return plugin
end)

return {}