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
vim.o.scrolloff = 0

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
vim.cmd([[
    highlight TrailingWhitespace ctermfg=White ctermbg=LightRed guifg=#2d2a2e guibg=#ff6188
    match TrailingWhitespace /\s\+$/
]])

-- Restore position when re-opening files
vim.api.nvim_create_augroup("RestoreCursor", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = "RestoreCursor",
    callback = function()
        local line = vim.fn["line"]({ "'\"" })
        local lastline = vim.fn["line"]({ "$" })
        if (line > 1) and (line <= lastline) and (vim.o.filetype ~= "gitcommit") then
            vim.cmd.normal("g'\"")
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
-- vim: ft=lua sw=4 ts=4 et fdm=marker fmr={{{,}}} foldlevel=2
