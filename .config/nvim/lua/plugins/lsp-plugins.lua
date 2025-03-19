local ensure_installed_lsps = {
    "lua_ls",
    "clangd",
    "texlab",
    "jedi_language_server",
    "tinymist",
    "rust_analyzer",
    "gopls",
    "ansiblels",
}

return {
    -- Mason: package manager for LSPs & more
    {
        "williamboman/mason.nvim",
        config = true,
        opts = {
            ui = { border = "rounded" },
        },
    },

    -- Mason-lspconfig: Bridge between Mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            -- lspconfig: LSP configurator
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = ensure_installed_lsps,
        },
        config = function(_, opts)
            local default_lsp_opts = {
                on_attach = function()
                    vim.diagnostic.config({ severity_sort = true })
                end,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            }

            require("mason-lspconfig").setup(opts)
            require("mason-lspconfig").setup_handlers({
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function(server_name)
                    require("lspconfig")[server_name].setup(default_lsp_opts)
                end,

                -- Custom setup for clangd to set worker count
                ["clangd"] = function()
                    local clangd_cmd = { "clangd" }
                    if vim.fn.hostname():find(".cs.purdue.edu", 1, true) ~= nil then
                        clangd_cmd = { "clangd", "-j", "8" }
                    end
                    local clangd_opts = vim.tbl_extend('force', default_lsp_opts, {
                        cmd = clangd_cmd,
                    })
                    require("lspconfig").clangd.setup(clangd_opts)
                end,

                -- Configure LuaLS to recognize Neovim globals.
                -- Taken from https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
                ["lua_ls"] = function()
                    local luals_opts = vim.tbl_extend('force', default_lsp_opts, {
                        on_init = function(client)
                            if client.workspace_folders then
                                local path = client.workspace_folders[1].name
                                vim.print(path)
                                if
                                    path ~= vim.fn.stdpath("config")
                                    and (
                                        vim.uv.fs_stat(path .. "/.luarc.json")
                                        or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                                    )
                                then
                                    return
                                end
                            end

                            client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                                runtime = {
                                    -- Tell the language server which version of Lua you're using
                                    -- (most likely LuaJIT in the case of Neovim)
                                    version = "LuaJIT",
                                },
                                -- Make the server aware of Neovim runtime files
                                workspace = {
                                    checkThirdParty = false,
                                    -- Faster but doesn't include plugin configs
                                    -- library = {
                                    --     vim.env.VIMRUNTIME,
                                    --     -- Depending on the usage, you might want to add additional paths here.
                                    --     -- "${3rd}/luv/library"
                                    --     -- "${3rd}/busted/library",
                                    -- },
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                            })
                        end,
                        settings = {
                            Lua = {},
                        },
                    })
                    require("lspconfig").lua_ls.setup(luals_opts)
                end,

                ["rust_analyzer"] = function()
                    -- Don't set up rust-analyzer.
                    -- Rustaceanvim will do that for us.
                end
            })
        end,
    },

    -- None-LS: Wraps non-LSP tools for use in Neovim
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        main = "null-ls",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- Stylua - formatter for Lua (install via Mason)
                    null_ls.builtins.formatting.stylua,

                    -- Code actions from refactoring library (installed as plugin below)
                    null_ls.builtins.code_actions.refactoring,

                    -- Ansible-Lint
                    null_ls.builtins.diagnostics.ansiblelint,

                    -- Typstfmt
                    null_ls.builtins.formatting.typstfmt,
                },
            })

            -- Load CS 240 linter source if on a Purdue server
            if vim.fn.hostname():find(".cs.purdue.edu", 1, true) then
                require("eastwood-source")
            end
        end,
    },

    -- Refactoring library
    {
        "ThePrimeagen/refactoring.nvim",
        lazy = true,
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = true,
    },
}
