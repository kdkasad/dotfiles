-- Use tabs for Makefiles
vim.api.nvim_create_autocmd("FileType", {
    pattern = "make",
    callback = function()
        vim.o.expandtab = false
    end,
})

-- Automatically format paragraphs,
-- but not comments in emails
vim.api.nvim_create_autocmd("FileType", {
    pattern = "mail",
    command = "setlocal formatoptions-=ro",
})

-- Allow formatting comments, but not code in various code filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "sh", "java", "python", "conf" },
    command = "setlocal formatoptions-=t",
})

-- Autocommands to edit binary files as hex using xxd(1)
vim.api.nvim_create_autocmd("BufReadPre", {
    callback = function()
        if vim.bo.binary then
            vim.api.nvim_create_autocmd("BufReadPost", {
                buffer = 0,
                callback = function()
                    vim.cmd([[%!xxd -groupsize 1]])
                    vim.bo.filetype = "xxd"
                end,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = 0,
                callback = function()
                    vim.cmd([[%!xxd -revert -groupsize 1]])
                end,
            })
            vim.api.nvim_create_autocmd("BufWritePost", {
                buffer = 0,
                callback = function()
                    vim.cmd([[%!xxd -groupsize 1]])
                    vim.bo.modified = false
                end,
            })
        end
    end,
})

-- vim: ft=lua sw=4 ts=4 et fdm=marker fmr={{{,}}} foldlevel=2
