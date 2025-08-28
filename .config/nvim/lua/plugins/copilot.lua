---@type LazySpec[]
return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = {
                auto_trigger = true,
            },
        },
        cond = function()
            -- This plugin requires Node.js
            if vim.fn.exepath("node") == "" then
                return false
            end

            -- Don't run on Purdue servers
            if vim.fn.hostname():find(".cs.purdue.edu", 1, true) ~= nil then
                return false
            end
        end,
        config = function(_, opts)
            require("copilot").setup(opts)
            local cs = require("copilot.suggestion")

            -- Keybinding to accept Copilot suggestion if visible, else perform regular tab
            vim.keymap.set("i", "<Tab>", function()
                if cs.is_visible() then
                    cs.accept()
                else
                    return "<Tab>"
                end
            end, { expr = true, desc = "Accept Copilot suggestion if visible" })

            -- Snacks.toggle module for toggling Copilot
            local copilot_enabled = true
            Snacks.toggle({
                name = "GitHub Copilot",
                get = function()
                    return copilot_enabled
                end,
                set = function(new)
                    if new ~= copilot_enabled then
                        cs.toggle_auto_trigger()
                        copilot_enabled = new
                    end
                end,
            }):map("<leader>ac")
            require("copilot.suggestion").toggle_auto_trigger()
        end,
    },
}
