vim.g.rustaceanvim = {
    server = {
        default_settings = {
            ["rust-analyzer"] = {
                check = {
                    command = "clippy",
                }
            }
        }
    }
}

return {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    lazy = true,
    event = "VeryLazy",
}
