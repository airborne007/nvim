--[[
插件扩展示例文件
展示如何使用扩展机制添加新插件和配置
--]]

local extension = require("core.extension")

-- 添加一个示例扩展
extension.add_extension({
    name = "example_extension",
    description = "这是一个插件扩展示例",
    enabled = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    -- 扩展插件列表
    {
        "tpope/vim-surround",
        keys = {
            "c",
            "d",
            "s",
        },
        description = "快速修改环绕字符的插件",
    },

    -- 配置函数
    config = function()
        -- 这里可以添加扩展的配置代码
        vim.notify("示例扩展已加载", vim.log.levels.INFO)
    end,
})

-- 禁用一个核心插件的示例
extension.disable_plugin("nvim-tree/nvim-tree.lua")

-- 覆盖一个核心插件的配置
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
