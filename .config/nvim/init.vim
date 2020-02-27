"
" Neovim configuration file
"

"
" Auto-install vim-plug
"

if ! filereadable(expand("$HOME/.local/share/nvim/autoload/plug.vim"))
  echo "Installing vim-plug"
  silent !curl -fLo ${HOME}/.local/share/nvim/autoload/plug.vim --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif

"
" Plugins
"

source $HOME/.local/share/nvim/autoload/plug.vim

call plug#begin('~/.local/share/nvim/plug')

  " Code completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Fuzzy finder
  " Requires <https://github.com/junegunn/fzf>
  Plug 'junegunn/fzf.vim'

  " Statusline
  Plug 'itchyny/lightline.vim'

  " File tree
  Plug 'preservim/nerdtree'

  " Focus editing
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'

  " Comments
  Plug 'tpope/vim-commentary'

  " Surroundings (brackets, quotes, etc.)
  Plug 'tpope/vim-surround'

  " Cursor
  Plug 'terryma/vim-multiple-cursors'

call plug#end()

"
" Leader key
"

let mapleader = " "

"
" Basics
"

  set nocompatible
  filetype plugin on
  filetype indent on
  syntax on
  set encoding=utf-8
  set splitbelow splitright
  set nowrap
  set wildmode=longest,list,full
  set lazyredraw
  set ignorecase
  set background=dark
  set mouse=a
  set guioptions=a

"
" Tabs
"

  " Use two spaces instead of tabs.
  set tabstop=2
  set softtabstop=2
  set shiftwidth=2
  set expandtab

  " Use eight wide tab characters in Makefiles.
  autocmd FileType make set tabstop=8 softtabstop=8 shiftwidth=0 noexpandtab

"
" Invisible characters
"

  " Display invisible characters.
  set listchars=eol:¬,tab:»\ ,trail:∙,extends:›,precedes:‹

  " Toggle invisible characters.
  map <leader>; :set list!<CR>

"
" Line numbers
"

  " Turn on hybrid line numbers.
  set number relativenumber

  " Toggle between hybrid and absolute line numbers.
  map <leader>/ :set number relativenumber!<CR>

"
" Comments
"

  " Disable comments on newline.
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"
" Goyo
"

  map <leader>f :Goyo<CR>

  function! g:GoyoEnter()

    " Basics
    set background=light
    set nolist
    Limelight

    " Linenumbers
    set nonumber norelativenumber
    map <leader>/ :set number!<CR>

    " Quit vim with `:q`
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

  endfunction

  function! g:GoyoLeave()

    " Basics
    set background=dark
    Limelight!

    " Linenumbers
    set number relativenumber
    map <leader>/ :set number relativenumber!<CR>

    " Quit vim with `:q`
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      if b:quitting_bang
        qa!
      else
      qa
      endif
    endif

  endfunction

  autocmd! User GoyoEnter call g:GoyoEnter()
  autocmd! User GoyoLeave call g:GoyoLeave()

"
" Limelight
"

  let g:limelight_conceal_ctermfg = 'darkgray'

