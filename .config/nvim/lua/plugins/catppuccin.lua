-- Catppuccin color scheme
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        version = "^2.0.0",
        ---@type CatppuccinOptions
        opts = {
            flavour = "auto",
            transparent_background = false,
            background = {
                light = "latte",
                dark = "macchiato",
            },
            integrations = {
                cmp = true,
                dap = true,
                dap_ui = true,
                dropbar = { enabled = true },
                gitsigns = true,
                mason = true,
                snacks = {
                    enabled = true,
                    indent_scope_color = "overlay0",
                },
                treesitter = true,
            },
            highlight_overrides = {
                all = function(colors)
                    return {
                        LspInlayHint = { bg = colors.none },
                    }
                end,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin-nvim")
        end,
    },
    {
        "kdkasad/bg.nvim",
        lazy = false,
    },
}
