-- Plugins for dealing with images

---@type LazySpec[]
return {
    {
        "HakonHarnes/img-clip.nvim",
        lazy = true,
        cmd = { "PasteImage", "ImgClipDebug", "ImgClipConfig" },
        opts = {
            default = {
                dir_path = "",
                relative_to_current_file = true,
            },
        },
    },
}
