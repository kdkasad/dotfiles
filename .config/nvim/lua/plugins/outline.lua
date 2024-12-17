-- Code symbol outline
return {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
        { "|", "<cmd>Outline<cr>", desc = "Toggle symbol outline" },
    },
    opts = {
        -- Your setup opts here
    },
}
