" .vimrc file for Alexander Cederblad <alexcederblad@gmail.com>
" Use it as you wish.

" Pathogen
execute pathogen#infect()

set wildignore+=*.dSYM,node_modules,bower_components,vendor/*,tmp,dist/*

" Syntax
syntax enable
set t_Co=256
set background=dark
colorscheme base16-ocean
filetype plugin indent on
let base16colorspace=256
highlight visual term=reverse cterm=reverse ctermbg=black
highlight search term=reverse cterm=reverse ctermbg=black
highlight LineNr ctermbg=black

" Statusline coniguration
" TODO: Maybe fix the colors as
" hi User1 guifg=#ffdad8 guibg=#880c0e
" ..
" Source: http://stackoverflow.com/a/10416234
set statusline=
set statusline+=%7*\[%n]                             " Buffer number
set statusline+=%1*\ %<%F\                           " Filepath
set statusline+=%2*\ %y\                             " Filetype
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''} " Encoding
set statusline+=%8*\ %=\ row:\ %l/%L\ (%p%%)\        " Current row/Total rows (Position in %)
set statusline+=%9*\ col:\ %c\ \                     " Column number
set statusline+=\ \ %m%r%w\ %P\ \                    " Status (Modified/Readonly & Top/Bot)

" Options
let mapleader=","
set laststatus=2
set nocompatible
set hidden
set showmode
set showcmd
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set number
set hlsearch
set fileencoding=utf-8
set encoding=utf-8
set history=1000
set backspace=2
set noswapfile

" Key mappings
nmap <c-up> ddkP
nmap <c-k> ddkP
nmap <c-down> ddp
nmap <c-j> ddp

vmap <c-up> xkP`[V`]
vmap <c-k> xkP`[V`]
vmap <c-down> xp`[V`]
vmap <c-j> xp`[V`]

vnorem // y/<c-r>"<cr>

" Key mapping for the Command-T plug-in
nmap <leader>p :CommandT<cr>
let g:CommandTMaxFiles = 50000
let g:CommandTHighlightColor = 'Constant'
noremap <F5> :CommandTFlush<CR>

" Move around splits with <c-hjkl>
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
" nnoremap <c-h> <c-w>h
" nnoremap <c-l> <c-w>l

imap <c-c> <esc>

nmap <leader>t :!make tests<cr>

vmap <leader>y "*y

nmap <leader>m :nohlsearch<cr>

nmap <leader>j :bn<cr>
nmap <leader>k :bp<cr>

nmap <leader>c I/*<Esc>A*/<Esc>
nmap <leader>C ^xx$xx

" Multipurpose tab key
" Indent if we're at the beginning of a line. Else, do completion.
"function! InsertTabWrapper()
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return "\<tab>"
"    else
"        return "\<c-p>"
"    endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <s-tab> <c-n>

" Edit/View file in current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>
