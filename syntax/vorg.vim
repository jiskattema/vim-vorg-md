" vorg.vim - Vim organization format.
" Maintainer:   Bartosz Jarzyna <https://github.com/brtastic>
" Version:      1.0

" Syntax Definition
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword vorgDeadlineKw    DEADLINE
syn keyword vorgScheduledKw   SCHEDULED

syn match vorgDeadline        "\(\s\|^\)\@<=!\d\+[/-]\d\+[/-]\d\+\( @ \d\+:\d\+\)\?\(\s\|$\)\@="
syn match vorgScheduled       "\(\s\|^\)\@<=\~\d\+[/-]\d\+[/-]\d\+\( @ \d\+:\d\+\)\?\(\s\|$\)\@="
syn match vorgTag             "\(\s\|^\)\@<=@\w\+"
syn match vorgComment         "// .*"

syn match vorgLink            "\(https\?://\|www\.\)[^,; \t]*"
syn match vorgIpv4            "\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\.\d\{1,3\}\(:\d\{1,5\}\)\?\(\s\|$\)\@="
syn match vorgHex             "0x[0-9a-fA-F]\+\(\s\|$\)\@="
syn match vorgNumber          "[0-9]\+\([,.][0-9]\+\)\?\(\s\|$\)\@="
syn match vorgDate            "\d\+[/-]\d\+[/-]\d\+\(\s\|$\)\@="
syn match vorgTime            "\d\+:\d\+\(\s\|$\)\@="

syn match vorgTask            "\[[ ]\]" contained
syn match vorgTaskStarted     "\[[\.]\]" contained
syn match vorgTaskCancelled   "\[[-]\]" contained
syn match vorgTaskDone        "\[[xX]\]" contained
syn match vorgRadio           "([ xX])" contained

syn match vorgTaskZeroText    ".*\[[ ]\].*" contains=ALL
syn match vorgTaskStartedText ".*\[[\.]\].*" contains=ALL
syn match vorgTaskCancelledText   ".*\[[-]\].*" contains=ALL
syn match vorgTaskDoneText    ".*\[[xX]\].*" contains=ALL

syn match vorgListItem        "^\s*-"
syn match vorgTitle           "^\s*#.*"
  
syntax match vorgCreated   '\^\d\d\d\d-\d\d-\d\d' conceal cchar=^
syntax match vorgStarted   '\.\d\d\d\d-\d\d-\d\d' conceal cchar=.
syntax match vorgCancelled '\$\d\d\d\d-\d\d-\d\d' conceal cchar=$
syntax match vorgFinished  '=\d\d\d\d-\d\d-\d\d'  conceal cchar==

hi def link vorgComment        Comment
hi def link vorgTag            Identifier
hi def link vorgTitle          Title
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
