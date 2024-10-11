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

-- No scrolloff for help pages
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.wo.scrolloff = 0
    end,
})

-- Set comment marker for Typst files
-- Use 2-space indentation for Typst files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typst",
    callback = function()
        vim.bo.commentstring = "// %s"
        vim.bo.expandtab = true
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
    end,
})

-- CS 240 indentation rules
vim.api.nvim_create_augroup("CS240Settings", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = "CS240Settings",
    pattern = "*/{CS 240,cs240}/*.{c,h,tex}",
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.bo.expandtab = true
        vim.bo.textwidth = 80
        vim.wo.colorcolumn = "+1"
    end,
})

-- Enable surrounding with dollar signs for LaTeX and Typst.
-- Uses surround.vim. See ":h surround.txt" for details.
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typst", "tex", "plaintex" },
    callback = function()
        -- $ = 36 in ASCII
        vim.b.surround_36 = "$\r$"
    end
})

-- Use hashtags for comments in assembly
vim.api.nvim_create_autocmd("FileType", {
    pattern = "asm",
    callback = function()
        vim.bo.comments = ":#,s1:/*,mb:*,ex:*/,://"
        vim.bo.commentstring = "# %s"
    end
})

-- vim: ft=lua sw=4 ts=4 et fdm=marker fmr={{{,}}} foldlevel=2
