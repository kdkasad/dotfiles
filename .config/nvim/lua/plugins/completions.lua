return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    -- TODO: Put these in keymap.lua
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    -- { name = 'vsnip' }, -- For vsnip users.
                    -- { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
}
