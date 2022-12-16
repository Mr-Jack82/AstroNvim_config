-- Remember last cursor position
vim.cmd [[
  augroup cursorPosition
    autocmd!
    autocmd BufRead *
      \ autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 &&
      \ line("'\"") <= line("$")
      \ | exe 'normal! g`"'
      \ | endif
  augroup END
]]

vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost *
      \ silent! lua return (not vim.v.event.visual) and
      \ require 'vim.highlight'.on_yank({ higroup="IncSearch", timeout = 150 })
  augroup END
]]

vim.cmd [[ autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx ]]
vim.cmd [[ autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact ]]
