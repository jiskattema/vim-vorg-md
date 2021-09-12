" vorg.vim - Vim organization format.
" Maintainer:   Bartosz Jarzyna <https://github.com/brtastic>
" Version:      1.0

if exists('g:loaded_vorg')
	finish
endif

" Offical Vorg interface commands
command -nargs=? VorgGatherAll :call vorg#gatherAll(input("Search files for: "))
command -nargs=? VorgGather :call vorg#gather(input("Search for: "))

command -bar QfTodo :call vorg#qf_todo()
command -bar QfStarted :call vorg#qf_started()

let g:loaded_vorg = 1
