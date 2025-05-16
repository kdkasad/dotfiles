---@type LazySpec[]
return {
    -- surround.vim: For editing surrounding quotes/braces
    {
        "tpope/vim-surround",
        lazy = true,
        keys = {
            "ys",
            "cs",
            "ds",
            { "S", mode = "v" },
        },
    },

    -- abolish.vim: For helpful substitution commands
    {
        "tpope/vim-abolish",
        lazy = true,
        cmd = { "S", "Subvert", "Abolish" },
    },

    -- vim-indent-object: Motions for selecting lines at the same indentation level
    {
        "michaeljsmith/vim-indent-object",
        lazy = true,
        keys = {
            { "ai", mode = "v" },
            { "ii", mode = "v" },
            { "aI", mode = "v" },
            { "iI", mode = "v" },
        },
    },

    -- vim-easy-align: For aligning columns
    {
        "junegunn/vim-easy-align",
        lazy = true,
        keys = {
            "ga",
        },
        cmd = "EasyAlign",
    },

    -- mini.ai: More text objects
    {
        "echasnovski/mini.ai",
        version = "*",
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        lazy = true,
        keys = {
            { "a", mode = { "x", "o" }, },
            { "i", mode = { "x", "o" }, },
        },
        config = function()
            local miniai = require('mini.ai')
            local ts = function(name)
                return miniai.gen_spec.treesitter({
                    a = '@' .. name .. '.outer',
                    i = '@' .. name .. '.inner',
                })
            end
            miniai.setup({
                custom_textobjects = {
                    a = ts('parameter'),
                    f = ts('call'),
                    d = ts('function'),
                    -- s = ts('statement'),
                    l = ts('loop'),
                },
            })
        end
    },

    -- mini.pairs: Autopairs
    {
        "echasnovski/mini.pairs",
        -- Loading this on InsertEnter caused problems with the snacks picker
        -- and nvim-cmp, because nvim-cmp needs mini.pairs' <cr> mapping to be
        -- present when it is loaded in order to use it as the fallback
        -- function. But when the Snacks picker is opened before entering insert
        -- mode, it will enter insert mode in the picker and register the <cr>
        -- buffer-local mapping, causing that to be used instead of mini.pairs'
        -- <cr> mapping.
        event = "VeryLazy",
        config = true,
    },
}
