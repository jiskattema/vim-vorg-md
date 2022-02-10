function! vorgmd#folding#foldText()
	let foldlines = getline(v:foldstart, v:foldend)
	let header = substitute(foldlines[0], "^\\s*-", "+", "")
	let text = repeat(' ', indent(v:foldstart)) . header

	let total_boxes = 0
	let total_checked = 0
	for line in foldlines
		if match(line, "- \\[ \\]") > -1
			let total_boxes += 1
		elseif match(line, "- \\[x\\]") > -1
			let total_boxes += 1
			let total_checked += 1
		endif
	endfor
	if total_boxes > 0
		let text .= " [ " . total_checked . " / " . total_boxes . " ]"
	endif
	return text . ' '
endfunction

function! vorgmd#folding#foldExpr(lnum)
	let line = getline(a:lnum)

	# empty line - no folding
	if line =~ "^\\s*$"
		return 0
	endif

	let next_line = getline(a:lnum + 1)

	# next line is an unordered list item - we have a fold
	if next_line =~ "^\\s*- "
		return 1
	endif

	# next line is an ordered list item - we have a fold
	if next_line =~ "^\\s*\\d\\+\\."
		return 1
	endif

	return '='
endfunction

