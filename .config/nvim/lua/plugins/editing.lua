return {
    -- surround.vim: For editing surrounding quotes/braces
    { "tpope/vim-surround" },

    -- commentary.vim: For commenting
    { "tpope/vim-commentary" },

    -- abolish.vim: For helpful substitution commands
    { "tpope/vim-abolish" },

    -- vim-indent-object: Motions for selecting lines at the same indentation level
    { "michaeljsmith/vim-indent-object" },

    -- vim-easy-align: For aligning columns
    { "junegunn/vim-easy-align" },

    -- mini.ai: More text objects
    {
        "echasnovski/mini.ai",
        version = "*",
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        config = function(_, opts)
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
                    s = ts('statement'),
                },
            })
        end
    },
}
