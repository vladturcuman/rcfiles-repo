" Set up vertical vs block cursor for insert/normal mode
if &term =~ "screen."
    let &t_ti.="\eP\e[1 q\e\\"
    let &t_SI.="\eP\e[5 q\e\\"
    let &t_EI.="\eP\e[1 q\e\\"
    let &t_te.="\eP\e[0 q\e\\"
else
    let &t_ti.="\<Esc>[1 q"
    let &t_SI.="\<Esc>[5 q"
    let &t_EI.="\<Esc>[1 q"
    let &t_te.="\<Esc>[0 q"
endif


syntax enable
filetype plugin indent on


nnoremap y "+
vnoremap y "+y

set clipboard=unnamedplus


" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" expand tab to 4 spaces
set expandtab

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'ycm-core/YouCompleteMe'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-autoformat/vim-autoformat'
Plug '~/workspace/vim-symbol-overlay'
Plug '~/workspace/vim-buffer-history'
Plug 'lervag/vimtex'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'kana/vim-operator-user'

call plug#end()

" Latex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" No swap file and autoformat on save
set noswapfile
syntax enable
filetype plugin indent on
autocmd BufWrite *.py,*.rs,*.c,*.h,*.cpp :Autoformat
let g:rustfmt_autosave = 1
let g:clang_format#style_options = {
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "SortIncludes" : "false"}
autocmd FileType c,cpp,h ClangFormatAutoEnable

" Persistent undos
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Autocomplete
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_always_populate_location_list = 1
let g:ycm_auto_hover = ''
let g:ycm_enable_diagnostic_highlighting = 0
set completeopt-=preview
map <silent> ,ht <plug>(YCMHover)

" Add numbers and color sign column
set number
set signcolumn=number
set numberwidth=3
highlight SignColumn ctermbg=235 guibg=#3e3e3e ctermfg=white guifg=white
highlight LineNr ctermfg=darkgray guifg=#d3d3d3

" Disable highlight brackets
highlight MatchParen ctermbg=yellow ctermfg=black guibg=#ffcc00 guifg=#000000
highlight Cursor ctermfg=black ctermbg=white guifg=#ffffff guibg=#000000
set matchtime=1
let g:loaded_matchparen=1

" Next Error
nnoremap ,en :lnext<CR>

" Auto compile on save
autocmd BufWritePost *.rs YcmForceCompileAndDiagnostics

" Jump to definition
nnoremap ,gi :YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <silent> ,gb <C-o>

" Normal s to surround
xmap s <Plug>VSurround

" FZF
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
nnoremap <Space>ff :FZF<CR>
nnoremap <Space>fs :w<CR>

" Buffer switch
nnoremap <Space><Tab> :BufferHistorySwitch<CR>

" Symbol Highlight
set hlsearch!
nnoremap * :SymbolOverlay<CR>
nnoremap <Space>so :SymbolOverlay<CR>
nnoremap <Space>sd :SymbolOverlayClear<CR>
cnoremap noh SymbolOverlayClear




