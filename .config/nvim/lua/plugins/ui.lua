return {
    -- Display notifications and LSP progress messages in the bottom right corner
    {
        "j-hui/fidget.nvim",
        lazy = true,
        cmd = "Fidget",
        event = "LspAttach",
        opts = {},
    },

    -- Smear cursor
    {
        "sphamba/smear-cursor.nvim",
        lazy = true,
        event = "VeryLazy",
        opts = {
            smear_insert_mode = false,
            vertical_bar_cursor_insert_mode = true,
            horizontal_bar_cursor_replace_mode = true,
            smear_to_cmd = false,
        },
    },

    -- Breadcrumbs bar
    {
        "Bekaboo/dropbar.nvim",
        event = LazyFile,
        config = function()
            local dropbar_api = require("dropbar.api")
            vim.keymap.set("n", "<leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
            vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
            vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
        end,
    },

    -- folke's snacks
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- Pretty input UI
            input = { enabled = true },
            -- Smooth scrolling
            scroll = { enabled = true, animate = { easing = "outCubic" } },
            -- Indentation guides
            indent = { enabled = true },
            -- Pretty notifications
            notifier = { enabled = true },
            -- Dim inactive scopes
            dim = { enabled = true },
            -- Pickers
            picker = {
                enabled = true,
                sources = {
                    explorer = {
                        jump = { close = true },
                        win = {
                            list = {
                                keys = {
                                    ["<c-t>"] = { "tab", mode = { "n", "i" } },
                                },
                            },
                        },
                        hidden = true,
                    },
                    lsp_symbols = {
                        filter = {
                            default = true,
                        },
                    },
                    lsp_references = {
                        include_current = true,
                        include_declaration = true,
                    },
                    notifications = {
                        win = {
                            preview = { wo = { wrap = true }, },
                        },
                    },
                },
            },
            -- File explorer
            explorer = { enabled = true, replace_netrw = true },
            -- Open files quickly
            quickfile = { enabled = true },
            -- Styles
            styles = {
                notification = { wo = { wrap = true } },
                notification_history = { wo = { wrap = true } },
                dashboard = {
                    wo = {
                        winhighlight = "Normal:SnacksDashboardNormal,NormalFloat:SnacksDashboardNormal,TrailingWhitespace:Normal",
                    }
                }
            },
            -- Image support via Kitty protocol
            image = {
                enabled = true,
                -- Render TeX/Typst math in-editor
                math = {
                    enabled = false,
                },
                -- Convert PDFs to higher-resolution PNGs
                convert = {
                    magick = {
                        pdf = { "-density", 300, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
                    }
                }
            },
            -- Dashboard
            dashboard = {
                enabled = true,
            },
        },
    },

    -- Improvements for quickfix list
    {
        "stevearc/quicker.nvim",
        ft = { "qf" },
        -- Lazily load plugin on these keybindings
        keys = {
            {
                "<leader>q",
                function()
                    require("quicker").toggle()
                end,
                desc = "Toggle quickfix list",
            },
        },
        opts = {
            keys = {
                {
                    ">",
                    function()
                        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = "Expand quickfix context",
                },
                {
                    "<",
                    function()
                        require("quicker").collapse()
                    end,
                    desc = "Collapse quickfix context",
                },
            },
        },
    },
}
