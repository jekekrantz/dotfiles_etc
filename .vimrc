"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'                " Vundle
Plugin 'Valloric/YouCompleteMe'           " Smart autocompleter
Plugin 'SirVer/ultisnips'                 " snippets engine
" Plugin 'altercation/vim-colors-solarized' " humane colors
Plugin 'Raimondi/delimitMate'             " handle pairs of parens, quotes, etc.
Plugin 'epeli/slimux'                     " send text/buffers to tmux
Plugin 'haya14busa/incsearch.vim'         " incremental search: awesome!
Plugin 'mindriot101/vim-yapf'             " Python's answer to clang-format (code formatter)
Plugin 'nvie/vim-flake8'                  " Python code sanitizer
Plugin 'pangloss/vim-javascript'          " JavaScript mode
Plugin 'mxw/vim-jsx'                      " JSX mode
Plugin 'ternjs/tern_for_vim'              " JavaScript auto-completer
Plugin 'guns/vim-clojure-static'          " Clojure/Script love
Plugin 'JuliaLang/julia-vim'              " Julia mode
Plugin 'tikhomirov/vim-glsl'              " GLSL mode (for writing OpenGL shaders)
Plugin 'kien/rainbow_parentheses.vim'     " Trying out

Plugin 'tpope/vim-sexp-mappings-for-regular-people' " Trying out

call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Customize Vundle'd apps and external apps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="horizontal"

" If you have `brew install clang-format` (and why don't you?)
map <C-K> :pyf ~/bin/clang-format.py<cr>
imap <C-K> <c-o>:pyf ~/bin/clang-format.py<cr>

" And for incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" For YouCompleteMe messes
set shortmess+=c

" For Matlab and Markdown, set textwidth to super-high so vim doesn't
" auto-linebreak.
autocmd Filetype matlab setlocal tw=5000
autocmd Filetype markdown setlocal tw=5000 nosi

" For Clojure indentation magic
let g:clojure_align_multiline_strings = 1
let g:clojure_align_subforms = 0
let g:clojure_syntax_keywords = {
    \ 'clojureMacro': ["defproject", "defcustom", "defui"],
    \ 'clojureFunc': ["string/join", "string/replace", "render", "query"]
    \ }

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" For vim-jsx
let g:jsx_ext_required = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"       From https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Backup files
set backupdir=~/.backup,.,/tmp
set directory=~/.backup,.,/tmp

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set so=0

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l,[,]

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Relative line numbers
" set rnu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

set background=light
try
    " colorscheme desert
    colorscheme solarized
catch
endtry

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=80

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Useful mappings for managing tabs
map <A-D-Right> :tabnext<cr>
map <A-D-Left> :tabprevious<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=%{HasPaste()}%t%m%r%h%w\ %l,%c,%p%%\ %y


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Comment out <ignore> tags
" Combined http://arjanvandergaag.nl/blog/vim-advanced-search-and-replace.html and http://vim.wikia.com/wiki/Power_of_g
function! CommentIgnore()
    g/^%\+<ignore>/.,/<\/ignore>$/s!^!%! 
endfunction

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
set number

