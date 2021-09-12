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

" Copied from user938271
" https://vi.stackexchange.com/questions/19940/changing-how-the-quickfix-list-displays-matches
function vorg#qf_todo() abort
  " Find deadlines or scheduled dates with an empty [ ]  or started [.] checkbox in front
  silent vimgrep /^.*\[[ .]\].*[~!]\d\d\d\d-\d\d-\d\d/gj %

  let qfl = getqflist()
  call sort(qfl, function('s:SortTodo'))

  call setqflist([], 'r', #{
        \ items: qfl,
        \ quickfixtextfunc : 's:quickfixtextfunc'
        \ })
  copen
  set syntax=vorg
endfunction

function vorg#qf_started() abort
  " Find started dates
  silent vimgrep /[.]\d\d\d\d-\d\d-\d\d/gj %

  let qfl = getqflist()
  call sort(qfl, function('s:SortTodo'))

  call setqflist([], 'r', #{
        \ items: qfl,
        \ quickfixtextfunc : 's:quickfixtextfunc'
        \ })
  copen
  set syntax=vorg
endfunction

function s:quickfixtextfunc(info) abort
    if a:info.quickfix
        let qfl = getqflist(#{id: a:info.id, items: 1}).items
    else
        let qfl = getloclist(a:info.winid, #{id: a:info.id, items: 1}).items
    endif

    let l = []
    for idx in range(a:info.start_idx - 1, a:info.end_idx - 1)
        let e = qfl[idx]
        let fname = bufname(e.bufnr)->fnamemodify(':t')
        let cnamedate = vorg#dates#commonName(matchstr(e.text, '[!~]\d\d\d\d-\d\d-\d\d')[1:])
        let summary = substitute(e.text, '[!~^.$-]\d\d\d\d-\d\d-\d\d', '', 'ge')
        let summary = substitute(summary, '^\s*\(#*\)\?-\?\s*\(\[.\]\s*\)\?', '', 'ge')
        let displayed = printf('%12s  %s',
            \ cnamedate,
            \ summary
            \ )
        call add(l, displayed)
    endfor
    return l
endfunction

function s:SortTodo(i, j) abort
  let s1 = matchstr(a:i.text, '[!~]\d\d\d\d-\d\d-\d\d')
  let s2 = matchstr(a:j.text, '[!~]\d\d\d\d-\d\d-\d\d')

  " For started items without a date
  if strlen(s1) == 0
    return 1
  endif
  if strlen(s2) == 0
    return -1
  endif

  " drop leading ~!
  let s1 = s1[1:]
  let s2 = s2[1:]

  return s1 ==# s2 ? 0 : s1 ># s2 ? 1 : -1
endfunction
