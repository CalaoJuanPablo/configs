set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set laststatus=2
"set noshowmode

call plug#begin('~/.vim/plugged')

" Themes and syntax
Plug 'patstockwell/vim-monokai-tasty'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components'
Plug 'elzr/vim-json'
Plug 'jparise/vim-graphql'

" IDE
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let mapleader=" "

" Theme config
let g:vim_monokai_tasty_italic = 1
colorscheme vim-monokai-tasty

" COC configuration
let g:coc_global_extensions = ['coc-tsserver']

" Easymotion config
nmap <Leader>s <Plug>(easymotion-s2)

" Nerdtree
nmap <Leader>b :NERDTreeFind<CR>
" to open the menu in nerdtreee press `m`
let NERDTreeQuitOnOpen=1

" Fuzzy Finder
nmap <Leader>p :Files<CR>

" Airline theme
let g:airline_theme='minimalist'
let g:airline_powerline_fonts=1
" Custom keymaps
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>gs :CocSearch
nmap <Leader>fs :Files<CR>

" GoTo Code Navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

