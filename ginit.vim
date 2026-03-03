set guifont=VictorMono\ Nerd\ Font\ Mono:h15
set linespace=12

" let g:neovide_line_height = 5
let g:neovide_padding_top = 16
let g:neovide_padding_bottom = 16
let g:neovide_padding_left = 20
let g:neovide_padding_right = 20

function! ChangeFontSize(delta)
  let l:font = matchstr(&guifont, '.*:h')
  let l:size = matchstr(&guifont, ':h\zs\d\+')
  let l:newsize = l:size + a:delta
  if l:newsize < 6
    let l:newsize = 6
  endif
  let &guifont = l:font . l:newsize
endfunction

nnoremap <C-=> :call ChangeFontSize(1)<CR>
nnoremap <C--> :call ChangeFontSize(-1)<CR>
nnoremap <C-0> :set guifont=VictorMono\ Nerd\ Font\ Mono:h14<CR>
