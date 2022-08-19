call plug#begin("~/.vim/plugged")
	" Plugin Section
	Plug 'joshdick/onedark.vim'
	Plug 'scrooloose/nerdtree'
	Plug 'itchyny/lightline.vim'
	Plug 'maximbaz/lightline-ale'
	Plug 'dense-analysis/ale'
	Plug 'ryanoasis/vim-devicons'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'easymotion/vim-easymotion'
	Plug 'editorconfig/editorconfig-vim'
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'
	Plug 'dyng/ctrlsf.vim'
	Plug 'raimondi/delimitMate'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'leafgarland/typescript-vim'
	Plug 'peitalin/vim-jsx-typescript'
	Plug 'clangd/coc-clangd'
	Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
	Plug 'sheerun/vim-polyglot'
	Plug 'puremourning/vimspector'
	Plug 'vim-test/vim-test'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
	Plug 'lervag/vimtex'
	Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
	Plug 'alvan/vim-closetag'
call plug#end()

"Config Section
if (has("termguicolors"))
	set termguicolors
endif
syntax on
colorscheme onedark

let mapleader = ","
let maplocalleader = ","
set number
set number relativenumber
set hlsearch
set incsearch
set ignorecase
set smartcase
set autowrite
set autoindent
set ruler
set confirm
set laststatus=2
set showmode
set showcmd
set spelllang=en
set hidden
set list
set listchars=tab:\|-
set listchars+=space:·
set tabstop=4 softtabstop=0 shiftwidth=4 smarttab
set encoding=utf-8
set fileformat=unix
set fileformats=unix,dos
set clipboard^=unnamed,unnamedplus

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeShowLineNumbers=1

" Autosave on focus lost
autocmd BufLeave,FocusLost * silent! wall

" Toggle spellcheck
nnoremap <silent> <F2> :set spell!<cr>
inoremap <silent> <F2> <C-O>:set spell!<cr>

" Use relative line numbers in nerdtree
autocmd FileType nerdtree setlocal relativenumber
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" Terminal
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
	if has('win64') " Use powershell on windows
		split term://powershell
	else
		split term://zsh
	endif
	resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>


" Lightline config
let g:lightline = { 'colorscheme': 'onedark' }

let g:lightline.component_expand = {
\	'gitbranch': 'FugitiveHead',
\	'linter_checking': 'lightline#ale#checking',
\	'linter_infos': 'lightline#ale#infos',
\	'linter_warnings': 'lightline#ale#warnings',
\	'linter_errors': 'lightline#ale#errors',
\	'linter_ok': 'lightline#ale#ok',
\}

let g:lightline.component_type = {
\	'linter_checking': 'right',
\	'linter_infos': 'right',
\	'linter_warnings': 'warning',
\	'linter_errors': 'error',
\	'linter_ok': 'right',
\}

let g:lightline.active = { 
\	'left': [ 
\		[ 'mode', 'paste' ],
\		[ 'gitbranch', 'readonly', 'filename', 'modified' ],
\	],
\	'right': [
\		[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
\		[ 'lineinfo' ],
\		[ 'percent' ],
\		[ 'fileformat', 'fileencoding', 'filetype' ],
\	],
\}

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

" Airline config
let g:airline_theme='onedark'

" Debugger
let g:vimspector_enable_mappings = 'HUMAN'

" vim-test keybinds
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" Move window
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
map si <C-w>+
map su <C-w>-
map so <C-w><
map sp <C-w>>

" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-

" open new split panes to right and below
set splitright
set splitbelow

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Git shortcuts
nmap <leader>gb :Gblame<CR>
nmap <leader>gs :G<CR>
nmap <leader>gc :Gvdiff<CR>

" Markdown preview keybinds
nmap <leader>mp :MarkdownPreviewToggle<CR>

" Jump to latest edit
nmap <Tab> '.

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nnoremap <space> <NOP>
nmap <space> <Plug>(easymotion-jumptoanywhere)
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys = 'hklyuiopnmqwertzxcvbasdjf'
let g:EasyMotion_re_anywhere = '\v' .
\'(<.|^$)' . '|' .
\'(_\zs.)' . '|' .
\'(#\zs.)'

" hide search highlighting on escape
nnoremap <Esc> :noh<CR>

" search
nnoremap <C-o> :FZF<CR>
let g:fzf_action = {
\	'ctrl-t': 'tab split',
\	'ctrl-s': 'split',
\	'ctrl-v': 'vsplit'
\}
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" global search
nnoremap <C-p> :CtrlSF<Space>

" go to definition global
nnoremap <leader>gd :ALEGoToDefinition<CR>

" latex preview
let g:vimtex_view_method = 'zathura'
let g:livepreview_previewer = 'zathura'
nmap <leader>lc :VimtexCompile<CR>
nmap <leader>lp :LLPStartPreview<CR>

" Spellchecking
set spelllang=en,de
set spellsuggest=best,9
nnoremap <silent> <leader>sc :set spell!<cr>

" CoC config
let g:coc_global_extensions = [
\	'coc-clangd',
\	'coc-cmake',
\	'coc-css',
\	'coc-docker',
\	'coc-eslint',
\	'coc-go',
\	'coc-html',
\	'coc-json',
\	'coc-java',
\	'coc-markdownlint',
\	'coc-prettier',
\	'coc-spell-checker',
\	'coc-cspell-dicts',
\	'coc-swagger',
\	'coc-sql',
\	'coc-sh',
\	'coc-tsserver',
\	'coc-yaml',
\	'coc-xml',
\	'coc-vimlsp',
\	'coc-vimtex',
\]
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Show element type on which the cursor is located
map <F1> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Colorscheme modifications
"hi Constant ctermfg=214 guifg=#e5c07b
"hi Type ctermfg=214 guifg=#e5c07b
"hi Identifier ctermfg=214 guifg=#e5c07b
"hi Structure ctermfg=214 guifg=#e5c07b

"hi Statement ctermfg=160 guifg=#e06c75
"hi Include ctermfg=160 guifg=#e06c75
"hi Function ctermfg=160 guifg=#e06c75

"hi StorageClass ctermfg=15 guifg=#aab2bf

