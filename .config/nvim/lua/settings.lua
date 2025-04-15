-- File type detection & syntax highlighting
vim.cmd([[syntax on]])
vim.cmd([[filetype plugin indent on]])

-- Enable true color support
vim.o.termguicolors = true

-- Enable project-specific vimrc
vim.o.exrc = true
vim.o.secure = true

-- No need to be compatible with Vi
vim.o.compatible = false

-- Use 4 spaces for indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Don't highlight search results
vim.o.hlsearch = false

-- Keep the cursor away from the top/bottom edges
vim.o.scrolloff = 5

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Show substitutions live
vim.o.inccommand = "nosplit"

-- Search settings {{{

-- Show search matches live
vim.o.incsearch = true

-- Ignore case (sometimes; see smartcase)
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable RegExp characters
vim.o.magic = true

-- }}}

-- Show matching braces while typing
vim.cmd([[set showmatch mat=3]])
vim.o.showmatch = true
vim.o.mat = 3

-- Detect external changes to open files
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
    command = "checktime",
})

-- Automatically save before certain commands
vim.o.autowrite = true

-- Enable mouse interaction
vim.o.mouse = "a"

-- Search recursively (up to 3 levels deep) for files
vim.opt.path:append({ "**3" })

-- Show current position within file
vim.o.ruler = true

-- Expand wildcards in command line
vim.o.wildmenu = true

-- No bells on error
vim.o.errorbells = false
vim.o.visualbell = false

-- Allow formatting numbered lists
vim.opt.formatoptions:append({ "n" })

-- Don't use two spaces when joining sentences
vim.o.joinspaces = false

-- Show leading/trailing whitespace
vim.o.list = true
vim.o.listchars = "tab:> ,lead:.,trail:·,multispace:.,extends:>,precedes:<,nbsp:~"

-- Highlight trailing whitespace
vim.api.nvim_set_hl(0, "TrailingWhitespace", {
    fg="#2d2a2e",
    bg="#ff6188",
    ctermfg="White",
    ctermbg="LightRed",
})
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew" }, {
    group = vim.api.nvim_create_augroup("my/settings/highlight-trailing-whitespace", { clear = true }),
    callback = function(event)
        -- Don't enable for read-only buffers, e.g. :help
        if not vim.bo[event.buf].modifiable then
            return
        end
        -- Don't enable for floating windows
        if vim.api.nvim_win_get_config(0).relative ~= "" then
            return
        end
        vim.fn.matchadd("TrailingWhitespace", "\\s\\+$")
    end
})

-- Restore position when re-opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("RestoreCursorPosition", { clear = true }),
    callback = function()
        local line = vim.fn["line"]("'\"")
        local lastline = vim.fn["line"]("$")
        local ignore_filetypes = {
            gitcommit = true,
            gitrebase = true,
            xxd = true,
            help = true,
        }
        if (line > 1) and (line <= lastline) and (ignore_filetypes[vim.bo.filetype] == nil) then
            vim.cmd([[normal! g'"]])
        end
    end,
})

-- Open new panes to the bottom/right
vim.o.splitbelow = true
vim.o.splitright = true

-- Treat *.h files as C, not C++
vim.g.c_syntax_for_h = 1

-- Use English dictionary for spell-check
vim.opt.spelllang = { "en" }

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Shorten messages
-- Default is 'ltToOCF'
vim.o.shortmess = 'tToOCF'

-- Highlight cursor line
vim.wo.cursorline = true

-- Disable line wrapping by default
vim.o.wrap = false

-- Use tree-sitter for folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- Don't fold anything by default
vim.o.foldlevel = 100

-- Remove "how to disable mouse" menu item
vim.cmd([[silent! aunmenu PopUp.How-to\ disable\ mouse]])
vim.cmd([[silent! aunmenu PopUp.-1-]])

-- Make cursorcolumn color the same as cursorline
vim.cmd([[highlight! link CursorColumn CursorLine]])

-- Save extra information when creating sessions
vim.opt.sessionoptions:append({ "options" })

-- Set diagnostic display options
K_default_diagnostic_config = {
    severity_sort = true,
    -- Use Neovim v0.11's virtual lines feature for diagnostics.
    -- Shows multiple errors simultaneously rather than just the last one.
    virtual_text = false,
    virtual_lines = true,
}
vim.diagnostic.config(K_default_diagnostic_config)

-- vim: ft=lua sw=4 ts=4 et fdm=marker fmr={{{,}}} foldlevel=2
