-- Tree-sitter (for syntax highlighting & indenting)
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        -- Set up parsers
        local tsconfig = require("nvim-treesitter.configs")
        tsconfig.setup({
            ensure_installed = { "lua", "javascript", "python", "c", "vim", "vimdoc", "html", "css" },
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
