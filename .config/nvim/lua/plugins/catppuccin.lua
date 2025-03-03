-- Catppuccin color scheme
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = {
            flavour = "auto",
            transparent_background = false,
            background = {
                light = "latte",
                dark = "mocha",
            },
            integrations = {
                cmp = true,
                dap = true,
                dap_ui = true,
                dropbar = { enabled = true },
                gitsigns = {
                    enabled = true,
                    transarent = true,
                },
                mason = true,
                snacks = {
                    enabled = true,
                    indent_scope_color = "overlay0",
                },
                treesitter = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "typicode/bg.nvim",
        lazy = false
    },
}
