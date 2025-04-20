-- which-key: Plugin to help remember your keymap
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    ---@type wk.Opts
    opts = {
        preset = "helix",
        -- Specify names for mapping groups
        spec = {
            { "<leader>u", group = "UI settings" },
            { "<leader>f", group = "Find things" },
            { "<leader>g", group = "Run/view tests" },
            { "<leader>h", group = "Git hunk actions" },
            { "<leader>d", group = "Debugging" },
            { "<leader>k", group = "Kian's custom actions" },
            { "<leader>r", group = "Refactor" },
            { "<leader>t", group = "Terminals/tabs" },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
