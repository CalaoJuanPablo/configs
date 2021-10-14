set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax on
set showcmd
set ruler
set encoding=utf-8
set showmatch
set cmdheight=1
set tabstop=2 softtabstop=4
set sw=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smartcase
set relativenumber
set nu
set nohlsearch
set laststatus=2
set hidden
set noerrorbells
set incsearch
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
set noshowmode

call plug#begin('~/.vim/plugged')

" Syntax
Plug 'sheerun/vim-polyglot'

" Themes
Plug 'navarasu/onedark.nvim'

" Status Bar
Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tree
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

" Type
Plug 'alvan/vim-closetag'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-emmet'

" IDE
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'

" Git
Plug 'mhinz/vim-signify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'zivyangll/git-blame.vim'

" Terminal
Plug 'voldikss/vim-floaterm'

call plug#end()

let mapleader=" "

" Theme config
set background=dark
set t_Co=256
let g:onedark_style = 'warmer'
colorscheme onedark
highlight Normal guibg=none

" Airline theme
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
let g:airline_section_b='%{GitBranch()}'

" COC configuration
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

  "Function that returns the current git branch
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Easymotion config
nmap <Leader>s <Plug>(easymotion-s2)

"Coc.vim configuration
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
"end of coc.vim config

" Nerdtree
nnoremap <leader>/ :call NERDComment(0,"toggle")<CR>
vnoremap <leader>/ :call NERDComment(0,"toggle")<CR>
nnoremap <leader>b :NERDTreeToggle<CR>
vnoremap <leader>b :NERDTreeToggle<CR>

" to open the menu in nerdtreee press `m`
"let NERDTreeQuitOnOpen=1
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeGitStatusWithFlags = 1
let NERDTreeShowHidden=1

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

"Open NerdTree when i open a folder
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"Close vim if the only window left its filetree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map <ScrollWheelDown> j
map <ScrollWheelUp> k

" fzf config
nmap <C-P> :GFiles<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Custom keymaps
nmap <Leader>gs :CocSearch
"nmap <C-s> :%s/

" GoTo Code Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
