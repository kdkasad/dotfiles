" =============================================================================
" Filename: autoload/lightline/colorscheme/pink_line.vim
" Author: kdkasad
" License: MIT License
" Last Change: 2020/04/25 13:28:00.
" =============================================================================

let s:black = [ '#473d4b', 0 ]
let s:gray = [ '#55495B', 15 ]
let s:white = [ '#ffffff', 7 ]
let s:blue = [ '#88a9ce' , 4 ] 
let s:green = [ '#a2eea2', 2 ] 
let s:purple = [ '#c2b1d5', 5 ]
let s:red = [ '#f06d72', 1 ]
let s:yellow = [ '#ffed9b', 3 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:black, s:purple ], [ s:purple, s:gray ] ]
let s:p.normal.right = [ [ s:black, s:purple ], [ s:purple, s:gray ] ]
let s:p.inactive.left =  [ [ s:black, s:blue ], [ s:blue, s:gray ] ]
let s:p.inactive.right = [ [ s:black, s:blue ], [ s:blue, s:gray ] ]
let s:p.insert.left = [ [ s:black, s:blue ], [ s:blue, s:gray ] ] 
let s:p.insert.right = [ [ s:black, s:blue ], [ s:blue, s:gray ] ]
let s:p.replace.left = [ [ s:black, s:red ], [ s:red, s:gray ] ]
let s:p.replace.right = [ [ s:black, s:red ], [ s:red, s:gray ] ]
let s:p.visual.left = [ [ s:black, s:yellow ], [ s:yellow, s:gray ] ]
let s:p.visual.right = [ [ s:black, s:yellow ], [ s:yellow, s:gray ] ]
let s:p.normal.middle = [ [ s:white, s:gray ] ]
let s:p.inactive.middle = [ [ s:white, s:gray ] ]
let s:p.tabline.left = [ [ s:green, s:gray ] ]
let s:p.tabline.tabsel = [ [ s:black, s:green ] ]
let s:p.tabline.middle = [ [ s:green, s:gray ] ]
let s:p.tabline.right = [ [ s:black, s:green ] ]
let s:p.normal.error = [ [ s:red, s:black ] ]
let s:p.normal.warning = [ [ s:yellow, s:black ] ]

let g:lightline#colorscheme#pink_line#palette = lightline#colorscheme#flatten(s:p)
