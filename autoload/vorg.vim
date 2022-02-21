silent function! vorg#checkbox_log()
  " convert an open checkbox in a log entry
  s/- \[[ xX.-]\]\(\s*\^\d\d\d\d-\d\d-\d\d\)\?\s*//ge
  normal _idl _
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

" Copied from user938271
" https://vi.stackexchange.com/questions/19940/changing-how-the-quickfix-list-displays-matches
function vorg#qf_todo() abort
  " Find items wit an empty [ ] or started [.] checkbox in front
  let grepprg_old = &grepprg
  set grepprg=git\ grep\ -Ine
  silent! grep '\[[ \.]\]' -- ':(exclude)*.pdf'
  :redraw!

  "set wildignore+=.git/**,.zim/**
  "silent vimgrep /^\s*-\?\s*\[[ .]\]/gj **/*.txt

  let qfl = getqflist()
  call sort(qfl, function('s:SortTodo'))

  call setqflist([], 'r', #{
        \ items: qfl,
        \ quickfixtextfunc : 's:quickfixtextfunc'
        \ })
  copen
  set syntax=vorg
  set grepprg=&grepprg_old
endfunction

function vorg#qf_started() abort
  " Find started dates
  let grepprg_old = &grepprg
  set grepprg=git\ grep\ -Ine
  silent! grep '[.]\d\d\d\d-\d\d-\d\d' -- ':(exclude)*.pdf'
  :redraw!

  "silent vimgrep /[.]\d\d\d\d-\d\d-\d\d/gj %

  let qfl = getqflist()
  call sort(qfl, function('s:SortTodo'))

  call setqflist([], 'r', #{
        \ items: qfl,
        \ quickfixtextfunc : 's:quickfixtextfunc'
        \ })
  copen
  set syntax=vorg
  set grepprg=&grepprg_old
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
