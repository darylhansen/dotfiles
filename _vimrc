" Daryl's vimrc file.

call pathogen#infect()

" source ~/.vim/robert/vimrc
" call pathogen#infect('~/.vim/robert/bundle')

" Add the common tagfile -- this is specific to Daryl's Wibi laptop.
set tags+=~/.tags

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

" Resizing windows
map <leader>h <C-W><
map <leader>j <C-W>+
map <leader>k <C-W>-
map <leader>l <C-W>>

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

" Easily switch between a .cc and its corresponding .h file.
" If I knew how to vimscript properly this would be one function,
" not two. Also, good luck if you use .c or .cpp instead of .cc
" TODO: strip the _test in foo_test.cc
:fu! GetTwinFile()
   let ext = expand("%:e")
:  if ext == "cc"
:    return expand("%:r") . ".h"
:  endif
:  if ext == "h" 
:    return expand("%:r") . ".cc"
:  endif
:  return expand("%")
:endf

:fu! Switch2Twin()
:  e `=GetTwinFile()`
:endf

:fu! GetTestFile()
  let ext = expand("%:e")
: if ext != "cc" && ext != "h" 
:   return expand("%")
: endif
: let root = expand("%:r")
: let idx = match(root, "_test")
: if idx == -1
:  return root . "_test.cc"
: endif
: return root[0:idx-1] . ".cc"
:endf

:fu! Switch2Test()
:  e `=GetTestFile()`
:endf

nnoremap <leader>s :call Switch2Twin()<CR>
nnoremap <leader>t :call Switch2Test()<CR>

" Commenting blocks of code. Taken from StackOverflow
" Resets the search history, which is obnoxious.
autocmd FileType c,cpp,java,scala,h let b:comment_leader = '// '
autocmd FileType sh,ruby,python     let b:comment_leader = '# '
autocmd FileType conf,fstab         let b:comment_leader = '# '
autocmd FileType tex                let b:comment_leader = '% '
autocmd FileType mail               let b:comment_leader = '> '
autocmd FileType vim                let b:comment_leader = '" '
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

