" Snippets:
iabbrev com /* */<Esc>2hi

" Auto-format code
autocmd BufWritePost <buffer> silent call jobstart(['cargo', 'fmt'])

" Run program
nmap <buffer> <leader>r :<c-u>wa \| split \| terminal cargo run<cr>
