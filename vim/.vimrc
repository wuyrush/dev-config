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
" enable relative line number so that jumping by number become eaiser
set number relativenumber
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
Plug 'majutsushi/tagbar', { 'for': ['go', 'c', 'python', 'rust'] }
" Language Server Protocol plugins
" supported commands see https://github.com/prabirshrestha/vim-lsp#supported-commands
Plug 'prabirshrestha/vim-lsp', { 'for': ['rust', 'go', 'c'] }
Plug 'mattn/vim-lsp-settings', { 'for': ['rust', 'go', 'c'] }
" auto-completion on edit
Plug 'prabirshrestha/asyncomplete.vim', { 'for': ['rust', 'go', 'c'] }
Plug 'prabirshrestha/asyncomplete-lsp.vim', { 'for': ['rust', 'go', 'c'] }

call plug#end()

" below list less commonly used but still useful plugins
" multi-cursor editing support
" NOTE try using vim builtin feature like macros to fulfill multi-spot-editing
" need instead of just relying on plugins. Read the manual Luke.
"Plug 'mg979/vim-visual-multi'
" edit html markup faster
"Plug 'mattn/emmet-vim', { 'for': ['html'] }
" use lsp for any language-specific features
" vim-go https://github.com/fatih/vim-go
"Plug 'fatih/vim-go', { 'for': 'go' }
" rustlang
"Plug 'rust-lang/rust.vim', { 'for': ['rust'] }

" golang gopls LSP integration
" https://github.com/golang/go/wiki/gopls
"let g:go_def_mode='gopls'
"let g:go_info_mode='gopls'

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
" faster edit
nnoremap <Leader>e :edit<Space>
" execute shell command and output the result in new scratch buffer, split in vertical
command -nargs=* Vexc vnew | 0r! <args>
nnoremap <Leader>E :Vexc<Space>
" split and edit buffer
nnoremap <Leader>b :sb<Space>
" dim all highlights
nnoremap <Leader>n :nohl<CR>
" open a vertical termianl window
command Vter vertical terminal
nnoremap <Leader>t :Vter<CR>
" open a horizontal terminal
nnoremap <Leader>T :terminal<CR>
" jsonify text
nnoremap =j :%!python3 -m json.tool<CR>
" press F8 to tag bar
nnoremap <F8> :TagbarToggle<CR>
" put the tagbar panel on the left of editor panel
let g:tagbar_left=1
" lsp mapping setups 
" https://github.com/prabirshrestha/vim-lsp#registering-servers
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> gf <plug>(lsp-document-diagnostics)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-v> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    " abort formatting if not done in 1s
    let g:lsp_format_sync_timeout = 1000
    " formatting selected file types on save
    autocmd! BufWritePre *.rs,*.go,*.c,*.h call execute('LspDocumentFormatSync')
    " TODO refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" quickfix shortcuts - navigate through the errors displayed in quickfix
" buffer
"nnoremap ]q :cnext<cr>
"nnoremap ]Q :clast<cr>
"nnoremap [q :cprev<cr>
"nnoremap [Q :cfirst<cr>

" ============== Looks ==============
" for vim 8
if (has("termguicolors"))
  set termguicolors
endif
colorscheme deus
let g:deus_termcolors=256
