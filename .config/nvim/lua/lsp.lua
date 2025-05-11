-- Limit the number of threads clangd will use on Purdue CS servers
if vim.fn.hostname():find(".cs.purdue.edu", 1, true) ~= nil then
    vim.lsp.config('clangd', {
        cmd = { "clangd", "-j", "8", "--query-driver=/usr/bin/clang++" }
    })
end

-- Configure LuaLS to recognize Neovim globals.
-- Taken from https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (
                vim.uv.fs_stat(path .. "/.luarc.json")
                or vim.uv.fs_stat(path .. "/.luarc.jsonc")
            )
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                -- Faster but doesn't include plugin configs
                -- library = {
                --     vim.env.VIMRUNTIME,
                --     -- Depending on the usage, you might want to add additional paths here.
                --     -- "${3rd}/luv/library"
                --     -- "${3rd}/busted/library",
                -- },
                library = vim.api.nvim_get_runtime_file("", true),
            },
        })
    end,
    settings = {
        Lua = {},
    },
})
