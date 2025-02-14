-- Auto-correct typos
vim.keymap.set("ia", "ture", "true")
vim.keymap.set("ia", "treu", "true")
vim.keymap.set("ia", "deatil", "detail")
vim.keymap.set("ia", "deatils", "details")
vim.keymap.set("ia", "recieve", "receive")
vim.keymap.set("ia", "recieved", "received")
vim.keymap.set("ia", "reciever", "receiver")


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
            "341prob",
            [[
<c-o>:set paste
#import "../../khw.typ": *

#problem(number: "")[
  <++>
]

<++><c-o>:set nopaste
<c-o>?number: "?e+
]],
            { buffer = 0 }
        )
    end,
})
