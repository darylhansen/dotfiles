" Daryl's vimrc file.

call pathogen#infect()

source robert/vimrc

"=== Appearance settings ==="
" Indentation settings
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set cindent
set smartindent
set autoindent

set ruler
set number

" Search settings
set hlsearch
set ignorecase
set smartcase
set gdefault                    " search/replace "globally" (on a line) by default

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

syntax enable

" Highlight whitespace at end of line in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Trying to make maven work with vim
set makeprg=mvn\ compile\ -q\ -f\ pom.xml
set errorformat=[ERROR]\ %f:[%l%.%c]%m

" Compatibility for eclim
filetype plugin on
let g:EclimJavaCheckstyleOnSave = 1

"=== Extra commands and such ==="

" :Dir will switch to the directory containing the current file
command! -nargs=0 -bar Dir :e %:p:h

" shift is evil
nnoremap ; :
" \/ wipes search highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

set pastetoggle=<F2>

