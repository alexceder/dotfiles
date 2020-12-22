" .vimrc file for Alexander Cederblad <alexcederblad@gmail.com>
" Use it as you wish.

" Pathogen
execute pathogen#infect()

" Plugins {{{
" For vim-commentary.
autocmd FileType cpp setlocal commentstring=\/\/\ %s

" Make ack.vim use ag (The Silver Searcher)
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Enable JSX in regular .js files.
let g:jsx_ext_required = 0

let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_linters = {'typescript': ['eslint']}
let g:ale_fixers = {'javascript': ['prettier'], 'css': ['prettier']}

highlight ALEWarning ctermbg=232

highlight clear ALEErrorSign
highlight clear ALEWarningSign
" }}}

" Wildignore
set wildignore+=*.dSYM,node_modules,bower_components,vendor/*,tmp,dist/*,_site,CMakeFiles,cmake_install.cmake,CMakeCache.txt,system/*,doc/*,__pycache__,_build,coverage

" Ctags
set tags=tags,.git/tags

" Colors & Style {{{
syntax enable
filetype plugin indent on
set t_Co=256
set background=dark
set linespace=10
colorscheme base16-ocean
let base16colorspace=256

highlight normal ctermbg=none
highlight visual ctermbg=black
highlight search ctermbg=black ctermfg=white

highlight LineNr ctermbg=none

highlight Pmenu ctermfg=red ctermbg=black
highlight PmenuSel ctermfg=black ctermbg=red

highlight GitGutterAdd ctermfg=green ctermbg=none
highlight GitGutterChange ctermfg=yellow ctermbg=none
highlight GitGutterDelete ctermfg=red ctermbg=none
highlight GitGutterChangeDelete ctermfg=yellow ctermbg=none

highlight TabLineFill ctermfg=white ctermbg=black
highlight TabLine ctermfg=gray ctermbg=black
highlight TabLineSel ctermfg=red ctermbg=black

highlight StatusLine ctermbg=black ctermfg=white
highlight StatusLineNC ctermbg=black ctermfg=black
highlight VertSplit ctermbg=black ctermfg=black
highlight MatchParen ctermbg=black ctermfg=white

highlight SpellBad cterm=underline ctermbg=none ctermfg=none

highlight SpecialKey ctermfg=black
ghighlight CursorLine ctermbg=232

highlight SignColumn ctermbg=none
" }}}

" Statusline {{{
" TODO: Maybe fix the colors as..
"   hi User1 guifg=#ffdad8 guibg=#880c0e
"   ..
"   See: http://stackoverflow.com/a/10416234
set statusline=
set statusline+=%7*\[%n]                             " Buffer number
set statusline+=%1*\ %<%F\                           " Filepath
set statusline+=%2*\ %y\                             " Filetype
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''} " Encoding
set statusline+=%8*\ %=\ row:\ %l/%L\ (%p%%)\        " Current row/Total rows (Position in %)
set statusline+=%9*\ col:\ %c\ \                     " Column number
set statusline+=\ \ %m%r%w\ %P\ \                    " Status (Modified/Readonly & Top/Bot)
" }}}

" Options {{{
set nocompatible
set laststatus=2
set hidden
set showmode
set showcmd
set cmdheight=2
set expandtab
set shiftwidth=2
set shiftround
set tabstop=2
set autoindent
set number
set hlsearch
set fileencoding=utf-8
set encoding=utf-8
set history=1000
set backspace=2
set noswapfile
set modeline
set modelines=5
set incsearch
set wildmenu
set mouse=a
set list
set listchars=nbsp:␣,trail:·,extends:⟩,precedes:⟨
set foldmethod=marker
set updatetime=100
" }}}

" Key mappings {{{
let mapleader=","

" Bubble movement for rows.
nmap <C-K> ddkP
nmap <C-J> ddp
vmap <C-K> xkP`[V`]
vmap <C-J> xp`[V`]

" Search for what is visually selected.
vnorem // y/<C-R>"<CR>

" Jump to definition under the cursor.
nmap gt :tag <C-R><C-W><CR>

" Key mappings and settings for CtrlP
nmap <Leader>p :CtrlP<CR>
nmap <Leader>o :CtrlPTag<CR>
nmap <Leader>l :CtrlPLine<CR>
nmap <Leader>r :CtrlPMRU<CR>
let g:ctrlp_max_files = 50000
let g:ctrlp_max_height = 20
if executable('ag')
  let g:ctrlp_user_command = 'ag %s --nocolor --hidden --ignore .git -g ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --others --exclude-standard']
endif

imap <C-C> <Esc>

nmap <Leader>t :!rspec<CR>

" Yank to clipboard.
vmap <Leader>y "*y

nmap <Leader>m :nohlsearch<CR>

" Flip through buffers.
nmap <Leader>j :bn<CR>
nmap <Leader>k :bp<CR>

nmap <Leader><Tab> :tabn<CR>

nmap <Leader>w :set wrap!<CR>
" }}}

" Multipurpose tab key {{{
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction
inoremap <Tab> <C-R>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-P>
" }}}

" Edit/view file in current directory {{{
cnoremap %% <C-R>=expand('%:h').'/'<CR>
map <Leader>e :edit %%
map <Leader>v :view %%
" }}}

" Rename current file {{{
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <Leader>n :call RenameFile()<CR>
" }}}

" Run an already mapped function in second tmux split {{{
function! RunMappedCommandInSecondTmuxSplit(map)
  let cmd = maparg(a:map)
  if cmd[:1] == ':!'
    let cmd = cmd[2:]
  endif
  if cmd[-4:] == '<CR>'
    let cmd = cmd[:-5]
  endif
  let num_panes = system('tmux list-panes | wc -l | tr -s " "')[1:][:-2]
  if num_panes == '2'
    silent system('tmux send-keys -t bottom C-Z C-U C-L "' . cmd . '" C-M')
    redraw!
  else
    echoerr 'Current window needs two panes (has ' . num_panes. ') to run: ' . cmd
  endif
endfunction
map <Leader><Leader>t :call RunMappedCommandInSecondTmuxSplit('<Leader>t')<CR>
" }}}

" YAPF
" See: https://github.com/google/yapf/tree/master/plugins
map <C-Y> :call yapf#YAPF()<CR>

" clang-format
" See: https://clang.llvm.org/docs/ClangFormat.html#vim-integration
map <Leader>f :py3f /usr/share/vim/addons/syntax/clang-format.py<CR>

" colorcolumn
set textwidth=80
set colorcolumn=0
highlight ColorColumn ctermbg=232
nnoremap <leader>c :call ColorColumnToggle()<cr>
let g:colorcolumn_is_active = 0
function! ColorColumnToggle()
  if g:colorcolumn_is_active
    set colorcolumn=
    let g:colorcolumn_is_active = 0
  else
    set colorcolumn=+1,+21,+41
    let g:colorcolumn_is_active = 1
  endif
endfunction
