local ok, nvim_lsp = pcall(require, "lspconfig")
if not ok then
  print("NO LSPCONFIG")
	return 
end

local ok, cmp = pcall(require, "cmp")
if not ok then
  print("NO CMP")
	return 
end

local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
  print("NO CMP_NVMI_LSP")
	return 
end

local ok, tree_configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  print("NO TREE")
	return
end

local ok, virtual_dap = pcall(require, "nvim-dap-virtual-text")
if not ok then
  print("NO VIRTUAL DAP")
  return
end
virtual_dap.setup()


-- Treesiter + autotag
tree_configs.setup {
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true }
}


-- Enable LSP snippets
cmp.setup({
	snippet = {
		expand = function(args)
		vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {

	-- Key Mappings
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

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'path' },
		{ name = 'buffer' },
	},
	
  window = {
		documentation = {
		  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},

	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})


local on_attach = function(client, bufnr)

  local ok, signature = pcall(require, "lsp_signature")
  if not ok then
	  print("signature issue")
	  return
  end
  signature.on_attach({}, bufnr)

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', bufopts)
  vim.keymap.set('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', bufopts)
  vim.keymap.set('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', bufopts)

  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local default_config = { 
  on_attach = on_attach, 
  capabilites = cmp_lsp.default_capabilities()
} 


local go_attach = function (client, bufnr)
  on_attach(client, bufnr)
  local ok, go = pcall(require, "go")
  if not ok then
    print("go.nvim")
  end
  
  print("starting go")
  go.setup()
end

--  https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
	tsserver = default_config,
	clangd = default_config,
	pyright = default_config,
	rust_analyzer = default_config,
	prismals = default_config,

	gopls = { 
		on_attach = go_attach,
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
	},
}

for k, v  in pairs(servers) do
	nvim_lsp[k].setup(v)
end

-- special vars
vim.go.rustfmt_autosave = 1;
vim.go.astro_typescript = 'enabled';
