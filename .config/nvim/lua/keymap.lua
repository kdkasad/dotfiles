-- NOTE: Completion keybindings are in plugins/completions.lua.
-- NOTE: Git hunk-editing keymaps are defined in plugins/git.lua.

-- Neo-tree (file browser)
vim.keymap.set("n", "<leader>e", function() Snacks.explorer.reveal() end, { desc = "Open file browser" })
vim.keymap.set("n", "<C-e>", function() Snacks.explorer() end, { desc = "Toggle file browser" })
vim.keymap.set("n", "\\", function() Snacks.explorer() end, { desc = "Toggle file browser" })

-- Function to add a Snacks.picker mapping
local function snackmap(lhs, func, desc, pickeropts)
    vim.keymap.set("n", lhs, function() Snacks.picker[func](pickeropts or {}) end, { desc = desc })
end

-- Search files
snackmap("<leader>ff",  "files",                 "Search files")
snackmap("<leader>fr",  "recent",                "Search recent files")
snackmap("<leader>fb",  "buffers",               "Search open buffers")
snackmap("<leader>ft",  "grep",                  "Search for text (live grep)")
snackmap("<leader>f:",  "command_history",       "Search command history")
snackmap("<leader>fn",  "notifications",         "Search notification history")
snackmap("<leader>fp",  "projects",              "Search projects")
snackmap("<leader>fc",  "files",                 "Search Neovim configuration files", { cwd = vim.fn.stdpath("config") })
snackmap("<leader>fh",  "help",                  "Search Neovim help pages")

-- Search Git
snackmap("<leader>fgf", "git_files",             "Search Git-tracked files")
snackmap("<leader>fgb", "git_branches",          "Search Git branches")
snackmap("<leader>fgl", "git_log",               "Search Git log")
snackmap("<leader>fgF", "git_log_file",          "Search Git log file")
snackmap("<leader>fgL", "git_log_line",          "Search Git log line")
snackmap("<leader>fgs", "git_status",            "Search Git status")
snackmap("<leader>fgS", "git_stash",             "Search Git stash")
snackmap("<leader>fgd", "git_diff",              "Search Git diff (hunks)")

-- Neotest keybindings
-- Output
vim.keymap.set("n", "<leader>gs", function() require("neotest").summary.toggle() end, { desc = "Toggle test summary panel" })
vim.keymap.set("n", "<leader>go", function() require("neotest").output.open({ enter = true, last_run = true }) end, { desc = "View last test's output" })
vim.keymap.set("n", "<leader>gpo", function() require("neotest").output_panel.open() end, { desc = "Open test output stream" })
vim.keymap.set("n", "<leader>gpt", function() require("neotest").output_panel.toggle() end, { desc = "Toggle test output stream" })
vim.keymap.set("n", "<leader>gpc", function() require("neotest").output_panel.clear() end, { desc = "Clear test output stream" })
-- Run
vim.keymap.set("n", "<leader>grr", function() require("neotest").run.run() end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>grf", function() require("neotest").run.run(vim.fn.expand("%")) end, { desc = "Run current file's tests" })
vim.keymap.set("n", "<leader>grs", function() require("neotest").run.run({ suite = true }) end, { desc = "Run entire test suite" })
-- Watch
vim.keymap.set("n", "<leader>gwr", function() require("neotest").watch.toggle() end, { desc = "Toggle watch for nearest test" })
vim.keymap.set("n", "<leader>gwf", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, { desc = "Toggle watch for current file" })
vim.keymap.set("n", "<leader>gws", function() require("neotest").watch.toggle({ suite = true }) end, { desc = "Toggle watch for entire test suite" })
-- Stop
vim.keymap.set("n", "<leader>gc", function() require("neotest").run.stop({ interactive = true }) end, { desc = "Stop test" })

-- Easily toggle cursor line
vim.keymap.set("n", "<leader>cl", ":set cursorline!<CR>")

-- Toggle scope dimming
Snacks.toggle.dim():map("<leader>ud")

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
-- vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Same as :w" })
vim.keymap.set("n", "<leader>ww", ":w<CR>", { desc = "Same as :w" })
-- vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Same as :q" })

-- Split pane resizing
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Make pane taller" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Make pane shorter" })
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", { desc = "Make pane thinner" })
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Make pane wider" })

-- Split pane navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to pane on left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to pane below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to pane above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to pane on right" })

