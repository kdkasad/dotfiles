-- Auto-correct "ture" and "treu" to "true"
vim.keymap.set("ia", "ture", "true")
vim.keymap.set("ia", "treu", "true")

-- Auto-correct "deatil(s)" to "detail(s)"
vim.keymap.set("ia", "deatil", "detail")
vim.keymap.set("ia", "deatils", "details")

-- Easy C-style comments
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "java", "yacc" },
    callback = function()
        vim.keymap.set("ia", "com", "/* */<left><left><left>", {
            buffer = 0,
        })
    end,
})

-- Problem format for MA 351 homework
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typst" },
    callback = function()
        vim.keymap.set(
            "ia",
            "linprob",
            [[
<c-o>:set paste
#import "../../khw.typ": problem, parts

#problem(
  name: "Exercise",
  number: false,
  newpage: true,
)[]

<++><c-o>:set nopaste
<c-o>?Exercise?e+
]],
            { buffer = 0 }
        )
    end,
})
