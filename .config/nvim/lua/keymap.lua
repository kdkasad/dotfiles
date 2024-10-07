-- Neo-tree (file browser)
vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal left<CR>")
vim.keymap.set("n", "<C-e>", ":Neotree filesystem reveal left toggle<CR>")

-- Telescope (searching & finding)
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", telescope_builtin.find_files)
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files)
vim.keymap.set("n", "<leader>fg", telescope_builtin.git_files)
vim.keymap.set("n", "<leader>ft", telescope_builtin.live_grep)
vim.keymap.set("v", "<leader>ft", telescope_builtin.grep_string)
vim.keymap.set("n", "<leader>fs", telescope_builtin.treesitter)

-- Easily toggle cursor line
vim.keymap.set("n", "<leader>cl", ":set cursorline!<CR>")

-- Allow capital versions of :w, :q, :wq
vim.api.nvim_create_user_command("W", "w", { desc = "Same as :w" })
vim.api.nvim_create_user_command("Q", "q", { desc = "Same as :q" })
vim.api.nvim_create_user_command("Wa", "wa", { desc = "Same as :wa" })
vim.api.nvim_create_user_command("WA", "wa", { desc = "Same as :wa" })
vim.api.nvim_create_user_command("Wq", "wq", { desc = "Same as :wq" })
vim.api.nvim_create_user_command("WQ", "wq", { desc = "Same as :wq" })
vim.api.nvim_create_user_command("Wqa", "wqa", { desc = "Same as :wqa" })
vim.api.nvim_create_user_command("WQa", "wqa", { desc = "Same as :wqa" })

-- Make Y yank to the end of the line
vim.keymap.set("n", "Y", "y$")

-- Shortcuts to save or quit
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Split pane resizing
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>")

-- Split pane navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Jump markers
vim.keymap.set("i", "<S-Tab><S-Tab>", '<Esc>/<++><CR>"_cf>')
vim.keymap.set("n", "<S-Tab><S-Tab>", '/<++><CR>"_cf>')
vim.keymap.set("i", "<C-S-Tab><C-S-Tab>", '<Esc>?<++><CR>"_cf>')
vim.keymap.set("n", "<C-S-Tab><C-S-Tab>", '?<++><CR>"_cf>')

-- Toggle line wrapping
vim.keymap.set("n", "<leader>wr", "<cmd>set wrap!<cr>")

-- Toggle whitespace visibility
vim.keymap.set("n", "<leader>ws", "<cmd>set list!<cr>")

-- Toggle spell check
vim.keymap.set("n", "<leader>s", "<cmd>set spell!<cr>")

-- Turn off search highlighting
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<cr>")

-- Move visual selection
vim.keymap.set("v", "K", "<cmd>m '<-2<cr>gv=gv")
vim.keymap.set("v", "J", "<cmd>m '>+1<cr>gv=gv")

-- Easy shortcut for norm
vim.keymap.set("v", ".", ":norm ")

-- Save using ZW
vim.keymap.set("n", "ZW", "<cmd>w<cr>")

-- Surround character with spaces
vim.keymap.set("n", "<leader><space>", "i <esc>la <esc>h")

-- Open terminals
vim.keymap.set("n", "<leader>ts", "<cmd>split | terminal<cr>")
vim.keymap.set("n", "<leader>tv", "<cmd>vsplit | terminal<cr>")
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew | terminal<cr>")

-- LSP keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeybindings", { clear = true }),
    callback = function(env)
        -- Set omnifunc
        vim.bo[env.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Keybindings
        local opts = { buffer = env.buf }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)

        -- Jump to diagnostics
        local genGotoDiag = function(direction, level)
            local func
            if direction == "next" then
                func = vim.diagnostic.goto_next
            else
                func = vim.diagnostic.goto_prev
            end
            return function()
                func({ severity = vim.diagnostic.severity[level] })
            end
        end
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]e", genGotoDiag("next", "ERROR"), opts)
        vim.keymap.set("n", "[e", genGotoDiag("prev", "ERROR"), opts)
        vim.keymap.set("n", "]w", genGotoDiag("next", "WARN"), opts)
        vim.keymap.set("n", "[w", genGotoDiag("prev", "WARN"), opts)
        vim.keymap.set("n", "]h", genGotoDiag("next", "HINT"), opts)
        vim.keymap.set("n", "[h", genGotoDiag("prev", "HINT"), opts)
    end,
})

-- DAP keybindings
local dap = require("dap")
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)

-- vim-easy-align keybindings
vim.keymap.set({ "n", "v" }, "ga", "<Plug>(EasyAlign)")

-- Tab navigation
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>")
vim.keymap.set("n", "]t", "gt")
vim.keymap.set("n", "[t", "gT")

-- NOTE: Completion keybindings are in plugins/completions.lua.

-- vim: ft=lua sw=4 ts=4 et fdm=marker fmr={{{,}}} foldlevel=2
