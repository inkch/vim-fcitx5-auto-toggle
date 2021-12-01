scriptencoding utf-8

if !executable("fcitx5-remote")
  echoe "fcitx5_auto_toggle: Dependent command 'fcitx5-remote' is not executable."
  echom "fcitx5_auto_toggle: Make sure you are using 'fcitx5' and that 'fcitx5-remote' is available."
  finish
endif

if exists("g:loaded_fcitx5_auto_toggle") | finish | endif

augroup fcitx5_auto_toggle
  autocmd!
  autocmd InsertEnter * call RestoreIM()
  autocmd InsertLeave * call InactivateIM()
augroup END

function! InactivateIM()
  let b:fcitx5_was_active = system("fcitx5-remote") == 2
  call system("fcitx5-remote -c")
endfunction

function! RestoreIM()
  if !exists("b:fcitx5_was_active") || b:fcitx5_was_active != 1 | return | endif
  call system("fcitx5-remote -o")
endfunction

let g:loaded_fcitx5_auto_toggle = 1
