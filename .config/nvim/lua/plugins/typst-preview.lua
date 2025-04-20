return {
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "1.*",
        opts = {
            -- Use tinymist installed by Mason
            dependencies_bin = {
                ["tinymist"] = nil,
            },
        },
    },
}
