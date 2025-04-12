local M = {}

-- Uses tree-sitter to find all function definitions in the current (C) file
-- buffer and copy the declaration of each to the unnamed register.
function M.yank_declarations()
	local parser = vim.treesitter.get_parser()
    if parser == nil then
        vim.notify("Failed to get tree-sitter parser", vim.log.levels.ERROR)
        return
    end
    local lang = parser:lang()
    if lang ~= "c" then
        vim.notify("Function definition extraction only works for C files.", vim.log.levels.ERROR)
        return
    end
	local tree = parser:parse(true)[1]
	local query = vim.treesitter.query.parse(lang, "(function_definition) @def")
	local declarations = ""
    local n_declarations = 0
	for id, node, _, _ in query:iter_captures(tree:root(), 0) do
		local name = query.captures[id]
		if name == "def" then
            n_declarations = n_declarations + 1
			local rowstart, colstart, rowend, colend = node:range()
			local body = node:field("body")[1]
			if body then
				local bsr, bsc, _, _ = body:range()
				rowend = bsr
				colend = bsc
				local lines = vim.api.nvim_buf_get_text(0, rowstart, colstart, rowend, colend, {})
				local text = ""
				for _, line in ipairs(lines) do
					local trimmed_line = line:match("^%s*(.-)%s*$")
					text = text .. " " .. trimmed_line
				end
				text = text:match("^%s*(.-)%s*$") .. ";\n"
				declarations = declarations .. text
			end
		end
	end
	vim.fn.setreg("", declarations)
	vim.notify("Copied " .. n_declarations .. " declarations to unnamed register.")
end

---Returns the special border definition for a specific severity
---@param severity "ERROR"|"WARN"|"INFO"|"HINT"
---@return string[][]
local function gen_borders_for_severity(severity)
    local hi_group_map = {
        ["ERROR"] = "DiagnosticFloatingError",
        ["WARN"] = "DiagnosticFloatingWarn",
        ["INFO"] = "DiagnosticFloatingInfo",
        ["HINT"] = "DiagnosticFloatingHint",
    }
    local border_chars = {
        "╭", "─", "╮", "│", "╯", "─", "╰", "│"
    }
    local result = {}
    for _, char in ipairs(border_chars) do
        table.insert(result, { char, hi_group_map[severity] })
    end
    return result
end

---Table of specialized border definitions suitable for `nvim_open_win()`
---@type table<vim.diagnostic.Severity, string[][]>
M.borders_for_severity = {
    [vim.diagnostic.severity.ERROR] = gen_borders_for_severity("ERROR"),
    [vim.diagnostic.severity.WARN] = gen_borders_for_severity("WARN"),
    [vim.diagnostic.severity.INFO] = gen_borders_for_severity("INFO"),
    [vim.diagnostic.severity.HINT] = gen_borders_for_severity("HINT"),
}

return M
