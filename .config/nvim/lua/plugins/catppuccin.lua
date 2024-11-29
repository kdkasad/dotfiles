-- Catppuccin color scheme
return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = {
            flavour = auto,
            transparent_background = false,
            background = {
                light = "latte",
                dark = "mocha",
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
