" Daryl's vimrc file.

" TODO: fully replace ~/.vimcomp with ~/.local.vim
let vimcomp="default"
source ~/.vimcomp

"=== Plugins ==="
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'

" TODO: learn how to use this one (git commands)
Plugin 'tpope/vim-fugitive'

" Extra bindings around '[' and ']'
Plugin 'tpope/vim-unimpaired'

" <leader>c* commenting coolness
Plugin 'scrooloose/nerdcommenter'
  let g:NERDSpaceDelims = 1

" Improved status line -- so pretty!
Plugin 'bling/vim-airline'
  set laststatus=2
  set t_Co=256
  let g:airline_powerline_fonts = 1

" Better handling of .csv files
Plugin 'csv.vim'
  hi CSVColumnEven term=bold ctermbg=4 guibg=DarkBlue
  hi CSVColumnOdd  term=bold ctermbg=5 guibg=DarkMagenta
  hi CSVColumnHeaderEven term=bold ctermbg=4 guibg=DarkBlue
  hi CSVColumnHeaderOdd term=bold ctermbg=5 guibg=DarkMagenta

" TODO: More plugins go here!
" Ultisnips: boilerplate stuff
" Eclim?
" NerdTree?

call vundle#end()

" If there's per-machine configuration, do it now (after Vundle)
" e.g. work-specific settings, chromeOS workarounds
if filereadable(expand('~/.local.vim'))
  source ~/.local.vim
endif

" Magic post-plugin incantation
filetype plugin indent on

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

" Prettier colors
colorscheme desert
set background=dark

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

" Resizing windows
map <leader>h <C-W><
map <leader>j <C-W>+
map <leader>k <C-W>-
map <leader>l <C-W>>

" Tab-completion for filenames
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc

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
let g:EclimJavaCheckstyleOnSave = 1

"=== Extra commands and such ==="

" :Dir will switch to the directory containing the current file
command! -nargs=0 -bar Dir :e %:p:h

" shift is evil
nnoremap ; :
" \/ wipes search highlighting
nmap <silent> <leader>/ :nohlsearch<CR>

set pastetoggle=<F2>
if vimcomp == "crouton"
  set pastetoggle=<leader>2
endif

" Commenting blocks of code. Taken from StackOverflow
" Resets the search history, which is obnoxious.
" My google ~/.local.vim has a better alternative
if vimcomp != 'google'
  autocmd FileType c,cpp,java,scala,h let b:comment_leader = '// '
  autocmd FileType sh,ruby,python     let b:comment_leader = '# '
  autocmd FileType conf,fstab         let b:comment_leader = '# '
  autocmd FileType tex                let b:comment_leader = '% '
  autocmd FileType mail               let b:comment_leader = '> '
  autocmd FileType vim                let b:comment_leader = '" '
  noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
  noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
endif
