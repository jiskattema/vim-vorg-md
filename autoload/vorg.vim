function! s:tmpQuickfix()
	copen
	nnoremap <buffer> o <CR>
	nnoremap <buffer> q :q<CR>
endfunction

function! vorg#gather(pattern)
	if !empty(a:pattern)
		execute "silent! vimgrep /" . a:pattern . "/j " . substitute(expand('%'), " ", '\\ ', "g")
		call s:tmpQuickfix()
	endif
endfunction

function! vorg#gatherAll(pattern)
	if !empty(a:pattern)
		execute "silent! vimgrep /" . a:pattern . "/j **/*.vorg"
		call s:tmpQuickfix()
	endif
endfunction

silent function! vorg#checkbox_set(state, symbol)
  " remove all progress '.', cancelled '$', and finished '=' dates
  s/\s*\$\d\d\d\d-\d\d-\d\d//ge
  s/\s*\.\d\d\d\d-\d\d-\d\d//ge
  s/\s*=\d\d\d\d-\d\d-\d\d//ge
  execute('s/\[.\]/[' . a:state . ']/e')
  if strlen(a:symbol) > 0
    execute('normal A ' . a:symbol . 'dd')
    normal! _
  endif
endfunction

function vorg#gonext()
  " find the previous header or bullet point
  " first move one word forward to compensate for the exclusive backwards search
  normal! w?^\s*[-#]

  " move to the first non-blank character
  normal! _

  let c = getline('.')[col('.')-1] 

  if c == '-'
    " go to the next bullet point with equal or less indentation
    " do not pass a markdown header
    let ind = indent(line('.'))
    execute('silent normal! /^\s\{0,' . ind . '}-\|^\s*#')
    normal! _
  endif
  if c == '#'
    " go to the next markdown header of equal of less depth
    " count the number of #
    " find the next with the same or less
    let markdown_depth = substitute(getline('.'), '^\s*\(#*\).*', '\1', 'e')
    let markdown_depth = strlen(markdown_depth)
    
    execute('silent normal! /^\s*#\{1,' . markdown_depth . '} ')
    normal! _
  endif
endfunction

function vorg#goprevious()
  " find the previous header or bullet point
  " first move one word forward to compensate for the exclusive backwards search
  normal! w?^\s*[-#]

  " move to the first non-blank character
  normal! _

  let c = getline('.')[col('.')-1] 

  if c == '-'
    " go to the previous bullet point with equal or less indentation
    " do not pass a markdown header
    let ind = indent(line('.'))
    execute('silent normal! k?^\s\{0,' . ind . '}-\|^\s*#')
    normal! _
  endif
  if c == '#'
    " go to the previous markdown header of equal of less depth
    " count the number of #
    " find the next with the same or less
    let markdown_depth = substitute(getline('.'), '^\s*\(#*\).*', '\1', 'e')
    let markdown_depth = strlen(markdown_depth)
    
    execute('silent normal! ?^\s*#\{1,' . markdown_depth . '} ')
    normal! _
  endif
endfunction
