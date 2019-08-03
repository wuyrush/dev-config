set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" enable code folding
Plugin 'tmhedberg/SimpylFold'

" enable autoindent
Plugin 'vim-scripts/indentpython.vim'

" enable auto-complete
Plugin 'Valloric/YouCompleteMe'

" enable vim to check your syntax
Plugin 'scrooloose/syntastic'

" Checking PEP8 syntax
Plugin 'nvie/vim-flake8'

" Use awesome vim color schemes
Plugin 'rafi/awesome-vim-colorschemes'

" Enable super(fuzzy) searching in VIM by ctrl + p, which similar to Sublime
Plugin 'kien/ctrlp.vim'

" Enable us to perform some git commands without leaving the comfort of vim.
" Use such command when there is not so much output generated. It also
" provides many shortcuts.
Plugin 'tpope/vim-fugitive'

" enable better json view
Plugin 'elzr/vim-json'

" Enable tagbar so that we can see the tag structure of a file(useful if we are
" inspecting a module
Plugin 'majutsushi/tagbar'

" Enable rainbow highlighting of matching parenthesis
Plugin 'luochen1990/rainbow'

" utils to speed up html / css workflow on vim 
Plugin 'mattn/emmet-vim'

" auto pair braces
Plugin 'jiangmiao/auto-pairs'

" vim-go https://github.com/fatih/vim-go
Plugin 'fatih/vim-go'

" Vim airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" key combos used in navigation of multiple splited panels
" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" force syntastic use Python3 checker
let g:syntastic_python_python_exec = '/usr/local/bin/python3' 

" enable emmet plugin just for html / css
"let g:user_emmet_install_global = 0
"autocmd FileType html.css EmmetInstall

" key combo for displaying the tag bar -- simply press F8
nmap <F8> :TagbarToggle<CR>
" put the tagbar panel on the left of editor panel
let g:tagbar_left=1

" Enable lighlighting of matching parentheses
let g:rainbow_active = 1

" Enable code folding
set foldmethod=indent
set foldlevel=99
" key binding to control folding
nnoremap <space> za

" enable viewing of docstring of folded code
let g:SimpylFold_docstring_preview=1

" General indent
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" For editing web content, shell scripts and config files
au BufNewFile,BufRead *.json,*.html,*.haml,*.css,*.xml,*.sh,*.conf:
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |

" Pretty your code
let python_highlight_all=1
syntax on

"define BadWhiteSpace before using a match
highlight BadWhitespace ctermbg=red guibg=red

" enable line number!
set nu
" Uncomment this line if you want to enable mouse in VIM
" set mouse=a

"Flag unnecessary spaces in Python code
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"Enable UTF-8 support. Important when working with Python 3.
set encoding=utf-8

" Enable accessing the system's clipboard
set clipboard=unnamed

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" for vim 8
if (has("termguicolors"))
  set termguicolors
endif

" Switch color scheme between GUI and terminal mode
if has('gui_running')
  set background=light
  colorscheme solarized8
else
  " let g:seoul256_background = 233
  colorscheme deus
  let g:deus_termcolors=256
endif

" Switch between Solarized dark and light theme by pressing F5
" call togglebg#map("<F5>")

" Always show statusline
set laststatus=2

" Config ctags to facilitate navigation in codebase
set tags=./tags,./TAGS,tags;~,TAGS;~

" Highlight the line we are in
:set cursorline
:set cursorcolumn
" adjust the background and foreground of cursorline so that writing becomes
" more comfortable!
" http://vim.wikia.com/wiki/Highlight_current_line
:hi CursorLine term=bold cterm=bold ctermbg=black guibg=black

" Highlight all the search matches
:set hlsearch
:hi Search guibg=Red

" highlight when we enter character
set incsearch

" nature split opening
set splitbelow
set splitright

" shortcut to jsonify text
nmap =j :%!python -m json.tool<CR>

" shortcut to open a vertical termianl window
command Vter vertical terminal

" gotags + tagbar
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" run goimports on save
" https://leanpub.com/productiongo/read#leanpub-auto-vim
let g:go_fmt_command="goimports"

" Vim airline buffer line
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='oceanicnext'
