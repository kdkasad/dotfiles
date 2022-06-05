" Neovim init.vim
" By Kian Kasad

" PLUGINS {{{1

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
Plug 'sainnhe/sonokai'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'mhinz/vim-startify'
Plug 'roryokane/detectindent'
Plug 'junegunn/vim-easy-align'
Plug 'Gavinok/vim-troff'
Plug 'majutsushi/tagbar'
Plug 'editorconfig/editorconfig-vim'
Plug 'KSP-KOS/EditorTools', { 'rtp': 'VIM/vim-kerboscript' }
Plug 'mattn/emmet-vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v2.x' }
Plug 'kdkasad/vim-colemak'

call plug#end()


" PLUGIN SETTINGS {{{1
"
" TREE-SITTER PARSERS {{{2

command! TSInstallAll TSInstall
			\ json
			\ vim
			\ bash
			\ html
			\ go
			\ glsl
			\ toml
			\ make
			\ http
			\ c
			\ help
			\ dockerfile
			\ javascript
			\ rust
			\ yaml
			\ latex
			\ python
			\ bibtex
			\ typescript
			\ regex
			\ php
			\ java
			\ kotlin
			\ css


" FZF SETTINGS {{{2

let g:fzf_layout = {
			\ 'window': {
				\'width': 0.9,
				\'height': 0.6
			\ }
		\ }


" NEOTREE SETTINGS {{{2

lua require('config-neotree')


" GENERAL EDITOR SETTINGS {{{1

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

" Enable filetype-based plugins and indenting
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
"let g:detectindent_preferred_expandtab = 0
"let g:detectindent_preferred_indent = 4
"let g:detectindent_min_indent = 2
"let g:detectindent_max_indent = 8
"autocmd BufReadPost,BufNewFile * DetectIndent
set ts=8 sw=8 sts=-1 noet

" Line wrap options
set linebreak

" Use syntax-based folding
set foldmethod=syntax
set foldlevelstart=99

"" SEARCH OPTIONS {{{2

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

"" 2}}}

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

" Allow formatting numbered lists
set formatoptions+=n

" Don't use two spaces when joining sentences
set nojoinspaces

" Allow concealing with syntax highlighting
set conceallevel=2

" Show leading/trailing whitespace characters
set list
set listchars=tab:>\ ,lead:.,trail:·,extends:>,precedes:<,nbsp:·

function! s:goyo_enter()
	set nocursorline
	set nolist
endfunction

function! s:goyo_leave()
	set cursorline
	set list
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" SESSION SETTINGS {{{1

" Automatically update currently-loaded session when leaving it
let g:startify_session_persistence = 1

" Automatically delete buffers when closing a session
let g:startify_session_delete_buffers = 1

" Exclude remote EditorConfig files
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" COLORS {{{1

" Color scheme
set background=dark
if has('termguicolors')
	set termguicolors
endif

let g:sonokai_style = 'shusia'
let g:sonokai_transparent_background = 1
let g:sonokai_enable_italic = 1
let g:sonokai_menu_selection_background = 'blue'
let g:sonokai_spell_foreground = 'colored'
let g:sonokai_current_word = 'bold'
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_diagnostic_virtual_text = 'colored'
let g:sonokai_better_performannce = 1
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

" Highlight trailing whitespace
highlight TrailingWhitespace ctermfg=235 ctermbg=203 guifg=#2d2a2e guibg=#ff6188
match TrailingWhitespace /\s\+$/


" SPLIT SETTINGS {{{1

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

" FILE TYPE PREFERENCES {{{1

" Detect systemd services
au BufRead *.service setlocal ft=systemd

" Treat PKGBUILDs as sh syntax
au BufRead,BufCreate PKGBUILD setlocal ft=sh

" Treat *.h files as C
let g:c_syntax_for_h = 1

" TEMPLATES {{{1

" groff_ms MLA format
iabbrev mladoc <C-o>:read ~/.config/nvim/templates/mla.ms<cr>

" SPELL-CHECK SETTINGS {{{1

" Auto-enable spellcheck for some filetypes
au FileType markdown,html,gitcommit,tex,plaintex,nroff,mail setlocal spell

" Use telescope to pick spellcheck suggestions
nnoremap <silent> z= <cmd>Telescope spell_suggest<cr>

" Enable English and French dictionaries
set spelllang=en,fr


" FILE-SPECIFIC COMMANDS {{{1

augroup specialfiles

" reload config files
au BufWritePost ~/.config/xbindkeysrc !pkill -x xbindkeys -HUP
au BufWritePost ~/.config/picom/picom.conf !pkill -x picom; picom -b
au BufWritePost ~/.config/dunst/dunstrc !pkill -x dunst ; setsid dunst

" shellcheck
au FileType sh nmap <buffer> <leader>hs :sp \| te shellcheck --color=always %<cr>
au FileType sh nmap <buffer> <leader>vs :vs \| te shellcheck --color=always %<cr>

" reload xresources
au BufWritePost ~/.config/xresources !xrdb -load %

" Use mail filetype when editing Mutt/Neomutt files
au BufRead /tmp/{mutt,neomutt}-* setfiletype mail

" Automatically format paragraphs, but not comments in emails and *roff files
au FileType mail setlocal formatoptions-=ro

" Allow formatting comments, but not code in various code filetypes
au FileType c,cpp,sh,java,python,conf setlocal formatoptions-=t

augroup end

