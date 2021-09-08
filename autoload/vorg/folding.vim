function! vorg#folding#foldText()
	let foldlines = getline(v:foldstart, v:foldend)
	let header = substitute(foldlines[0], "^\\s*[-#]", "+", "")

    " remove too verbose dates
    let header = substitute(header, '\s*[$.^=]....-..-..', "", "g")

    " copy indentation
	let text = repeat(' ', indent(v:foldstart)) . header

	let total_boxes = 0
	let total_checked = 0
	for line in foldlines
		if match(line, "\\[ \\]") > -1
			let total_boxes += 1
		elseif match(line, "\\[x\\]") > -1
			let total_boxes += 1
			let total_checked += 1
		endif
	endfor
	if total_boxes > 0
        let suffix = printf(' %4d / %4d', total_checked, total_boxes)
        let numdashes = winwidth(win_getid()) - strlen(suffix) - strlen(text)
		let text = text . repeat('-', numdashes) . suffix 
	endif
	return text
endfunction

function! s:getFoldLevel(lnum)
  " Current foldlevel consists of:
  "  - the indentation of the current line
  "  - the indentation of the markdown section
  let lnum = a:lnum
  let line = getline(lnum)

  let level = indent(lnum) / 2
  if line =~ "^\\s*[-]"
    " a dash starts a new fold
    let level += 1
  endif

  " move up, to find closest markdown header
  while line !~ "^\\s*[#]" && lnum > 0
    let lnum -= 1
    let line = getline(lnum)
  endwhile

  " add foldlevels for the markdown header
  if line =~ "^\\s*[#]"
    let markdown_depth = substitute(line, '^\s*\(#*\).*', '\1', 'e' )
    let level += strlen(markdown_depth)
  endif

  return level
endfunction

function! vorg#folding#jisk(lnum)
  return s:getFoldLevel(a:lnum)
endfunction

function! vorg#folding#foldExpr(lnum)
	" an empty line - same level
	let line = getline(a:lnum)
	if line =~ "^\\s*$"
		return '-1'
	endif

	let current_fold_level = s:getFoldLevel(a:lnum)

    " markdown headers and items always start a new fold
    if line =~ "^\\s*[-#]"
      return ">" . current_fold_level
    endif

    " a fold ends if the next line starts a new one
    " this prevents vim from merging folds of the same level
    let nextline = nextnonblank(a:lnum + 1)
    if nextline =~ "^\\s[-#]"
      return "<" . current_fold_level
    endif

	return current_fold_level
endfunction
