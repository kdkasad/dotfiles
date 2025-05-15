-- Version for mason.nvim and mason-lspconfig.nvim
local mason_version = "^2.0.0"

---@type LazySpec[]
return {
    -- Mason: package manager for LSPs & more
    {
        "mason-org/mason.nvim",
        version = mason_version,
        event = "VeryLazy",
        cmd = "Mason",
        opts = {
            ui = { border = "rounded" },
        },
    },

    -- Mason-lspconfig: Bridge between Mason and lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        version = mason_version,
        dependencies = {
            "mason-org/mason.nvim",
            -- lspconfig: LSP configurator
            "neovim/nvim-lspconfig",
        },
        event = LazyFile,
        opts = {
            automatic_enable = {
                exclude = { "rust_analyzer" },
            },
        },
    },

    -- None-LS: Wraps non-LSP tools for use in Neovim
    {
        "nvimtools/none-ls.nvim",
        event = LazyFile,
        main = "null-ls",
        config = function()
            local null_ls = require("null-ls")
            local opts = {
                sources = {
                    -- Ansible-Lint
                    null_ls.builtins.diagnostics.ansiblelint,
                },
            }

            -- Proselint
            if require("mason-registry").is_installed("proselint") then
                -- Enable Proselint in Typst files
                table.insert(null_ls.builtins.diagnostics.proselint.filetypes, "typst")
                table.insert(null_ls.builtins.code_actions.proselint.filetypes, "typst")

                table.insert(opts.sources, null_ls.builtins.diagnostics.proselint)
                table.insert(opts.sources, null_ls.builtins.code_actions.proselint)
            end

            null_ls.setup(opts)

            -- Load CS 240 linter source if on a Purdue server
            if vim.fn.hostname():find(".cs.purdue.edu", 1, true) then
                vim.schedule_wrap(require)("eastwood-source")
            end
        end,
    },

    -- Refactoring library
    {
        "ThePrimeagen/refactoring.nvim",
        lazy = true,
        cmd = "Refactor",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            -- Prompt for return type
            prompt_func_return_type = {
                go = true,
                cpp = true,
                c = true,
                java = true,
            },
            -- Prompt for function parameters
            prompt_func_param_type = {
                go = true,
                cpp = true,
                c = true,
                java = true,
            },
            print_var_statements = {
                -- Change C printf-based statement to use jump marker to easily fill in format specifier
                c = {
                    'fprintf(stderr, "%s %%<++>", %s);',
                },
            },
        },
    },

    -- nvim-lsp-endhints: Display inlay hints at the end of the line
    {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        opts = {},
    },

    -- lsp_signature: Better function signature display
    {
        "ray-x/lsp_signature.nvim",
        lazy = true,
        opts = {
            bind = true,
            handler_opts = {
                border = "rounded",
            },
        },
    },
}
