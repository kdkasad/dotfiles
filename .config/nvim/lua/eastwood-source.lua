--
-- Gets diagnostics from eastwood-tidy linter.
-- This file is loaded by the plugin config for null-ls.
--

local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local eastwood_source = {
    name = "eastwood",
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "c", "cpp", "objc", "objcpp" },
    generator = helpers.generator_factory({
        command = "/homes/cs240/bin/linter",
        args = { "$FILENAME" },
        to_stdin = false, -- clang-tidy doesn't accept code on stdin
        to_temp_file = true, -- Create a temporary file with the buffer's contents
        format = "line", -- Call on_output() for each line of output
        ignore_stderr = true, -- Ignore "NN warnings generated."
        on_output = helpers.diagnostics.from_patterns({
            {
                pattern = "^([^:]+):(%d+):(%d+): (%w+): (.+) %[([^%]]+)%]$",
                groups = { "file", "row", "col", "severity", "message", "code" },
            },
            overrides = {
                severities = {
                    note = helpers.diagnostics.severities.hint,
                },
            },
        }),
        check_exit_code = { 0, 1 }, -- Valid exit codes
    }),
}

null_ls.register(eastwood_source)
