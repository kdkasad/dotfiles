"""""""""""""""""""""""""""""
"  PLUGINS (via vim-plug)   "
"""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugins')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'michaeljsmith/vim-indent-object'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf.vim'
Plug 'nfnty/vim-nftables'
Plug 'ghifarit53/sonokai'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-startify'
Plug 'roryokane/detectindent'

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
"set autochdir

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

" Change window title to filename
set title
set titlestring=vim\ -\ %f\ %m

" Enable mouse interaction
set mouse=a

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

" Make Y yank to end of line
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
let g:detectindent_preferred_expandtab = 0
let g:detectindent_preferred_indent = 4
let g:detectindent_min_indent = 2
let g:detectindent_max_indent = 8
autocmd BufReadPost,BufNewFile * DetectIndent

" Line wrap options
set linebreak

"" SEARCH OPTIONS:

" Don't highlight search results
set nohlsearch

" Show possible matches while searching
set incsearch

" Settings for case-sensitivity when searching
set ignorecase smartcase

" Enable RegExp magic
set magic

" Highlight matching braces
set showmatch mat=3

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
set termguicolors

let g:sonokai_style = 'shusia'
let g:sonokai_transparent_background = 1
let g:sonokai_enable_italic = 1
let g:sonokai_menu_selection_background = 'blue'
colorscheme sonokai

" Lightline settings
let g:lightline = {
	\ 'colorscheme': 'sonokai',
	\ 'active': {
	\	'left': [
	\		[ 'mode', 'paste' ],
	\		[ 'readonly', 'filename', 'modified', 'cocstatus' ]
	\	]
	\ },
	\ 'component_function': {
	\	'cocstatus': 'coc#status',
	\	'currentfunction': 'CocCurrentFunction',
	\ },
\ }


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
au Filetype nroff,troff setlocal ft=groff

" Detect systemd services
au BufRead *.service setlocal ft=systemd

" Treat PKGBUILDs as sh syntax
au BufRead,BufCreate PKGBUILD setlocal ft=sh


"""""""""""""""""""""""""""""
"        TEMPLATES          "
"""""""""""""""""""""""""""""

" groff_ms MLA format
iabbrev mladoc <C-o>:read ~/.config/nvim/templates/mla.ms<cr>


"""""""""""""""""""""""""""""
"   SPELL-CHECK SETTINGS    "
"""""""""""""""""""""""""""""
"
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
au BufWritePost ~/.config/xbindkeysrc !pkill -x xbindkeys -HUP
au BufWritePost ~/.config/picom/picom.conf !pkill -x picom; picom -b
au BufWritePost ~/.config/dunst/dunstrc !pkill -x dunst ; setsid dunst

" shellcheck
au Filetype sh map <buffer> <leader>s :sp \| te shellcheck --color=always %<cr>
au Filetype sh map <buffer> <leader>vs :vs \| te shellcheck --color=always %<cr>

" check bashisms
au Filetype sh map <buffer> <leader>bs :sp \| te checkbashisms %<cr>
au Filetype sh map <buffer> <leader>vbs :vs \| te checkbashisms %<cr>

" reload xresources
au BufWritePost ~/.config/xresources !xrdb -load %

" Email editing (mutt)
au BufRead /tmp/{mutt,neomutt}-* setfiletype mail

augroup end

" compile *roff documents
augroup groffcomp
	au Filetype groff,nroff,troff nnoremap <buffer> <leader>cp <cmd>silent !compiledoc %<cr>
	au Filetype groff,nroff,troff nnoremap <buffer> <leader>ecp <cmd>autocmd groffcomp BufWritePost <buffer> silent !compiledoc %<cr>
	au Filetype groff,nroff,troff nnoremap <buffer> <leader>dcp <cmd>autocmd! groffcomp BufWritePost <buffer><cr>
	au Filetype groff,nroff,troff nnoremap <buffer> <leader>pdf :exe "silent !setsid zathura ".expand('%:r').".pdf"<cr>
augroup end


"""""""""""""""""""""""""""""
"       BINARY FILES        "
"""""""""""""""""""""""""""""

" Add autocmds to edit binary files as hex using xxd(1)
function <SID>AddHexAutoCmds()
	augroup hexedit
		au!
		au BufReadPost  <buffer> exe "%!xxd" | set ft=xxd
		au BufWritePre  <buffer> exe "%!xxd -r"
		au BufWritePost <buffer> exe "%!xxd" | set nomod
	augroup end
endfunction

" Load autocmds when opening a file in binary mode
autocmd BufReadPre * if &binary | call <SID>AddHexAutoCmds() | endif


"""""""""""""""""""""""""""""
"    KEYBOARD SHORTCUTS     "
"""""""""""""""""""""""""""""

" Leader key
let mapleader = ','

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
nmap <leader>go <cmd>Goyo<cr>

" turn off search highlighting
nmap <leader>nh <cmd>nohlsearch<cr>

" make project
nnoremap <leader>mm <cmd>sp \| te bear -- make<cr>
nnoremap <leader>m ,mm
nnoremap <leader>mv <cmd>vs \| te bear -- make<cr>

" Close split
nmap <leader>wc <C-w>c

" Move visual selection
vnoremap K :m '<-2<cr>gv=gv
vnoremap J :m '>+1<cr>gv=gv

" fzf
nmap <leader>ff :Files<cr>
nmap <leader>fg :BLines<cr>

" visual to norm shortcut
vnoremap . :norm 

" save using ZW
nnoremap ZW <cmd>w<cr>

" CoC Mappings
inoremap <silent><expr> <c-space> coc#refresh()
nmap <c-]> <plug>(coc-definition)
nmap <leader>gd	<plug>(coc-definition)
nmap <leader>gD	<plug>(coc-declaration)
nmap <leader>gy	<plug>(coc-type-definition)
nmap <leader>gi	<plug>(coc-implementation)
nmap <leader>gr	<plug>(coc-references)
nmap <leader>r	<plug>(coc-refactor)
nmap <leader>fm	<plug>(coc-format)
vmap <leader>fm	<plug>(coc-format-selected)
nmap ]e	<plug>(coc-diagnostic-next-error)
nmap [e	<plug>(coc-diagnostic-prev-error)
nnoremap <leader>cr <cmd>CocRestart<cr>
nnoremap <leader>cd <cmd>CocDisable<cr>
nnoremap <leader>ce <cmd>CocEnable<cr>
inoremap <m-cr> <esc>f,2lct,
inoremap <s-cr> <esc>f,2lct)

" Lorem Ipsum generator
function Lipsum(paragraphs)
	exe "r !gzip -dc $HOME/.local/share/lipsum.txt.gz | head -n" . a:paragraphs . " | sed 's/$/\\n/; s/\\. /.\\n/g'"
endfunction
