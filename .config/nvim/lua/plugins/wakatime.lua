return {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    enabled = function()
        return vim.uv.fs_stat(os.getenv("HOME") .. "/.wakatime.cfg") ~= nil
    end,
}
