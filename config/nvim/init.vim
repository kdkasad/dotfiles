"""""""""""""""""""""""""""""
"  PLUGINS (via vim-plug)   "
"""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugins')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'gerw/vim-HiLinkTrace'
Plug 'udalov/kotlin-vim'
Plug 'kdkasad/vim-deadkeys'
Plug 'junegunn/goyo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'neovim/nvim-lsp'
Plug 'junegunn/fzf.vim'
Plug 'nfnty/vim-nftables'

call plug#end()


"""""""""""""""""""""""""""""
"       FZF SETTINGS        "
"""""""""""""""""""""""""""""

let g:fzf_layout = {
			\ 'window': {
				\'width': 0.9,
				\'height': 0.6
			\ }
		\ }


"""""""""""""""""""""""""""""
"  GENERAL EDITOR SETTINGS  "
"""""""""""""""""""""""""""""

" Enable project-specific .vimrc
set exrc
set secure

" No need to be compatible with Vi
set nocompatible

" Always chdir to the working file
set autochdir

" S/R highlighing for neovim
if has('nvim')
	set inccommand=nosplit
endif

" Syntax highlighting
syntax on

" Autocomplete/ctags options
set omnifunc=syntaxcomplete#Complete
set tags+=./tags;/

" Line numbers
set number

" Highlight current line
set cursorline

" Relative line numbers
set relativenumber

" Automatically save before certain commands
set autowrite

" Hide buffers when they are abandoned
set hidden

" Show partial commands
set showcmd

" Enable plugins
filetype plugin indent on

" Automatically read files when changed externally
set autoread
autocmd FocusGained,BufEnter * checktime

" Map :W and :Q commands to :w and :q
command! W w
command! Q q
command! Wq wq
command! WQ wq
command! Wqa wqa
command! WQa wqa
command! Wqall wqall

" Make Y behave like D/C
nnoremap Y y$

" Automatic scrolling past cursor
set so=10

" Enable tab completion in command-line
set wildmenu

" Include all subdirectories in path
set path+=**

" Always show current position
set ruler

" Don't show mode in command bar
set noshowmode

" Tab settings
set tabstop=4
set shiftwidth=4
set noexpandtab
set autoindent

" Line wrap options
set linebreak

"" SEARCH OPTIONS:
" Show possible matches while searching
set incsearch
" Settings for case-sensitivity when searching
set ignorecase
set smartcase
" Enable RegExp magic
set magic

" Highlight matching braces
set showmatch
set mat=3

" No bells on error
set noerrorbells
set novisualbell

" File encoding settings
set encoding=utf8
set ffs=unix,dos,mac

" Return to last editing position when opening file
au BufReadPost *
	 \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	 \ |   exe "normal! g`\""
	 \ | endif


"""""""""""""""""""""""""""""
"          COLORS!          "
"""""""""""""""""""""""""""""

" Color scheme
set background=dark
colorscheme pink_forest
let g:lightline = { 'colorscheme': 'pink_line', }
" Disable Background Color Erase (BCE) which caused some errors
if &term =~ '256color'
	set t_ut=
endif


"""""""""""""""""""""""""""""
"      LANGUAGE SERVERS     "
"""""""""""""""""""""""""""""

lua << END
	require'nvim_lsp'.bashls.setup{}
	require'nvim_lsp'.ccls.setup{}
	require'nvim_lsp'.cssls.setup{}
	require'nvim_lsp'.html.setup{}
	require'nvim_lsp'.vimls.setup{}
END

" Keep sign column visible for files with LSP
augroup autosigncol
au Filetype sh setlocal signcolumn=yes							" Bash
au BufEnter *.sh setlocal signcolumn=yes						" Bash
au BufEnter *.c,*.cpp*.objc,*.objcpp setlocal signcolumn=yes	" C/C++
au BufEnter *.css,*.scss,*.less setlocal signcolumn=yes			" CSS
au BufEnter *.html setlocal signcolumn=yes						" HTML
au BufEnter *.vim setlocal signcolumn=yes						" Vimscript
augroup end

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>



"""""""""""""""""""""""""""""
"   CODE FOLDING SETTINGS   "
"""""""""""""""""""""""""""""

" Code folding settings
set foldmethod=syntax
set nofoldenable
set foldlevel=10
set foldnestmax=10
let g:vimsyn_folding = 'af'

" View settings
set viewoptions-=options
augroup AutoView
	au BufWinLeave * silent! mkview!
	au BufWinEnter * silent! loadview
augroup end


"""""""""""""""""""""""""""""
"      SPLIT SETTINGS       "
"""""""""""""""""""""""""""""
set splitbelow
set splitright
" Split resizing
nnoremap <C-Up> :resize +2<CR> 
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize +2<CR>
nnoremap <C-Right> :vertical resize -2<CR>
" Moving between split windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"""""""""""""""""""""""""""""
"   FILE TYPE PREFERENCES   "
"""""""""""""""""""""""""""""