-- Jump markers
local jmopts = { desc = "Jump to next <++> marker" }
vim.keymap.set("i", "<S-Tab><S-Tab>", '<Esc>/<++><CR>"_cgn', jmopts)
vim.keymap.set("n", "<S-Tab><S-Tab>", '/<++><CR>"_cgn', jmopts)
vim.keymap.set("i", "<C-S-Tab><C-S-Tab>", '<Esc>?<++><CR>"_cgn', jmopts)
vim.keymap.set("n", "<C-S-Tab><C-S-Tab>", '?<++><CR>"_cgn', jmopts)

-- Toggle line wrapping
vim.keymap.set("n", "<leader>wr", "<cmd>set wrap!<cr>", { desc = "Toggle line wrapping" })

-- Toggle whitespace visibility
vim.keymap.set("n", "<leader>ws", "<cmd>set list!<cr>", { desc = "Toggle whitespace visibility" })

-- Toggle spell check
vim.keymap.set("n", "<leader>s", "<cmd>set spell!<cr>", { desc = "Toggle spell check" })

-- Clear search highlighting
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<cr>", { desc = "Clear search highlighting" })
vim.keymap.set("n", "<leader>uh", "<cmd>set hlsearch!<cr>", { desc = "Toggle search highlighting" })

-- Move visual selection
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move selected lines up" })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move selected lines down" })

-- Easy shortcut for norm
vim.keymap.set("v", ".", ":norm ", { desc = "Start :norm command" })

-- Save using ZW
vim.keymap.set("n", "ZW", "<cmd>w<cr>", { desc = "Save file" })

-- Surround character with spaces
vim.keymap.set("n", "<leader><space>", "i <esc>la <esc>h", { desc = "Surround character with spaces" })

-- Open terminals
vim.keymap.set("n", "<leader>ts", "<cmd>split | terminal<cr>", { desc = "Open terminal in horizontal split" })
vim.keymap.set("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", { desc = "Open terminal in vertical split" })
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew | terminal<cr>", { desc = "Open terminal in new tab" })

-- LSP keybindings
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspKeybindings", { clear = true }),
    callback = function(env)
        -- Don't enable LSP keybindings in :help buffers
        if vim.bo[env.buf].filetype == "help" then
            return
        end

        -- Set omnifunc
        vim.bo[env.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Keybindings
        local map = function(lhs, rhs, desc)
            vim.keymap.set({ "n", "v" }, lhs, rhs, { buffer = env.buf, desc = desc })
        end
        -- Don't set this one for visual mode because it conflicts with the shift up keybind
        vim.keymap.set("n", "K",
            function() vim.lsp.buf.hover({ border = 'rounded' }) end,
            { buffer = env.buf, desc = "View hover documentation" }
        )
        vim.keymap.set("i", "<C-k>",
            function() vim.lsp.buf.signature_help({ border = 'rounded', close_events = { "InsertLeave" } }) end,
            { buffer = env.buf, desc = "View function signature help" }
        )
        map("gd", function() Snacks.picker.lsp_definitions()      end, "Find definition")
        map("gD", function() Snacks.picker.lsp_declarations()     end, "Find declaration")
        map("gy", function() Snacks.picker.lsp_type_definitions() end, "Find type definition")
        map("gr", function() Snacks.picker.lsp_references()       end, "Find references")
        map("<leader>fs", function() Snacks.picker.lsp_symbols() end, "Search LSP symbols")
        map("<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, "Search LSP workspace symbols")
        map("<leader>fe", function() Snacks.picker.diagnostics_buffer() end, "Search buffer diagnostics")
        map("<leader>fE", function() Snacks.picker.diagnostics() end, "Search diagnostics")
        map("<leader>ra", vim.lsp.buf.code_action, "Perform code action")
        map("<leader>rf", vim.lsp.buf.format, "Format code")
        map("<leader>rr", vim.lsp.buf.rename, "Rename symbol")

        ---Returns a function which, when called, jumps to the next/previous diagnostic of the given severity level.
        ---@param count number 1 for forward or -1 for backward
        ---@param level string|nil Name of a key in vim.diagnostic.severity representing the severity of diagnostics to filter for when jumping
        ---@return function
        local genGotoDiag = function(count, level)
            return function()
                vim.diagnostic.jump({
                    count = count,
                    severity = level and vim.diagnostic.severity[level],
                    float = {
                        source = true,
                        border = 'rounded',
                        scope = 'cursor',
                    },
                })
            end
        end
        ---Returns a function which, when called, jumps to the next/previous highest-priority diagnostic available.
        ---@param direction number 1 to jump forward, -1 to jump backward
        ---@return function
        local function genGotoNextHighPriority(direction)
            return function()
                for _, severity in ipairs(vim.diagnostic.severity) do
                    local result = vim.diagnostic.jump({
                        count = direction,
                        severity = severity,
                        float = {
                            source = true,
                            border = 'rounded',
                            scope = 'cursor',
                        },
                    })
                    if result then
                        break
                    end
                end
            end
        end
        map("]d", genGotoDiag(1, nil), "Go to next diagnostic")
        map("[d", genGotoDiag(-1, nil), "Go to previous diagnostic")
        map("]e", genGotoNextHighPriority(1), "Go to next highest-priority diagnostic")
        map("[e", genGotoNextHighPriority(-1), "Go to previous highest-priority diagnostic")
        map("]w", genGotoDiag(1, "WARN"), "Go to next warning")
        map("[w", genGotoDiag(-1, "WARN"), "Go to previous warning")
        map("]h", genGotoDiag(1, "HINT"), "Go to next hint")
        map("[h", genGotoDiag(-1, "HINT"), "Go to previous hint")
    end,
})

