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
