local ensure_installed_lsps = {
    "lua_ls",
    "clangd",
    "texlab",
    "jedi_language_server",
    "tinymist",
    "rust_analyzer",
    "gopls",
}

local gen_null_ls_sources = function(null_ls)
    return {
        -- Stylua - formatter for Lua (install via Mason)
        null_ls.builtins.formatting.stylua,

        -- Code actions from refactoring library (installed as plugin below)
        null_ls.builtins.code_actions.refactoring,

        -- Ansible-Lint
        null_ls.builtins.diagnostics.ansiblelint,

        -- Typstfmt
        null_ls.builtins.formatting.typstfmt,
    }
end

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
            "neovim/nvim-lspconfig" ,
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
                    if string.find(vim.fn.hostname(), ".cs.purdue.edu", 1, true) ~= nil then
                        clangd_cmd = { "clangd", "-j", "8" }
                    end
                    local clangd_opts = { cmd = clangd_cmd }
                    for k, v in pairs(default_lsp_opts) do
                        clangd_opts[k] = v
                    end
                    require("lspconfig").clangd.setup(clangd_opts)
                end,
            })
        end,
    },

    -- None-LS: Wraps non-LSP tools for use in Neovim
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = gen_null_ls_sources(null_ls),
            })
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
