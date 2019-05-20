" Enable sensible.vim
runtime macros/matchit.vim

" Activate pathogen package manager
call pathogen#infect()
syntax enable
filetype plugin indent on
call pathogen#helptags()

set history=5000
set showcmd
set autoread

set wildmenu
set wildmode=longest:list,full

imap kj <Esc>
set whichwrap=b,h,l,<,>,[,]
set tabstop=2 shiftwidth=2 expandtab autoindent
set number
set hidden
retab

" Remap switch to another split
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" Remap swap split position
nmap <S-h> <C-w>H
nmap <S-j> <C-w>J
nmap <S-k> <C-w>K
nmap <S-l> <C-w>L
" Remap split resize
nmap rj :resize +5<CR>
nmap rk :resize -5<CR>
nmap rh :vertical resize -5<CR>
nmap rl :vertical resize +5<CR>

" Setup NERDTree
map <C-n> :NERDTreeToggle<CR>

" Remove trailing white space
autocmd BufWritePre *.rb,*.rake,*.erb,*.js,*.coffee,*.txt,*.TXT,*.yaml,*.md,*.MD,*.dust :%s/\s\+$//e

" Buffers
nnoremap <silent> <C-Up> :BufExplorer<CR>
nnoremap <silent> <C-Right> :bn<CR>
nnoremap <silent> <C-Left> :bp<CR>

" Map toggle fold to Enter
nmap <Enter> za
highlight Folded ctermbg=none ctermfg=darkcyan

" Fold CoffeeScript
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent

" Config for StatusLineHightlight plugin
highlight StatusLineModified term=bold,reverse cterm=bold,reverse ctermfg=LightGreen gui=bold,reverse guifg=LightGreen
highlight StatusLineModifiedNC term=reverse cterm=reverse ctermfg=LightGreen gui=reverse guifg=LightGreen

" CursorLine
set cursorline
highlight clear CursorLine
highlight CursorLineNR cterm=bold ctermfg=Yellow
highlight LineNr cterm=NONE ctermfg=DarkGray

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! Diff call s:DiffWithSaved()
