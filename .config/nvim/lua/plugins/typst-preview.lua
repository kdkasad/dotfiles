return {
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "1.*",
        config = true,
        opts = {
            -- Use tinymist installed by Mason
            dependencies_bin = {
                ["tinymist"] = nil,
            },
        },
    },
}
