-- Auto-correct "ture" and "treu" to "true"
vim.keymap.set("ia", "ture", "true")
vim.keymap.set("ia", "treu", "true")

-- Easy C-style comments
vim.keymap.set("ia", "com", "/* */<left><left><left>")
