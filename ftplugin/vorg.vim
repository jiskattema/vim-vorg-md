" vorg.vim - Vim organization format.
" Maintainer:   Bartosz Jarzyna <https://github.com/brtastic>
" Version:      1.0

" Indentation settings based on the vorg specification
setlocal smartindent
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

setlocal conceallevel=2

" insert mode shortcuts
abbreviate <buffer> -[ - [ ] ^<C-R>=strftime("%Y-%m-%d")<CR>
abbreviate <buffer> [[ [ ] ^<C-R>=strftime("%Y-%m-%d")<CR>
abbreviate <buffer> dl ^<C-R>=strftime("%Y-%m-%d")<CR>

" normal mode shortcuts
nnoremap <buffer> <CR> za
nnoremap <buffer> <silent> ? :call vorg#agenda#show()<CR>

nnoremap <buffer> <silent> <leader>z :call vorg#checkbox_set(' ', '')<CR>
nnoremap <buffer> <silent> <leader>x :call vorg#checkbox_set('x', '=')<CR>
nnoremap <buffer> <silent> <leader>c :call vorg#checkbox_set('-', '$')<CR>
nnoremap <buffer> <silent> <leader>v :call vorg#checkbox_set('.', '.')<CR>

" move to next/prev task
nmap <buffer> <C-n> :call vorg#gonext()<CR>
nmap <buffer> <C-p> :call vorg#goprevious()<CR>

" shortcuts for date entry
abbreviate <buffer> dd <C-R>=strftime("%Y-%m-%d")<CR>
abbreviate <buffer> dt <C-R>=strftime("%Y-%m-%d @ %H:%M")<CR>


" add next day shortcuts
abbreviate <buffer> dd1 <C-R>=vorg#dates#nextDay(1)<CR>
abbreviate <buffer> dd2 <C-R>=vorg#dates#nextDay(2)<CR>
abbreviate <buffer> dd3 <C-R>=vorg#dates#nextDay(3)<CR>
abbreviate <buffer> dd4 <C-R>=vorg#dates#nextDay(4)<CR>
abbreviate <buffer> dd5 <C-R>=vorg#dates#nextDay(5)<CR>
abbreviate <buffer> dd6 <C-R>=vorg#dates#nextDay(6)<CR>
abbreviate <buffer> dd7 <C-R>=vorg#dates#nextDay(7)<CR>

" add next weekday date shortcuts
abbreviate <buffer> dw1 <C-R>=vorg#dates#nextWeek(1)<CR>
abbreviate <buffer> dw2 <C-R>=vorg#dates#nextWeek(2)<CR>
abbreviate <buffer> dw3 <C-R>=vorg#dates#nextWeek(3)<CR>
abbreviate <buffer> dw4 <C-R>=vorg#dates#nextWeek(4)<CR>
abbreviate <buffer> dw5 <C-R>=vorg#dates#nextWeek(5)<CR>
abbreviate <buffer> dw6 <C-R>=vorg#dates#nextWeek(6)<CR>
abbreviate <buffer> dw7 <C-R>=vorg#dates#nextWeek(7)<CR>

" add next month date shortcuts
abbreviate <buffer> dm1 <C-R>=vorg#dates#nextMonth(1)<CR>
abbreviate <buffer> dm2 <C-R>=vorg#dates#nextMonth(2)<CR>
abbreviate <buffer> dm3 <C-R>=vorg#dates#nextMonth(3)<CR>
abbreviate <buffer> dm4 <C-R>=vorg#dates#nextMonth(4)<CR>
abbreviate <buffer> dm5 <C-R>=vorg#dates#nextMonth(5)<CR>
abbreviate <buffer> dm6 <C-R>=vorg#dates#nextMonth(6)<CR>
abbreviate <buffer> dm7 <C-R>=vorg#dates#nextMonth(7)<CR>

" add next year date shortcuts
abbreviate <buffer> dy1 <C-R>=vorg#dates#nextYear(1)<CR>
abbreviate <buffer> dy2 <C-R>=vorg#dates#nextYear(2)<CR>
abbreviate <buffer> dy3 <C-R>=vorg#dates#nextYear(3)<CR>
abbreviate <buffer> dy4 <C-R>=vorg#dates#nextYear(4)<CR>
abbreviate <buffer> dy5 <C-R>=vorg#dates#nextYear(5)<CR>
abbreviate <buffer> dy6 <C-R>=vorg#dates#nextYear(6)<CR>
abbreviate <buffer> dy7 <C-R>=vorg#dates#nextYear(7)<CR>
