"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Plugins                                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')

" Latex
Plug 'lervag/vimtex'

" Editing
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'wellle/targets.vim'

" Utilities
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/vim-slash'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] 
  \}
Plug 'Yggdroot/indentLine', { 
  \'for': ['javascript', 'typescript', 'typescript.tsx', 'html'] 
  \}
Plug 'jiangmiao/auto-pairs', {
  \'for': ['javascript', 'typescript', 'typescript.tsx', 'css', 'scss', 'graphql', 'vue', 'html'] 
  \}
Plug 'alvan/vim-closetag', {
  \'for': ['javascript', 'typescript', 'typescript.tsx', 'html'] 
  \}
Plug 'junegunn/vim-easy-align'
Plug 'preservim/nerdtree'
Plug 'voldikss/vim-floaterm'

" Visualization
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
" Plug 'kyazdani42/nvim-web-devicons'
" Plug 'romgrk/barbar.nvim'

" Navigation
Plug 'justinmk/vim-sneak'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Autocomplete with LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-prettier'
Plug 'neoclide/coc-eslint'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/deoplete-lsp'
" Plug 'neovim/nvim-lspconfig'

" Clojure
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'ncm2/float-preview.nvim'
Plug 'Olical/conjure', {'tag': 'v4.0.0'}
Plug 'eraserhd/parinfer-rust'
Plug 'junegunn/rainbow_parentheses.vim', { 'for': 'clojure' }
Plug 'luochen1990/rainbow', { 'for': 'clojure' }

" Javascript
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax

" Typescript
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'        " GraphQL syntax

" Elm
Plug 'elmcast/elm-vim'

" Colorschemes
Plug 'morhetz/gruvbox'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Plugin Settings                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" Tmux Navigator "
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

""" Lightline
" Remove --INSERT--
" set noshowmode

""" Ale
let g:ale_linters = {
    \ 'python': ['pyflakes', 'mypy'],
    \ 'scala': ['scalastyle'],
    \ 'haskell': ['stack-ghc-mod', 'hlint'],
    \ 'clojure': ['clj-kondo', 'joker']
    \}
    " \ 'html': ['htmlhint'],
    " \ 'css': ['stylelint'],
    " \ 'javascript': ['eslint'],
    " \ 'typescript': ['eslint']
let g:ale_python_mypy_options = "Ðignore-missing-imports"
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '!!'
hi ALEErrorSign   ctermbg=234         ctermfg=9  guibg=234 guifg=9
hi ALEWarningSign ctermbg=234         ctermfg=11 guibg=234 guifg=11
hi ALEWarning     ctermbg=DarkMagenta guibg=DarkMagenta
let g:airline#extensions#ale#enabled = 1

""" Slime
let g:slime_target = "tmux"
silent! let g:slime_default_config = {
    \ "socket_name": split($TMUX, ",")[0],
    \ "target_pane": ":0.1"
    \ }
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1

""" FZF
let g:fzf_action = {
            \'enter': 'tabedit',
            \'ctrl-v': 'vsplit',
            \'ctrl-t': 'tabedit'}
nnoremap <Space>be :FZF<CR>
nnoremap <Space>bh :FZF ~<CR>
" nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"

""" SuperTab
let g:SuperTabDefaultCompletionType = "<c-n>"

""" Deoplete
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
" set completeopt-=preview
" " Disable for Elm
" autocmd FileType elm
"        \ call deoplete#custom#buffer_option('auto_complete', v:false)

""" COC settings
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-html',
      \ 'coc-sql',
      \ 'coc-yaml',
      \ 'coc-go',
      \ 'coc-pyright',
      \ ]
" coc-prettier and coc-eslint
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif
" Show diagnostics if exists, otherwise show documentation
" nnoremap <silent> K :call CocAction('doHover')<CR>
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#util#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction
" Get definition, type, or references
nmap <silent> cd <Plug>(coc-definition)
nmap <silent> cy <Plug>(coc-type-definition)
nmap <silent> cr <Plug>(coc-references)
" " Code action, i.e. auto imports
nmap <leader>do <Plug>(coc-codeaction)

""" Float-preview
let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40

