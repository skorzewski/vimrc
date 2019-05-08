" author: Paweł Skórzewski

" vi compatibility
set nocompatible " vim instead of vi
filetype off " for plugins

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugins
Plugin 'vim-airline/vim-airline' " powerline
Plugin 'vim-airline/vim-airline-themes' " powerline themes
Plugin 'powerline/fonts' " fancy status line and its special fonts
Plugin 'tpope/vim-fugitive' " Git integration
Plugin 'airblade/vim-gitgutter' " Git gutter
Plugin 'scrooloose/nerdtree' " file system explorer
Plugin 'scrooloose/syntastic' " syntax checker
Plugin 'tomtom/tcomment_vim' " easier comments
Plugin 'terryma/vim-multiple-cursors' " multiple cursors
Plugin 'FSwitch' " switch between header and .cpp files
Plugin 'nvie/vim-flake8' " PEP8 style & syntax checker
Plugin 'Chiel92/vim-autoformat' " code autoformatter
Plugin 'hynek/vim-python-pep8-indent' " PEP8 autoindent
Plugin 'maxbrunsfeld/vim-yankstack' " history of yanks
Plugin 'chriskempson/base16-vim' " Base16 color scheme
Plugin 'altercation/vim-colors-solarized' " Solarized color scheme
" Plugin 'jacoborus/tender.vim' " Tender color scheme

call vundle#end()

filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line

" UTF-8 encoding
set enc=utf-8
" set fenc=utf-8
set termencoding=utf-8

" basic options
syntax on " syntax highlighting
set laststatus=2 " always show status line
set number " show line numbers
set nomousehide " don't hide mouse cursor
set winaltkeys=no " don't map Alt+_ to menu bar

" searching
set hlsearch " highlight searched terms
set incsearch " go to searched term
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" ignorecase if lowercase
set ignorecase
set smartcase

" show vim commands
set showcmd

" smart indentation
set autoindent " copy indent from current line when starting a new line
set expandtab " inserts spaces instead of tabs
set shiftwidth=4 " indentation (>>) is 4 spaces
set tabstop=4 " tab is 4 spaces long

" F1 toggles file system tree
map <F1> :NERDTreeToggle<CR>
" Ctrl+B toggles file system tree
map <C-b> :NERDTreeToggle<CR>

" Remove trailing spaces
function! RemoveTrailingWhitespaces()
    if (
                \ &ft != 'make' &&
                \ &ft != 'markdown' &&
                \ &ft != 'text')
        %s/\s\+$//e
    endif
endfunction

" F2 saves file:
" in normal mode F2 will save the file
nmap <F2> :call RemoveTrailingWhitespaces()<CR>:w<CR>
" in insert mode F2 will switch to normal mode and save
imap <F2> <ESC>:call RemoveTrailingWhitespaces()<CR>:w<CR>

" Ctrl+S saves file:
" in normal mode Ctrl+S will save the file
nmap <C-s> :call RemoveTrailingWhitespaces()<CR>:w<CR>
" in insert mode Ctrl+S will switch to normal mode and save
imap <C-s> <ESC>:call RemoveTrailingWhitespaces()<CR>:w<CR>

" Adtech style code autoformatting
nmap <F3> :%!astyle --indent=spaces=4 --style=google --add-brackets<CR>
imap <F3> <ESC>:%!astyle --indent=spaces=4 --style=google --add-brackets<CR>

noremap <F3> :Autoformat<CR><CR>
let g:formatprg_cpp = "astyle"
let g:formatprg_args_cpp = system('cat ~/.astylerc | grep -v "^#.*" | grep -z')

" G2P style code autoformatting
" nmap <F3> :%!astyle --indent=tab --style=stroustrup --break-closing-brackets --add-brackets<CR>
" imap <F3> <ESC>:%!astyle --indent=tab --style=stroustrup --break-closing-brackets --add-brackets<CR>

" Stroustrup-K&R style for C code in G2P
" let g:formatprg_args_c = "--indent=tab --style=stroustrup --break-closing-brackets --add-brackets"
" Code autoformatting
" noremap <F3> :Autoformat<CR><CR>

" Ctrl+arrows scroll
nnoremap <C-Down> <C-e>
nnoremap <C-Up> <C-y>

" FSwitch settings
let b:fsnonewfiles=1
au BufEnter *.c let b:fswitchdst = 'h'
au BufEnter *.cpp,*.tpl let b:fswitchdst = 'hpp,h'
au BufEnter *.h let b:fswitchdst = 'c,cpp'
au BufEnter *.hpp let b:fswitchdst = 'cpp'
au BufEnter *.hpp let b:fswitchlocs = 'reg:/include/src/,reg:/include.*/src/,../src'
nnoremap gh :FSHere<cr>
nnoremap gH :FSRight<cr>

" diff shortcuts
nnoremap gv :diffoff!<CR>
nnoremap gV :diffthis<CR><C-w><C-w>:diffthis<CR>:diffupdate<CR><C-w><C-w>

" font adjustment
nnoremap g- :set guifont=Ubuntu\ Mono\ 9<CR>
nnoremap g= :set guifont=Ubuntu\ Mono\ 12<CR>

" Syntastic settings
let g:syntastic_cpp_checkers = ['gcc', 'cppcheck']
let g:syntastic_cpp_compiler_options = ' -std=c++14'
let g:syntastic_python_checkers = ['python3', 'pep8', 'pylint3']
let g:syntastic_python_pylint_args = '-disable=star-args'

" color scheme
set background=dark
colorscheme default

" Show trailing spaces
match ErrorMsg '\s\+$'

" GUI options
let g:airline_powerline_fonts = 0
" set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
set guifont=Ubuntu\ Mono\ 12
if has('gui_running')
    set background=dark
    colorscheme base16-material-darker
    let g:airline_theme="powerlineish"
    " colorscheme tender
    " let g:airline_theme="tender"
    set guioptions-=T " remove toolbar
    set guioptions-=L " remove left scrollbar
    set guioptions-=r " remove right scrollbar
else
    " Airline color scheme
    set t_Co=16
    colorscheme default
    let g:airline_theme="term"
endif

" file types
au BufNewFile,BufRead *.conf set filetype=cfg
au BufNewFile,BufRead *.gra set filetype=cfg
au BufNewFile,BufRead *.grm set filetype=thraxgrm
au BufNewFile,BufRead *.i set filetype=conf
au BufNewFile,BufRead *.jsgf set filetype=jsgf
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdown set filetype=markdown
au BufNewFile,BufRead *.thrift set filetype=thrift
au BufNewFile,BufRead *.tpg set filetype=tokenpattern
au BufNewFile,BufRead *.tpl set filetype=cpp
au BufNewFile,BufRead *.xargs set filetype=xml
au BufNewFile,BufRead *jenkinsfile set filetype=groovy
au BufNewFile,BufRead *Jenkinsfile set filetype=groovy
au BufNewFile,BufRead README set filetype=markdown
