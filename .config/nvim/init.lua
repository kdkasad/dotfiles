-- Load Vim settings/options
pcall(function()
    require("settings")
end)

-- Load plugins (using lazy.nvim) {{{
pcall(function()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
                { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
                { out,                            "WarningMsg" },
                { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazypath)
    require("lazy").setup({
        spec = {
            { import = "plugins" },
        },
        ui = {
            border = "rounded",
        },
    })
end)
-- }}}

-- Load keybindings
pcall(function()
    require("keymap")
end)

-- Load filetype-specific settings
pcall(function()
    require("filetype")
end)

-- Load snippets
pcall(function()
    require("snippets")
end)

-- vim: ft=lua sw=4 ts=4 et fdm=marker fmr={{{,}}} foldlevel=2