-- DAP keybindings
local dap = require("dap")
vim.keymap.set({ "n", "v" }, "<leader>db", dap.toggle_breakpoint, { desc = "Set breakpoint on current line" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue execution or start new debugging session" })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step out" })
vim.keymap.set("n", "<leader>dl", dap.step_over, { desc = "Re-run last configuration" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })

-- vim-easy-align keybindings
vim.keymap.set({ "n", "v" }, "ga", "<Plug>(EasyAlign)", { desc = "Enter EasyAlign" })

-- Tab navigation
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Create new tab" })
vim.keymap.set("n", "]t", "gt", { desc = "Move to next tab" })
vim.keymap.set("n", "[t", "gT", { desc = "Move to previous tab" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", "<cmd>tabnew<cr>", { desc = "Create new buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Move to next tab" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Move to previous tab" })

-- Quickfix list navigation
vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>", { desc = "Open quickfix list" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix entry" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix entry" })

-- Yank/paste to/from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Shorter command to launch Typst preview
vim.api.nvim_create_user_command("TP", "TypstPreview", { desc = "Same as :TypstPreview" })

-- Evaluate selected expression
vim.keymap.set("v", "<leader>=", 'c<c-r>=<c-r>"<cr><esc>')

-- Reverse selected text
vim.keymap.set("v", "<leader>rv", 'c<c-r>=reverse(@")<cr><esc>')

-- Use Ctrl+B as Ctrl+A, as Ctrl+A is used as the nested tmux prefix and thus will send Ctrl+B
vim.keymap.set("", "<c-b>", "<c-a>")

-- Use '*' key to surround with C-style comments
vim.g.surround_42 = "/* \r */"

-- Scroll buffer with Alt+k/j
vim.keymap.set("n", "<M-k>", "<c-y>")
vim.keymap.set("n", "<M-j>", "<c-e>")
vim.keymap.set("n", "<M-K>", "<c-u>")
vim.keymap.set("n", "<M-J>", "<c-d>")

-- Extract function declarations
vim.keymap.set("n", "<leader>kd", function()
    require("kian").yank_declarations()
end, { desc = "Generate function declarations for the current file" })

-- Toggle virtual_lines and virtual_text diagnostic display modes
vim.keymap.set("n", "<leader>ul", function()
    local virtual_lines = vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = not virtual_lines })
end, { desc = "Toggle expanded diagnostic display" })
vim.keymap.set("n", "<leader>ut", function()
    local virtual_text = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not virtual_text })
end, { desc = "Toggle in-line diagnostic display" })
vim.keymap.set("n", "<leader>uu", function()
    vim.diagnostic.config(K_default_diagnostic_config)
end, { desc = "Reset to default diagnostic display" })

-- Bindings for refactoring.nvim
vim.keymap.set({ "x", "n" }, "<leader>rv", function()
    require("refactoring").debug.print_var()
end, { desc = "Inspect variable" })
vim.keymap.set({ "x", "n" }, "<leader>rp", function()
    require("refactoring").select_refactor()
end, { desc = "Open refactoring menu" })

-- vim: ft=lua sw=4 ts=4 et fdm=marker fmr={{{,}}} foldlevel=2