" compile *roff documents
augroup groffcomp
	au FileType nroff,troff nnoremap <buffer> <leader>cp <cmd>silent !compiledoc % &<cr>
	au FileType nroff,troff nnoremap <buffer> <leader>ecp <cmd>autocmd groffcomp BufWritePost <buffer> silent !compiledoc % &<cr>
	au FileType nroff,troff nnoremap <buffer> <leader>dcp <cmd>autocmd! groffcomp BufWritePost <buffer><cr>
	au FileType nroff,troff nnoremap <buffer> <leader>pdf :exe "silent !setsid -f xdg-open ".expand('%:r').".pdf"<cr>
augroup end

au FileType markdown vmap <leader><bslash> :EasyAlign*<bar><cr>

" don't follow EditorConfig rules for Git commit messages
au FileType gitcommit let b:EditorConfig_disable = 1

" display markdown files using glow
au FileType markdown nmap <buffer> <leader>gl :sp \| te glow %<cr>
au FileType markdown nmap <buffer> <leader>vgl :vsp \| te glow %<cr>

" BINARY FILE EDITING {{{1

" Add autocmds to edit binary files as hex using xxd(1)
function <SID>AddHexAutoCmds()
	augroup hexedit
		au!
		au BufReadPost  <buffer> exe "%!xxd -groupsize 1" | set ft=xxd
		au BufWritePre  <buffer> exe "%!xxd -revert -groupsize 1"
		au BufWritePost <buffer> exe "%!xxd -groupsize 1" | set nomod
	augroup end
endfunction

" Load autocmds when opening a file in binary mode
autocmd BufReadPre * if &binary | call <SID>AddHexAutoCmds() | endif


" KEYBOARD SHORTCUTS {{{1

" Leader key
let mapleader = ','

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
noremap <Leader>tn <cmd>tabnew<CR>
noremap ]t <cmd>tabn<CR>
noremap [t <cmd>tabp<CR>
noremap <Leader>tc :tabe %:h/

" open a terminal
nnoremap <leader>tm :split\|terminal<cr>
nnoremap <leader>tv :vsplit\|terminal<cr>
nnoremap <leader>tt :tabnew\|terminal<cr>

" toggle line wrapping
nnoremap <leader>wr :set wrap!<cr>

" toggle visible whitespace
nnoremap <leader>ws <cmd>set list!<cr>

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

" Telescope fuzzy-finder shortcuts
nmap <silent> <leader>ff <cmd>Telescope find_files<cr>
nmap <silent> <leader>ft <cmd>Telescope git_files<cr>
nmap <silent> <leader>fg <cmd>Telescope live_grep<cr>
nmap <silent> <leader>fb <cmd>Telescope buffers<cr>
nmap <silent> <leader>fh <cmd>Telescope help_tags<cr>
nmap <silent> <leader>cc <cmd>Telescope commands<cr>
nmap <silent> <leader>ts <cmd>Telescope treesitter<cr>
command! T Telescope builtin

" visual to norm shortcut
vnoremap . :norm 

" save using ZW
nnoremap ZW <cmd>w<cr>

" Secondary comment keybind
nnoremap <c-_> <Plug>CommentaryLine
vnoremap <c-_> <Plug>Commentary
xnoremap <c-_> <Plug>Commentary

" CoC Mappings
autocmd CursorHold * silent call CocActionAsync('highlight')
inoremap <silent><expr> <c-n> coc#refresh()
nmap     <c-]>      <plug>(coc-definition)
nmap     <leader>gd <plug>(coc-definition)
nmap     <leader>gD <plug>(coc-declaration)
nmap     <leader>gy <plug>(coc-type-definition)
nmap     <leader>gi <plug>(coc-implementation)
nmap     <leader>gr <plug>(coc-references)
nmap     <leader>fr <plug>(coc-refactor)
nmap     <leader>fm <plug>(coc-format)
xmap     <leader>fm <plug>(coc-format-selected)
vmap     <leader>fm <plug>(coc-format-selected)
nmap     ]e         <plug>(coc-diagnostic-next-error)
nmap     [e         <plug>(coc-diagnostic-prev-error)
nmap     ]w         <plug>(coc-diagnostic-next)
nmap     [w         <plug>(coc-diagnostic-prev)
nmap     <leader>ci <plug>(coc-diagnostic-info)
nmap     <leader>a  <plug>(coc-codeaction-selected)
xmap     <leader>a  <plug>(coc-codeaction-selected)
nmap     <leader>ac <plug>(coc-codeaction)
nnoremap <leader>cr <cmd>CocRestart<cr>
nnoremap <leader>cd <cmd>CocDisable<cr>
nnoremap <leader>ce <cmd>CocEnable<cr>
inoremap <m-cr>     <esc>f,2lct,
inoremap <s-cr>     <esc>f,2lct)
nnoremap <silent> K :call <sid>show_documentation()<cr>
nmap <nowait><expr> <up> coc#float#has_scroll() ? coc#float#scroll(0, 2) : "\<up>"
nmap <nowait><expr> <down> coc#float#has_scroll() ? coc#float#scroll(1, 2) : "\<down>"

function s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h ' . expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Tag bar
nnoremap <c-b> :TagbarToggle<cr>

" Lorem Ipsum generator
function Lipsum(paragraphs)
	exe "r !gzip -dc $HOME/.local/share/lipsum.txt.gz | head -n" . a:paragraphs . " | sed 's/$/\\n/; s/\\. /.\\n/g'"
endfunction

" Align markdown tables using vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Surround character with spaces
nmap <leader><space> i <esc>la <esc>h

" Set emmet completion key
let g:user_emmet_leader_key='<C-Z>'

" Open lf(1)
nmap <leader>lf <cmd>tabnew \| terminal lf<cr>a

" Open Neotree
nmap <leader>nt <cmd>Neotree reveal toggle<cr>
nmap <c-n> <leader>nt

" 1}}}

" vim: set foldmethod=marker foldmarker={{{,}}} :
