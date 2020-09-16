set nocompatible              " required?
filetype off                  " required?

" ============== Backup ==============
" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile
set directory^=~/.vim/swap//
" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup

" ============== Editing, Moving around ==============
" enable backspacing on existing text besides start of insert, so that
" deletion behavior via CTRL-W and CTRL-H is more ergonomic 
set backspace=indent,eol,start,nostop
" key combos used in navigation of multiple splited panels
" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" nature split opening
set splitbelow
set splitright
" General indent
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" For editing web content, shell scripts and config files
au BufNewFile,BufRead *.json,*.yml,*.yaml,*.html,*.haml,*.css,*.xml,*.sh,*.conf:
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal shiftwidth=2 |
" Pretty your code
syntax on
" enable line number
set nu
"Enable UTF-8 support
set encoding=utf-8
" Enable accessing the system's clipboard
set clipboard=unnamed
" disable statusline as there is no much useful information
set laststatus=0
" Highlight the line we are in
set cursorline
" adjust the background and foreground of cursorline so that writing becomes
" more comfortable
" http://vim.wikia.com/wiki/Highlight_current_line
hi CursorLine term=bold cterm=bold ctermbg=black guibg=black
" Highlight all the search matches
set hlsearch
hi Search guibg=Red
" highlight when we enter character
set incsearch
" search for selected text in visual mode
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" quickfix shortcuts - navigate through the errors displayed in quickfix
" buffer
nnoremap ]q :cnext<cr>
nnoremap ]Q :clast<cr>
nnoremap [q :cprev<cr>
nnoremap [Q :cfirst<cr>

" Config leader key for rich mappings
let mapleader=' '

" ============== Plugins (and their tweaks) ==============
" https://github.com/junegunn/vim-plug
" Initialize plugin system
call plug#begin('~/.vim/plugs')
" Use awesome vim color schemes
Plug 'rafi/awesome-vim-colorschemes'
" fast word quoting / wrapping
Plug 'tpope/vim-surround'
" auto pair braces
Plug 'jiangmiao/auto-pairs'
" Enable super(fuzzy) searching in VIM by ctrl + p, which similar to Sublime
Plug 'kien/ctrlp.vim'
" enable better json view
Plug 'elzr/vim-json', { 'for': 'json' }
" Enable tagbar so that we can see the tag structure of a file(useful if we are
" inspecting a module
Plug 'majutsushi/tagbar', { 'for': ['go', 'c', 'python'] }
" vim-go https://github.com/fatih/vim-go
Plug 'fatih/vim-go', { 'for': 'go' }
" auto-completion
Plug 'ycm-core/YouCompleteMe', { 'for': ['go', 'c'] }
call plug#end()

" TODO: execute config setup only for file types that really need it
" press F8 to tag bar
nnoremap <F8> :TagbarToggle<CR>
" put the tagbar panel on the left of editor panel
let g:tagbar_left=1
" gopls LSP integration
" https://github.com/golang/go/wiki/gopls
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" https://github.com/ycm-core/YouCompleteMe#the-gycm_filetype_whitelist-option
let g:ycm_filetype_whitelist = {
    \   'go':   1,
    \   'c':    1
    \   }

" ============== Productivity ==============
" faster save
nnoremap <Leader>w :w<CR>
" faster save and quit
nnoremap <Leader>q :wq<CR>
" faster forced quit. Watch out for your unsaved changes!
nnoremap <Leader>Q :q!<CR>
" faster panel splits
nnoremap <Leader>v :vsplit<Space>
nnoremap <Leader>V :split<Space>
" execute shell command and output the result in new scratch buffer, split in vertical
command -nargs=* Vexc vnew | 0r! <args>
nnoremap <Leader>e :Vexc<Space>
" open a vertical termianl window
command Vter vertical terminal
nnoremap <Leader>t :Vter<CR>
" jsonify text
nnoremap =j :%!python3 -m json.tool<CR>

" ============== Looks ==============
" for vim 8
if (has("termguicolors"))
  set termguicolors
endif
colorscheme deus
let g:deus_termcolors=256
