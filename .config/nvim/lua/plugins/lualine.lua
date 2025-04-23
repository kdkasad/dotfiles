---@type LazySpec[]
return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "catppuccin",
                section_separators = "",
                component_separators = "",
            },
        },
    },
    -- Required for lualine
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
}