" Use groff, not troff or nroff
au Filetype nroff setlocal ft=groff
au Filetype troff setlocal ft=groff

" Detect systemd services
au BufRead *.service setlocal ft=systemd


"""""""""""""""""""""""""""""
"        TEMPLATES          "
"""""""""""""""""""""""""""""

" groff_ms MLA format
iabbrev mladoc <C-o>:read ~/.config/nvim/templates/mla.ms<cr>


"""""""""""""""""""""""""""""
"   SPELL-CHECK SETTINGS    "
"""""""""""""""""""""""""""""
" Auto-enable spellcheck for some filetypes
augroup spellcheck
au Filetype markdown setlocal spell
au Filetype html setlocal spell
au Filetype gitcommit setlocal spell
au Filetype tex setlocal spell
au Filetype plaintex setlocal spell
au Filetype groff setlocal spell
au Filetype mail setlocal spell
augroup end

" Enable french dictionary
set spelllang=en,fr


"""""""""""""""""""""""""""""
"   SPECIAL FILE COMMANDS   "
"""""""""""""""""""""""""""""
augroup specialfiles

" reload config files
au BufWritePost ~/.config/keymap !pkill -x xbindkeys -HUP
au BufWritePost ~/.config/picom/picom.conf !pkill -x picom && picom -b
au BufWritePost ~/.config/dunst/dunstrc !pkill -x dunst && setsid dunst

" shellcheck
au Filetype sh map <buffer> <leader>s :sp \| te shellcheck --color=always %<cr>
au Filetype sh map <buffer> <leader>vs :vs \| te shellcheck --color=always %<cr>

" check bashisms
au Filetype sh map <buffer> <leader>bs :sp \| te checkbashisms %<cr>
au Filetype sh map <buffer> <leader>vbs :vs \| te checkbashisms %<cr>

" compile *roff documents
au Filetype groff,nroff,troff map <buffer> <leader>c :!compiledoc %<cr>
au Filetype groff,nroff,troff map <buffer> <leader>pdf :exe "silent !setsid zathura ".expand('%:r').".pdf"<cr>

" reload xresources
au BufWritePost ~/.config/xresources !xrdb -load %

" Email editing (mutt)
au BufRead /tmp/{mutt,neomutt}-* setfiletype mail

augroup end


"""""""""""""""""""""""""""""
"    KEYBOARD SHORTCUTS     "
"""""""""""""""""""""""""""""

" Leader key
let mapleader = ','

" redo
nmap <leader>r <cmd>redo<cr>

" Get off my lawn
map <up> :echoe "this is vim"<cr>
map <down> :echoe "this is vim"<cr>
map <left> :echoe "this is vim"<cr>
map <right> :echoe "this is vim"<cr>

" Set keymap timeout length
set timeoutlen=700

" Jump to next <++> using double S-Tab
inoremap <S-Tab><S-Tab> <Esc>/<++><CR>"_cf>
nnoremap <S-Tab><S-Tab> /<++><CR>"_cf>
inoremap <C-S-Tab><C-S-Tab> <Esc>?<++><CR>"_cf>
nnoremap <C-S-Tab><C-S-Tab> ?<++><CR>"_cf>

" Use [Enter] to select item in autocomplete menu
imap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
imap <expr> <down> pumvisible() ? "\<c-n>" : "\<down>"
imap <expr> <up> pumvisible() ? "\<c-p>" : "\<up>"

" Tab manipulation shortcuts
noremap <Leader>tn :tabnew<CR>
noremap <Leader>tt :tab split<CR>
noremap ]t :tabn<CR>
noremap [t :tabp<CR>
noremap <Leader>tc :tabc<CR>

" open a terminal
nnoremap <leader>tm :sp\|terminal<cr>
nnoremap <leader>tv :vs\|terminal<cr>

" toggle line wrapping
nnoremap <leader>w :set wrap!<cr>

" toggle spell check
nnoremap <leader>s :set spell!<cr>

" toggle deadkeys
nmap <leader>dk <plug>DeadKeysToggle

" toggle goyo
nmap <leader>g :Goyo \| colo pink_forest<cr>

" turn of search highlighting
nmap <leader>nh <cmd>nohlsearch<cr>

" Generate ctags
nmap <leader>gt !ctags --recurse=yes --tag-relative=yes --exclude=.git .
" make project
nnoremap <leader>mm <cmd>sp \| te bear make<cr>
nmap <leader>m <leader>mm
nnoremap <leader>mv <cmd>vs \| te bear make<cr>

" Close split
nmap <leader>wc <C-w>c

" Move visual selection
vnoremap K :m '<-2<cr>gv=gv
vnoremap J :m '>+1<cr>gv=gv

" fzf
nmap <leader>ff :Files<cr>
nmap <leader>fg :BLines<cr>
