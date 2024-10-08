-- List of parsers to install
local ensure_installed_parsers = {
    "lua",
    "javascript",
    "python",
    "c",
    "vim",
    "vimdoc",
    "html",
    "css",
    "make",
    "bash",
}

-- Tree-sitter (for syntax highlighting & indenting)
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "VimEnter",
    build = ":TSUpdate",
    config = function()
        -- Set up parsers
        local tsconfig = require("nvim-treesitter.configs")
        tsconfig.setup({
            ensure_installed = ensure_installed_parsers,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
