function s:NormalMode()
	execute "command! CompileTexToPdf !pdflatex " . expand('%:r')
	execute "command! CompileTex !latex " . expand('%:r')
endfunction

function s:BibMode()
	execute "command! CompileTexToPdf !latex " . expand('%:r') . " && bibtex " . expand('%:r') . " && latex " . expand('%:r') . " && pdflatex " . expand('%:r')
	execute "command! CompileTex !latex " . expand('%:r') . " && bibtex " . expand('%:r') . " && latex " . expand('%:r') . " && latex " . expand('%:r')
endfunction

function! s:TAC()
	if !exists("s:ac")
		let s:ac = 0
	endif
	if s:ac
		let s:ac = 0
		augroup latex_autocompile
			autocmd!
		augroup END
	else
		let s:ac = 1
		augroup latex_autocompile
			execute "autocmd BufWritePost " . fnameescape(expand("%:p")) . " CompileTexToPdf"
		augroup END
	endif
endfunction

call s:NormalMode()

command! ToggleAutoCompile call s:TAC()

ToggleAutoCompile

" Snippets:
iabbrev doc \documentclass{<++>}<CR><CR>\begin{document}<CR><CR><++><CR><CR>\end{document}<Space><Space>
iabbrev pack \usepackage{<++>}<C-o>?<++><CR><C-o>df>
iabbrev ul \begin{itemize}<CR><++><CR>\end{itemize}<C-o>?<++><CR><C-o>df>
iabbrev ol \begin{enumerate}<CR><++><CR>\end{enumerate}<C-o>?<++><CR><C-o>df>
iabbrev it \item{<++>}<C-o>?<++><CR><C-o>df>

command -nargs=1 TexCompileMode if <f-args> == 'bib'
									\ | call s:BibMode()
								\ | elseif <f-args> == 'normal'
									\ | call s:NormalMode()
								\ | else
									\ | echoe "Invalid mode"
								\ | endif
