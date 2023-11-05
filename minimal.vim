set mouse=
set nomodeline
set tabstop=2 shiftwidth=2 expandtab
" Show tabs.
set list listchars=tab:>\ 
set linebreak
set ignorecase wildignorecase
set undofile
set splitright

let g:vimtex_view_method = 'mupdf'
let g:vimtex_compiler_latexmk = { 'build_dir': '.build' }
"let g:vimtex_quickfix_ignore_filters = ['Overfull']

let g:no_ocaml_maps = 1

filetype indent plugin on

syntax on

augroup everything
  autocmd!
  " Text
  autocmd FileType gitcommit,markdown,tex,text setlocal wrap
  autocmd FileType gitcommit,markdown,tex,text setlocal spell spelllang=en_us,cjk
  " TeX
  autocmd FileType tex inoremap <buffer> ; \
  autocmd FileType tex inoremap <buffer> \ ;
  " Terminal
  autocmd TermOpen * startinsert
  autocmd TermOpen * setlocal bufhidden=delete
  " Haskell
  autocmd BufNewFile,BufRead *.x setlocal filetype=haskell
  autocmd BufNewFile,BufRead *.y setlocal filetype=haskell
  " Prolog
  autocmd BufRead,BufNewFile *.pl setlocal filetype=prolog
  " Type Theory
  autocmd BufRead,BufNewFile *.tt setfiletype tt
  autocmd Filetype tt,markdown inoremap <buffer> ;p  Π
  autocmd Filetype tt,markdown inoremap <buffer> ;al ∀
  autocmd Filetype tt,markdown inoremap <buffer> ;r  →
  autocmd Filetype tt,markdown inoremap <buffer> ;fu λ
augroup END

let mapleader = ' '
let maplocalleader = ' '

noremap j gj
noremap k gk
noremap gj j
noremap gk k

nnoremap <leader>p <cmd>new +terminal\ python<cr>
nnoremap <leader>r <cmd>wall\|split +terminal\ ./run\ '%'<cr>
nnoremap <leader>t <cmd>new +terminal<cr>

tnoremap <c-k> <c-\><c-n>
