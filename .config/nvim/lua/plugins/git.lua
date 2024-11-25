-- Git-related plugins
return {
    -- Git status signs
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gitsigns = require("gitsigns")

                    local function map(mode, l, r, description)
                        local opts = {
                            buffer = bufnr,
                            desc = description,
                        }
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gitsigns.nav_hunk("next")
                        end
                    end, 'Jump to next changed hunk')

                    map("n", "[c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gitsigns.nav_hunk("prev")
                        end
                    end, 'Jump to previous changed hunk')

                    -- Actions
                    map("n", "<leader>hs", gitsigns.stage_hunk, 'Stage current hunk')
                    map("n", "<leader>hr", gitsigns.reset_hunk, 'Reset current hunk')
                    map("v", "<leader>hs", function()
                        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, 'Stage selected lines')
                    map("v", "<leader>hr", function()
                        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, 'Reset selected lines')
                    map("n", "<leader>hS", gitsigns.stage_buffer, 'Stage current file')
                    map("n", "<leader>hu", gitsigns.undo_stage_hunk, 'Undo stage hunk operation')
                    map("n", "<leader>hR", gitsigns.reset_buffer, 'Reset current file')
                    map("n", "<leader>hp", gitsigns.preview_hunk, 'Preview hunk in floating window')
                    map("n", "<leader>hb", function()
                        gitsigns.blame_line({ full = true })
                    end, 'Blame line')
                    map("n", "<leader>tb", gitsigns.toggle_current_line_blame, 'Toggle current-line blame')
                    map("n", "<leader>hd", gitsigns.diffthis, 'Open (from index) diff in diff editor')
                    map("n", "<leader>hD", function()
                        gitsigns.diffthis("~")
                    end, 'Open diff (from last commit) in diff editor')
                    map("n", "<leader>td", gitsigns.toggle_deleted, 'Toggle displaying deleted hunks')

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", 'Select Git hunk text object')
                end,
            })
        end,
    },
}
