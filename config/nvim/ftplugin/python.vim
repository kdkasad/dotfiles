setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal smartindent

nmap <leader>r <cmd>split \| terminal python %<cr>

" Set folding settings
setlocal foldmethod=indent

" Auto-format code
autocmd BufWritePost <buffer> silent call jobstart(['autopep8', '--in-place', '--aggressive', '--aggressive', expand('%')])
