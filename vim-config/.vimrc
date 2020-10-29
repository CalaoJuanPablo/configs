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
Plug 'cakebaker/scss-syntax.vim'

" IDE
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
"Plug 'tsony-tsonev/nerdtree-git-plugin'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-emmet'

call plug#end()

let mapleader=" "

" Theme config
let g:vim_monokai_tasty_italic = 1
colorscheme vim-monokai-tasty

" COC configuration
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ ]

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Easymotion config
nmap <Leader>s <Plug>(easymotion-s2)

" Nerdtree
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
nmap +- :NERDTreeToggle<CR>
" to open the menu in nerdtreee press `m`
let NERDTreeQuitOnOpen=1
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeGitStatusWithFlags = 1

" ctrlp ignore all git ignored files
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Airline theme
let g:airline_theme='minimalist'
let g:airline_powerline_fonts=1

" Custom keymaps
nmap <C-q> :q<CR>
nmap <Leader>gs :CocSearch
nmap <C-s> :%s/

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
