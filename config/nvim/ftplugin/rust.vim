" Snippets:
iabbrev com /* */<Esc>2hi

" Auto-format code
autocmd BufWritePost <buffer> silent call jobstart(['cargo', 'fmt'])

" Run program/tests
nmap <buffer> <leader>r <cmd>wa \| split \| terminal cargo run<cr>G
nmap <buffer> <leader>t <cmd>wa \| split \| terminal cargo test<cr>G

" Use cargo as build command
set makeprg=cargo
