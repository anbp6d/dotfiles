if empty(glob('~/.config/nvim/autoload/plug.vim'))
  execute "silent !curl -fLo " . fnamemodify("~/.config/nvim/autoload/plug.vim", ":p") . " --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync
endif

let did_install_default_menus = 1

" Autoload project
if filereadable( "project.vim" )
    source project.vim
endif

" Setup a Maximized Window
if has("gui_running")
    call GuiWindowMaximized(1)
endif

" Setup Colorscheme
syntax enable
set background=dark
let g:airline_theme='tomorrow'

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Turn on line numbers and turn off wrapping
set number
set nowrap

" Allow multiple sign columns
if has('nvim')
    set signcolumn=auto:9
else
    set signcolumn=auto
endif

" Tabs as spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

" Normal Copy/Paste
set pastetoggle=<F10>
if has('win32') || has('win64')
    set clipboard=unnamed
    vnoremap <C-c> "*y
    inoremap <C-v> <F10><C-r>+<F10>
else
    set clipboard=unnamedplus
    vnoremap <C-c> "+y
    inoremap <C-v> <F10><C-r>+<F10>
endif

" Auto reload on file modify
set autoread

" Identify wscript files as python
autocmd BufNewFile,BufRead wscript set filetype=python

" Trim Trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" Fix Tabs on save
" autocmd BufWritePre * retab
" Automatically update copyright notice with current year
autocmd BufWritePre *
  \ if &modified |
  \     m' |
  \     exe "g#\\cCOPYRIGHT \\(".strftime("%Y")."\\)\\@![0-9]\\{4\\}\\(-".strftime("%Y")."\\)\\@!#s#\\([0-9]\\{4\\}\\)\\(-[0-9]\\{4\\}\\)\\?#\\1-".strftime("%Y")."#e" |
  \     '' |
  \ endif

" Configure NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if ( argc() == 0 || ( argc() == 1 && isdirectory(argv()[0]) ) ) && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-o> :NERDTreeToggle<CR>

" Configure Grepper
runtime plugin/grepper.vim
if exists("g:grepper")
    let g:grepper.rg.grepprg = 'rg -H --no-heading --vimgrep -uu'
    let g:grepper.open  = 1
    let g:grepper.jump  = 0
endif

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)
nnoremap <leader>* :Grepper -cword -noprompt -buffer<cr>

" Configure Airline
let g:airline_powerline_fonts = 1

" Configure CtrlP
let g:ctrlp_extensions = ['mixed']
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_show_hidden = 1
let g:ctrlp_regexp = 1

" returns true iff is NERDTree open/active
function! s:isNTOpen()
    return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Configure Language Servers

" C/C++
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

" Python
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

" Configure Tab Completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Configure Git Gutter
set updatetime=100
let g:gitgutter_grep = ''

" Configure Templates
let g:templates_directory = ['$HOME/.config/nvim/templates/']
let g:templates_no_builtin_templates = 1

" Load All Plugins

call plug#begin(fnamemodify("~/.config/nvim/plugged", ":p"))

Plug 'prabirshrestha/async.vim'

Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'sheerun/vim-polyglot'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'

Plug 'flazz/vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'mhinz/vim-grepper'

Plug 'tpope/vim-fugitive'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'tpope/vim-surround'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'aperezdc/vim-template'

" Load last to patch icons into other plugins
Plug 'ryanoasis/vim-devicons'

call plug#end()


