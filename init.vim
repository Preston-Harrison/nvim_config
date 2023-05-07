call plug#begin()
Plug 'nvim-tree/nvim-tree.lua'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-test/vim-test'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

syntax on
filetype plugin indent on
colorscheme kanagawa
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set path=.,**,, " Allows :find to recursively search working dir.
set matchpairs+=<:>
set encoding=UTF-8

" Disable inbuilt vim tree
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
set termguicolors

" set cc=80
" hi ColorColumn ctermbg=lightgrey guibg=lightgrey

" Open NERDTree on open
autocmd VimEnter * NERDTree
" Show NERDTree hidden files
let NERDTreeShowHidden=1
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Exit NERDTree if it is the only window remaining in any tab.
autocmd BufEnter * if tabpagenr('$') > 1 && !len(filter(tabpagebuflist(), 'getbufvar(v:val,"&ft") != "nerdtree"')) | tabclose | endif
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

" coc.nvim settings
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"
" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Test Files
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>

" Use K for show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Copy/Paste to and from system clipboard
set clipboard=unnamedplus

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap Ctrl+W to Alt + Space
:nnoremap <M-Space> <C-w>

" Open terminal in new tab
nmap <leader>p :tabnew<CR>:term<CR>i
tnoremap <ESC><ESC> <C-\><C-N>

" Code actions for \a
nmap <leader>a  <Plug>(coc-codeaction-selected)<CR>

" Quick jump to next error
nmap <leader>n <Plug>(coc-diagnostic-next-error)
nmap <leader>N <Plug>(coc-diagnostic-prev-error)

lua << EOF
require("nvim-treesitter.configs").setup({
    ensure_installed = { "javascript", "typescript", "lua", "vim", "json", "html", "rust", "tsx", "comment" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
})
require("lualine").setup{
	options = { theme = 'gruvbox' }
}
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
EOF