""" Conjure
let g:conjure#mapping#def_word = "d"
let g:conjure#log#hud#enabled = v:true
let g:conjure#log#hud#height = 0.95
nnoremap <Space>cc mwvip:ConjureEval<CR>'wzz
" Debug this to switch panes
nmap <Space>cl <Space>lv<C-W><C-H>:exe "vertical resize " . (winwidth(0) * 5/4)<CR>

""" Parinfer
let g:parinfer_mode = 'smart'
let g:parinfer_enabled = 1
let g:parinfer_force_balance = 0

""" Vim-sexp
let g:sexp_filetypes = ''

function! s:vim_sexp_mappings()
    nmap <silent><buffer> [[        <Plug>(sexp_move_to_prev_top_element)
    nmap <silent><buffer> ]]        <Plug>(sexp_move_to_next_top_element)
    nmap <silent><buffer> <Space>ih <Plug>(sexp_insert_at_list_head)
    nmap <silent><buffer> <Space>it <Plug>(sexp_insert_at_list_tail)
    nmap <silent><buffer> <Space>w( <Plug>(sexp_round_head_wrap_element)
    nmap <silent><buffer> <Space>w) <Plug>(sexp_round_tail_wrap_element)
    nmap <silent><buffer> <Space>w{ <Plug>(sexp_curly_head_wrap_element)
    nmap <silent><buffer> <Space>w} <Plug>(sexp_curly_tail_wrap_element)
    nmap <silent><buffer> <Space>w[ <Plug>(sexp_square_head_wrap_element)
    nmap <silent><buffer> <Space>w] <Plug>(sexp_square_tail_wrap_element)
    nmap <silent><buffer> <Space>rl <Plug>(sexp_raise_list)
    nmap <silent><buffer> <Space>re <Plug>(sexp_raise_element)

    nmap <buffer> {{ <Plug>(sexp_move_to_prev_element_head)
    nmap <buffer> }} <Plug>(sexp_move_to_next_element_head)
    nmap <buffer> s< <Plug>(sexp_swap_element_backward)
    nmap <buffer> s> <Plug>(sexp_swap_element_forward)

    nmap <buffer> >< <Plug>(sexp_emit_tail_element)
    nmap <buffer> <> <Plug>(sexp_capture_next_element)
endfunction

augroup VIM_SEXP_MAPPING
    autocmd!
    autocmd FileType clojure call s:vim_sexp_mappings()
augroup END

""" junegunn Rainbow pairs
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

""" ParcelJS
" Necessary for ParcelJS to work
set backupcopy=yes

""" Prettier
" Auto format all this files with Prettier asynchronously
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml PrettierAsync

""" vim-closetag
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.ts'
" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml'
" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx'
" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1
" Disables auto-close if not in a valid region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'
" Testing
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

""" indentLine
let g:indentLine_char = '¦'

""" Autopairs
" let g:AutoPairsMultilineClose = 0

""" barbar.nvim
" " Magic buffer-picking mode
" nnoremap <silent> <C-s> :BufferPick<CR>
" " Sort automatically by...
" nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
" nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
" " Move to previous/next
" nnoremap <silent>    <A-,> :BufferPrevious<CR>
" nnoremap <silent>    <A-.> :BufferNext<CR>
" " Re-order to previous/next
" nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
" nnoremap <silent>    <A->> :BufferMoveNext<CR>
" " Goto buffer in position...
" nnoremap <silent>    <A-1> :BufferGoto 1<CR>
" nnoremap <silent>    <A-2> :BufferGoto 2<CR>
" nnoremap <silent>    <A-3> :BufferGoto 3<CR>
" nnoremap <silent>    <A-4> :BufferGoto 4<CR>
" nnoremap <silent>    <A-5> :BufferGoto 5<CR>
" nnoremap <silent>    <A-6> :BufferGoto 6<CR>
" nnoremap <silent>    <A-7> :BufferGoto 7<CR>
" nnoremap <silent>    <A-8> :BufferGoto 8<CR>
" nnoremap <silent>    <A-9> :BufferLast<CR>
" " Close buffer
" nnoremap <silent>    <A-c> :BufferClose<CR>
" " Wipeout buffer
" "                          :BufferWipeout<CR>
" " Other:
" " :BarbarEnable - enables barbar (enabled by default)
" " :BarbarDisable - very bad command, should never be used

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Neovim LSP
" :lua <<EOF
"     require'lspconfig'.flow.setup{}
" EOF

" Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" -----------------------------------------------------------------------------
"  VIMTEX OPTIONS
"  ----------------------------------------------------------------------------
if has('unix')
    if has('mac')
        let g:vimtex_view_method = "skim"
        let g:vimtex_view_general_viewer
                \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
        let g:vimtex_view_general_options = '-r @line @pdf @tex'

        " This adds a callback hook that updates Skim after compilation
        function! UpdateSkim(status)
            if !a:status | return | endif

            let l:out = b:vimtex.out()
            let l:tex = expand('%:p')
            let l:cmd = [g:vimtex_view_general_viewer, '-r']
            if !empty(system('pgrep Skim'))
            call extend(l:cmd, ['-g'])
            endif
            if has('nvim')
            call jobstart(l:cmd + [line('.'), l:out, l:tex])
            elseif has('job')
            call job_start(l:cmd + [line('.'), l:out, l:tex])
            else
            call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
            endif
        endfunction
        let g:vimtex_compiler_latexmk = {
          \ 'build_dir' : '',
          \ 'callback' : 1,
          \ 'continuous' : 1,
          \ 'executable' : 'latexmk',
          \ 'hooks' : [function('UpdateSkim')],
          \   'options' : [
          \       '-file-line-error',
          \       '-synctex=1',
          \       '-interaction=nonstopmode',
          \     ],
          \}
    else
        let g:latex_view_general_viewer = "zathura"
        let g:vimtex_view_method = "zathura"
    endif
elseif has('win32')

endif

let g:tex_flavor = "latex"
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_mode = 2
if has('nvim')
    let g:vimtex_compiler_progname = 'nvr'
endif

" One of the neosnippet plugins will conceal symbols in LaTeX which is
" confusing
let g:tex_conceal = ""

" " Can hide specifc warning messages from the quickfix window
" " Quickfix with Neovim is broken or something
" " https://github.com/lervag/vimtex/issues/773
" let g:vimtex_quickfix_latexlog = {
"             \ 'default' : 1,
"             \ 'fix_paths' : 0,
"             \ 'general' : 1,
"             \ 'references' : 1,
"             \ 'overfull' : 1,
"             \ 'underfull' : 1,
"             \ 'font' : 1,
"             \ 'packages' : {
"             \   'default' : 1,
"             \   'natbib' : 1,
"             \   'biblatex' : 1,
"             \   'babel' : 1,
"             \   'hyperref' : 1,
"             \   'scrreprt' : 1,
"             \   'fixltx2e' : 1,
"             \   'titlesec' : 1,
"             \ },
"             \}

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
" Changes indentation based on file type
autocmd BufRead,BufNewFile *.htm,*.html,*.js,*.ts,*.jsx,*.tsx,*.css,*.elm
    \ setlocal tabstop=2 shiftwidth=2 softtabstop=2

" 80 column border
" set cc=80

" Allows auto-indenting depending on file type
filetype plugin indent on

" Syntax highlighting
syntax on

" Showing line numbers and length
set number
set relativenumber
" set fo-=t

" Highlights/underlines line cursor is on
set cursorline

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
" :command Dhl nohlsearch

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

" Set the leader to coma
let mapleader = ","
let maplocalleader="\<space>"

" j and k operate on display lines
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" Disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
" if &term =~ '256color'
"     set t_ut=
" endif

" Word wrapping
set wrap

" Colorscheme: Gruvbox
autocmd vimenter * ++nested colorscheme gruvbox
set termguicolors
set background=light
