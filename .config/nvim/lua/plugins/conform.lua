---@type LazySpec
return {
    "stevearc/conform.nvim",
    lazy = true,
    cmd = "ConformInfo",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            rust = { "rustfmt" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            go = { "gofmt" },
            json = { "jq" },
            javascript = { "prettierd", "prettier" },
            typst = { "typstyle" },
            sh = { "shfmt" },
            bash = { "shfmt" },
        },
        default_format_opts = {
            lsp_format = "fallback",
            stop_after_first = true,
        },
    },
}
