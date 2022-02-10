function! vorgmd#tasks#toggleCheckbox() range
	let view = winsaveview()
	let lines = getline(a:firstline, a:lastline)
	let lnum = a:firstline
	for line in lines
			if line =~? "\\[x\\]"
				call setline(lnum, substitute(line, "\\[[xX]\\]", "[ ]", ""))
			elseif line =~? "\\[ \\]"
				call setline(lnum, substitute(line, "\\[ \\]", "[x]", ""))
			endif

			let lnum += 1
	endfor
	call winrestview(view)
endfunction

