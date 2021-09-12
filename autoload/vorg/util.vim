function! vorg#util#trim(string)
	return substitute(a:string, '^\s\+\|\s\+$', "", "g")
endfunction
