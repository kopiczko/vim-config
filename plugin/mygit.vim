if exists('g:loaded_mygit')
  finish
endif
let g:loaded_mygit = 1

command! -bang -nargs=? -range=-1 -complete=customlist,fugitive#Complete MyGit execute mygit#Command(<line1>, <count>, +"<range>", <bang>0, "<mods>", <q-args>)
