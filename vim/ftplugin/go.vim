" Set according to Google Go codestyle
" Well, after using vim-go we may no longer need this; We can just keep the tagbar support

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal wrap
setlocal tw=110
setlocal fo+=t
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix

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

