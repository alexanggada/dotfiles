"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Plugins                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')

" Editing
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'wellle/targets.vim'

" Utilities
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/vim-slash'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-surround'

" Visualization
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/rainbow_parentheses.vim'

" Navigation
Plug 'justinmk/vim-sneak'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plug 'jiangmiao/auto-pairs'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Plugin Settings                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tmux Navigator
if exists('$TMUX')
    function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
        call system("tmux select-pane -" . a:tmuxdir)
        redraw!
    endif
    endfunction

    let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
    let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
    let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

    nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
    nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
    nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
    nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
    tnoremap <silent> <C-h> <C-\><C-n>:call TmuxOrSplitSwitch('h', 'L')<cr>
    tnoremap <silent> <C-j> <C-\><C-n>:call TmuxOrSplitSwitch('j', 'D')<cr>
    tnoremap <silent> <C-k> <C-\><C-n>:call TmuxOrSplitSwitch('k', 'U')<cr>
    tnoremap <silent> <C-l> <C-\><C-n>:call TmuxOrSplitSwitch('l', 'R')<cr>
else
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
endif

" Lightline
" Remove --INSERT--
" set noshowmode

" Ale
let g:ale_linters = {
    \ 'python': ['pyflakes', 'mypy'],
    \ 'scala': ['scalastyle'],
    \ 'haskell': ['stack-ghc-mod', 'hlint']
    \ }
let g:ale_python_mypy_options = "Ðignore-missing-imports"
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '!!'
hi ALEErrorSign   ctermbg=234         ctermfg=9  guibg=234 guifg=9
hi ALEWarningSign ctermbg=234         ctermfg=11 guibg=234 guifg=11
hi ALEWarning     ctermbg=DarkMagenta guibg=DarkMagenta
let g:airline#extensions#ale#enabled = 1

" Slime
let g:slime_target = "tmux"
silent! let g:slime_default_config = {
    \ "socket_name": split($TMUX, ",")[0],
    \ "target_pane": ":0.1"
    \ }
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1

" FZF
let g:fzf_action = {
            \'enter': 'tabedit',
            \'ctrl-v': 'vsplit',
            \'ctrl-t': 'tabedit'}
nnoremap <Space>be :FZF<CR>
nnoremap <Space>bh :FZF ~<CR>

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 General Configs                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load vim configuration to nvim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Disable compatibility to old-time vi
set nocompatible

" Show matching brackets
set showmatch
	
" Case insensitive matching
set ignorecase

" Enable use of mouse for all modes
set mouse=a

" Highlight search results
set hlsearch

" Indentation settings
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set wildmode=longest,list   " get bash-like tab completions

" 80 column border
" set cc=80

" Allows auto-indenting depending on file type
filetype plugin indent on

" Syntax highlighting
syntax on

" Showing line numbers and length
set number
" set relativenumber
" set fo-=t

" Set line number color
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Makes copy and pasting work
set clipboard=unnamed
set clipboard+=unnamedplus

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Disable mouse middle click
:map <MiddleMouse> <Nop>
:imap <MiddleMouse> <Nop>
:map <2-MiddleMouse> <Nop>
:imap <2-MiddleMouse> <Nop>
:map <3-MiddleMouse> <Nop>
:imap <3-MiddleMouse> <Nop>
:map <4-MiddleMouse> <Nop>
:imap <4-MiddleMouse> <Nop>

" Change disable highlight command
:command Dhl nohlsearch

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Jumping between tabs
nnoremap ( :tabprevious<CR>
nnoremap ) :tabnext<CR>

" Set height of statusline
set cmdheight=1
