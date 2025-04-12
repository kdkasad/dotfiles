-- Custom functions which use Snacks.toggle() to provide nice UI for
-- toggling the virtual_text and virtual_lines diagnostics handlers.

return {
    ---Snacks.toggle() class for the virtual_lines diagnostic handler
    virtual_lines = Snacks.toggle({
        name = "expanded diagnostic display",
        get = function()
            return not not vim.diagnostic.config().virtual_lines
        end,
        set = function(state)
            vim.diagnostic.config({ virtual_lines = state })
        end,
    }),

    ---Snacks.toggle() class for the virtual_text diagnostic handler
    virtual_text = Snacks.toggle({
        name = "in-line diagnostic display",
        get = function()
            return not not vim.diagnostic.config().virtual_text
        end,
        set = function(state)
            vim.diagnostic.config({ virtual_text = state })
        end,
    }),
}
