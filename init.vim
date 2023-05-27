nnoremap <SPACE> <Nop>
let mapleader = " "
call plug#begin()
Plug 'nvim-tree/nvim-tree.lua'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-test/vim-test'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lualine/lualine.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
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

" Remap window moving
nmap <C-h> <C-w>h
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j
nmap <C-l> <C-w>l

" Open terminal in new tab
nmap <leader>p :tabnew<CR>:term<CR>i
tnoremap <ESC><ESC> <C-\><C-N>

" Code actions for
nmap <leader>a  <Plug>(coc-codeaction-selected)<CR>

" Quick jump to next error
nmap <leader>n <Plug>(coc-diagnostic-next-error)
nmap <leader>N <Plug>(coc-diagnostic-prev-error)

nmap <A-j> :ToggleTerm size=40 direction=float<CR>
tmap <A-j> <Esc><Esc>:ToggleTerm<CR>

lua << EOF
require("toggleterm").setup{
	close_on_exit = false,
}
require("nvim-treesitter.configs").setup{
    ensure_installed = { "javascript", "typescript", "lua", "vim", "json", "html", "rust", "tsx", "comment" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
}
require("lualine").setup{
	options = { theme = 'auto' }
}
require("nvim-tree").setup{
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
  git = {
	ignore = true,
  }
}
EOF

" Maps open in new tab to t
nmap t <C-t>
nnoremap <A-h> :NvimTreeToggle<CR>
nnoremap <A-r> :NvimTreeRefresh<CR>
