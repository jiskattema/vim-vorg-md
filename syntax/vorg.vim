" vorg.vim - Vim organization format.
" Maintainer:   Bartosz Jarzyna <https://github.com/brtastic>
" Version:      1.0

" Syntax Definition
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syn keyword vorgDeadlineKw    DEADLINE contained
syn keyword vorgScheduledKw   SCHEDULED contained

syn match vorgDeadline        "\(\s\|^\)\@<=!\d\+[/-]\d\+[/-]\d\+\( @ \d\+:\d\+\)\?\(\s\|$\)\@=" contained
syn match vorgScheduled       "\(\s\|^\)\@<=\~\d\+[/-]\d\+[/-]\d\+\( @ \d\+:\d\+\)\?\(\s\|$\)\@=" contained
syn match vorgTag             "\(\s\|^\)\@<=#\w\+" contained
syn match vorgComment         "// .*" contained

syn match vorgLink            "\(\s\|^\)\@<=\%(https\?://\|www\.\)[^,; \t]*" contained
syn match vorgIpv4            "\(\s\|^\)\@<=\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\(:\d\{1,5\}\)\?\(\s\|$\)\@=" contained
syn match vorgHex             "\(\s\|^\)\@<=0x[0-9a-fA-F]\+\(\s\|$\)\@=" contained
syn match vorgNumber          "\(\s\|^\)\@<=[0-9]\+\([,.][0-9]\+\)\?\(\s\|$\)\@=" contained
syn match vorgDate            "\(\s\|^\)\@<=\d\+[/-]\d\+[/-]\d\+\(\s\|$\)\@=" contained
syn match vorgTime            "\(\s\|^\)\@<=\d\+:\d\+\(\s\|$\)\@=" contained

syn match vorgTask            "\[[ ]\]" contained
syn match vorgTaskStarted     "\[[\.]\]" contained
syn match vorgTaskCancelled   "\[[-]\]" contained
syn match vorgTaskDone        "\[[xX]\]" contained
syn match vorgRadio           "([ xX])" contained

syn match vorgTaskStartedText ".*\[[\.]\].*" contained contains=vorgTaskStarted,vorgStarted,vorgCreated
syn match vorgTaskCancelledText   ".*\[[-]\].*" contained contains=vorgTaskCancelled,vorgCancelled,vorgCreated
syn match vorgTaskDoneText    ".*\[[xX]\].*" contained contains=vorgTaskDone,vorgFinished,vorgCreated

syn match vorgListItem        "^\s*-" contained

syntax match vorgCreated   '\^\d\d\d\d-\d\d-\d\d' conceal cchar=^
syntax match vorgStarted   '\.\d\d\d\d-\d\d-\d\d' conceal cchar=.
syntax match vorgCancelled '\$\d\d\d\d-\d\d-\d\d' conceal cchar=$
syntax match vorgFinished  '=\d\d\d\d-\d\d-\d\d'  conceal cchar==

hi def link vorgComment        Comment
hi def link vorgTag            Comment
hi def link vorgTaskDoneText   Comment
hi def link vorgTaskStarted    Normal
hi def link vorgTaskCancelled  Comment
hi def link vorgListItem       Function
hi def link vorgTask           Special
hi def link vorgRadio          Special
hi def link vorgTaskDone       Special
hi def link vorgDeadline       Todo
hi def link vorgScheduled      Todo
hi def link vorgDeadlineKw     Error
hi def link vorgScheduledKw    Todo
hi def link vorgLink           Constant
hi def link vorgIpv4           Constant
hi def link vorgDate           String
hi def link vorgTime           String
hi def link vorgHex            Number
hi def link vorgNumber         Number

setlocal foldmethod=expr
setlocal foldexpr=vorg#folding#foldExpr(v:lnum)
setlocal foldtext=vorg#folding#foldText()

let b:current_syntax = "vorg"
