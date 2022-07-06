" ==================== VIM PLUG ==================

call plug#begin('~/.vim/plugged')

" GitHub
Plug 'tpope/vim-fugitive'

" No distraction Mode
Plug 'junegunn/goyo.vim'

" FZF
Plug 'junegunn/fzf.vim'

" ale - linter / autocompletion / formatter
Plug 'w0rp/ale'

" nerd tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" surround vim
Plug 'tpope/vim-surround'

" airline (powerline)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" enhanced highlight
Plug 'octol/vim-cpp-enhanced-highlight'

" Themes
Plug 'arcticicestudio/nord-vim'

" Indent Guide
Plug 'nathanaelkane/vim-indent-guides'

" Auto save session
Plug 'thaerkh/vim-workspace'

" Auto insert backets, parens pair
Plug 'jiangmiao/auto-pairs'

" Async run
Plug 'skywind3000/asyncrun.vim'
Plug 'milkypostman/vim-togglelist'

" Repeat last command
Plug 'tpope/vim-repeat'

" using nnn-plug replace for the nerdtree
Plug 'mcchrish/nnn.vim'

" Smooth Scrool
Plug 'terryma/vim-smooth-scroll'

Plug 'gko/vim-coloresque'

call plug#end()
