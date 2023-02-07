set nocompatible
filetype off
set mapleader = ","
lcall plug#begin(stdpath('data'))

Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'editorconfig/editorconfig-vim'

Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'

Plug 'ray-x/lsp_signature.nvim'
Plug 'ray-x/go.nvim'
Plug 'jvirtanen/vim-hcl'

Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'windwp/nvim-ts-autotag'
Plug 'wuelnerdotexe/vim-astro'
Plug 'mattn/emmet-vim'

Plug 'RRethy/nvim-base16'
call plug#end()
augroup LspBuf
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'bufls',
      \ 'cmd': {server_info->['bufls', 'serve']},
      \ 'whitelist': ['proto'],
      \ })
  autocmd FileType proto nmap <buffer> gd <plug>(lsp-definition)
augroup END


lua <<EOF
local nvim_lsp = require'lspconfig'
local cmp = require'cmp'
cmp.setup({
-- Enable LSP snippets
snippet = {
	expand = function(args)
	vim.fn["vsnip#anonymous"](args.body)
	end,
},
mapping = {
	['<C-k>'] = cmp.mapping.select_prev_item(),
	['<C-j>'] = cmp.mapping.select_next_item(),
	-- Add tab support
	['<S-Tab>'] = cmp.mapping.select_prev_item(),
	['<Tab>'] = cmp.mapping.select_next_item(),
	['<C-d>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.close(),
	['<CR>'] = cmp.mapping.confirm({
	behavior = cmp.ConfirmBehavior.Insert,
	select = true,
	})
	},

-- Installed sources
sources = {
	{ name = 'nvim_lsp' },
	{ name = 'vsnip' },
	{ name = 'path' },
	{ name = 'buffer' },
},
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end


-- Format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

--Set up lspconfig
local capabilites = require("cmp_nvim_lsp").default_capabilities();

-- TSC
nvim_lsp.tsserver.setup {
	on_attach = on_attach,
	capabilites = capabilites
}


-- Auto Tag
require'nvim-treesitter.configs'.setup {
	autotag = {
		enable = true,
	}
}
-- Clangd
nvim_lsp.clangd.setup{ 
	on_attach = on_attach,
	capabilites = capabilites
}

-- python
nvim_lsp.pyright.setup{
	on_attach = on_attach,
	capabilites = capabilites
}

-- Rust
nvim_lsp.rust_analyzer.setup({
	on_attach = on_attach,
	capabilites = capabilites
})

-- golang
nvim_lsp.gopls.setup{
	on_attach = on_attach,
	capabilites = capabilites,
        cmd = {"gopls", "serve"},
        filetypes = {"go", "gomod"},
        settings = {
          gopls = {
           analyses = {
            unusedparams = true,
          },
          staticcheck = true,
      },
    },
  }
EOF

" get rid of arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" buffers mapped to arrow keys
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

set number
set relativenumber
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set updatetime=300
set wildmenu

" spell check 
set spelllang=en,cjk
nnoremap <silent> <F9> :set spell!<cr>
inoremap <silent> <F9> <C-O>:set spell!<cr>

" theme
set background=dark 
colorscheme gruvbox

" netrw
let g:netrw_banner = 0

" rust
let g:rustfmt_autosave = 1

" astro
let g:astro_typescript = 'enable'

" tabs
autocmd FileType javascript.jsx,javascriptreact,vim,html,php setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd FileType jscss,css,son,javascript,typescript,typescriptreact setlocal tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab

nmap <leader>ff gg=G<CR>
nmap <leader>; :Buffers<CR>
nmap <leader>w :w<CR>
nmap <leader>ta :tab ba<CR>
nmap <leader>fi :belowright split<CR>:term bash<CR>:resize 10<CR>

map <C-p> :FZF<CR>
map H ^
map L $

tnoremap <C-W>n <C-\><C-n>

set tabstop=4
set shiftwidth=4
set softtabstop=4

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

noremap <leader>s :Rg<CR>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
set clipboard+=unnamedplus
