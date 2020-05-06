setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab
setlocal smartindent

command RunSelf !./%
command RunPython !python3 %

nmap <S-F10> :RunPython<CR>
imap <S-F10> <C-o>:RunPython<CR>
