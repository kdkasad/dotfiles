return {
    -- Tree-sitter (for syntax highlighting & indenting)
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
    },
}
