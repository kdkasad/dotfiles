"""""""""""""""""""""
" COLORSCHEME SETUP "
"""""""""""""""""""""

let g:colors_name = "pink_forest"

set background=dark
highlight clear
if exists("syntax_on")
	syntax reset
endif

"""""""""""""""""""""
" COLOR DEFINITIONS "
"""""""""""""""""""""

let s:dark_gui		= "#473d4b"
let s:gray2_gui		= "#55495B"
let s:gray_gui		= "#908EAB"
let s:white_gui		= "#FFFFFF"
let s:red_gui		= "#F06D72"
let s:pink_gui		= "#F9C1C4"
let s:green_gui		= "#A2EEA2"
let s:yellow_gui	= "#FFED9B"
let s:orange_gui	= "#F8A983"
let s:blue_gui		= "#88A9CE"
let s:cyan_gui		= "#99D7F8"
let s:purple_gui	= "#C2B1D5"

let s:dark_term		= 0
let s:red_term		= 1
let s:green_term	= 2
let s:yellow_term	= 3
let s:blue_term		= 4
let s:purple_term	= 5
let s:cyan_term		= 6
let s:white_term	= 7
let s:gray_term		= 8
let s:pink_term		= 9
let s:orange_term	= 11
let s:gray2_term	= 15

let s:fg_dark	= " ctermfg=" . s:dark_term . " guifg=" . s:dark_gui
let s:fg_red	= " ctermfg=" . s:red_term . " guifg=" . s:red_gui
let s:fg_green	= " ctermfg=" . s:green_term . " guifg=" . s:green_gui
let s:fg_yellow	= " ctermfg=" . s:yellow_term . " guifg=" . s:yellow_gui
let s:fg_blue	= " ctermfg=" . s:blue_term . " guifg=" . s:blue_gui
let s:fg_purple	= " ctermfg=" . s:purple_term . " guifg=" . s:purple_gui
let s:fg_cyan	= " ctermfg=" . s:cyan_term . " guifg=" . s:cyan_gui
let s:fg_white	= " ctermfg=" . s:white_term . " guifg=" . s:white_gui
let s:fg_gray	= " ctermfg=" . s:gray_term . " guifg=" . s:gray_gui
let s:fg_pink	= " ctermfg=" . s:pink_term . " guifg=" . s:pink_gui
let s:fg_orange	= " ctermfg=" . s:orange_term . " guifg=" . s:orange_gui
let s:fg_gray2	= " ctermfg=" . s:gray2_term . " guifg=" . s:gray2_gui

let s:bg_none	= " ctermbg=NONE guibg=NONE"
let s:bg_dark	= " ctermbg=" . s:dark_term . " guibg=" . s:dark_gui
let s:bg_red	= " ctermbg=" . s:red_term . " guibg=" . s:red_gui
let s:bg_green	= " ctermbg=" . s:green_term . " guibg=" . s:green_gui
let s:bg_yellow	= " ctermbg=" . s:yellow_term . " guibg=" . s:yellow_gui
let s:bg_blue	= " ctermbg=" . s:blue_term . " guibg=" . s:blue_gui
let s:bg_purple	= " ctermbg=" . s:purple_term . " guibg=" . s:purple_gui
let s:bg_cyan	= " ctermbg=" . s:cyan_term . " guibg=" . s:cyan_gui
let s:bg_white	= " ctermbg=" . s:white_term . " guibg=" . s:white_gui
let s:bg_gray	= " ctermbg=" . s:gray_term . " guibg=" . s:gray_gui
let s:bg_pink	= " ctermbg=" . s:pink_term . " guibg=" . s:pink_gui
let s:bg_orange	= " ctermbg=" . s:orange_term . " guibg=" . s:orange_gui
let s:bg_gray2	= " ctermbg=" . s:gray2_term . " guibg=" . s:gray2_gui

let s:none		= " cterm=none gui=none"
let s:bold		= " cterm=bold gui=bold"
let s:underline	= " cterm=underline gui=underline"
let s:italic	= " cterm=italic gui=italic"
let s:reverse	= " cterm=reverse gui=reverse"

"""""""""""""""""'"
" ELEMENT STYLING "
"""""""""""""""""'"

exe "hi Normal" . s:fg_white . s:bg_dark
exe "hi Error" . s:fg_white . s:bg_red
hi! link ErrorMsg Error
exe "hi Question" . s:fg_green . s:bg_none . s:none
exe "hi EndOfBuffer" . s:fg_dark . s:bg_none
exe "hi StatusLine" . s:fg_purple . s:bg_gray2
exe "hi Comment" . s:fg_gray
exe "hi CursorLine" . s:bg_gray2 . s:none
hi! link CursorColumn CursorLine
exe "hi CursorLineNr" . s:fg_yellow . s:bold
exe "hi LineNr" . s:fg_gray
exe "hi Visual ctermbg=241 guibg=#626262"
exe "hi Todo" . s:fg_dark . s:bg_yellow . s:bold
exe "hi String" . s:fg_green . s:bg_none
exe "hi Special" . s:fg_blue . s:bg_none . s:bold
exe "hi Statement" . s:fg_yellow . s:bg_none . s:bold
exe "hi Identifier" . s:fg_cyan . s:bg_none
exe "hi PreProc" . s:fg_purple . s:bg_none . s:bold
exe "hi Constant" . s:fg_yellow . s:bg_none
exe "hi Number" . s:fg_pink . s:bg_none
exe "hi Type" . s:fg_blue . s:bg_none
exe "hi Search" . s:bg_cyan

exe "hi DiffAdd" . s:bg_green . s:fg_dark
exe "hi DiffDelete" . s:bg_red . s:fg_dark
exe "hi DiffAdded" . s:fg_green . s:bg_none
exe "hi DiffRemoved" . s:fg_red . s:bg_none

exe "hi Pmenu" . s:fg_dark . s:bg_purple
exe "hi PmenuSel" . s:fg_dark . s:bg_pink
exe "hi PmenuSbar" . s:bg_gray
exe "hi PmenuThumb" . s:bg_gray2

exe "hi SpellBad" . s:fg_dark . s:bg_red
exe "hi SpellRare" . s:fg_dark . s:bg_yellow
hi! link SpellLocal SpellRare
exe "hi SpellCap" . s:fg_dark . s:bg_orange

exe "hi cIncluded" . s:fg_cyan . s:bg_none

exe "hi makeCommands" . s:fg_yellow . s:bg_none

exe "hi htmlItalic" . s:italic
exe "hi htmlBold" . s:bold
exe "hi htmlH" . s:bold
hi! link htmlH1 htmlH
hi! link htmlH2 htmlH
hi! link htmlH3 htmlH
hi! link htmlH4 htmlH
hi! link htmlH5 htmlH
hi! link htmlH6 htmlH
hi! link markdownH1 htmlH
hi! link markdownH2 htmlH
hi! link markdownH3 htmlH
hi! link markdownH4 htmlH
hi! link markdownH5 htmlH
hi! link markdownH6 htmlH
exe "hi htmlLink" . s:fg_blue . s:bg_none . " cterm=bold,underline gui=bold,underline"
hi! link markdownLink htmlLink

hi! link helpHyperTextJump htmlLink
