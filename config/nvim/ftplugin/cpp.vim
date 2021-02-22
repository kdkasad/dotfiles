" Sets the compiler
compiler gcc

" Extra completion
set tags+=~/.local/share/systags_c

" Snippets:
iabbrev imain int main(int argc, char *argv[])<cr>{<CR><++>;<CR>return 0;<CR>}<C-o>?<++>;<CR><C-o>df;
iabbrev com /* */<Esc>2hi
