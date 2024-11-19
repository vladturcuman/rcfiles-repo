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


filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab


let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-autoformat/vim-autoformat'
Plug '~/workspace/vim-symbol-overlay'
Plug '~/workspace/vim-buffer-history'

call plug#end()

" No swap file and autoformat on save
au BufWrite * :Autoformat
set noswapfile

" Persistent undos
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Autocomplete and rust things
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
                \   'name': 'Rust Language Server',
                \   'cmd': {server_info->['rust-analyzer']},
                \   'whitelist': ['rust'],
                \ })
endif

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




