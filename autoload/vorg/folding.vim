function! vorg#folding#foldText()
	let foldlines = getline(v:foldstart, v:foldend)

    " remove leading white space, too verbose dates, checkboxes
    let header = foldlines[0]
	let header = substitute(header, '^\s*', "", "")
    let header = substitute(header, '\s*[$.^=]....-..-..', "", "g")
    let header = substitute(header, '\[[ .xX-]\]\s*', "", "g")

    " copy indentation
	let text = repeat(' ', indent(v:foldstart)) . header

	let total_boxes = 0
	let total_checked = 0
    let total_open = 0
	for line in foldlines
		if match(line, '\[[ .]\]') > -1
			let total_boxes += 1
            let total_open += 1
		elseif match(line, '\[[xX]\]') > -1
			let total_boxes += 1
			let total_checked += 1
		endif
	endfor
    if total_open > 0
      let prefix = printf('+ [ %3d ] -- ', total_open)
    else
      let prefix = '+----------- '
    endif
    let numdashes = winwidth(win_getid()) - strlen(prefix) - strlen(text)
    let text = prefix . text . repeat('-', numdashes)
  return text
endfunction
