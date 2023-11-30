local fn = vim.fn

-- Automcatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  use { "wbthomason/packer.nvim" } -- Have packer manage itself

  -- random tools
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "numToStr/Comment.nvim" }
  use { "JoosepAlviste/nvim-ts-context-commentstring" }
  use { "lewis6991/impatient.nvim" }
  use { 'windwp/nvim-ts-autotag' }
  use { 'mattn/emmet-vim' }
  use { 'vim-scripts/DoxygenToolkit.vim' }

  -- styling
  use { 'AlexvZyl/nordic.nvim' }
  use { 'nvim-tree/nvim-web-devicons' }
  use { "EdenEast/nightfox.nvim" }
  use { 'feline-nvim/feline.nvim' }
  use { 'norcalli/nvim-colorizer.lua' }

  -- dap
  use { 'mfussenegger/nvim-dap' }
  use { 'theHamsta/nvim-dap-virtual-text' }
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  -- lsp
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      -- Autocompletion
      { 'L3MON4D3/LuaSnip' },
    }
  }
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "RRethy/vim-illuminate" }
  use { 'ray-x/lsp_signature.nvim' }
  use { 'ray-x/go.nvim' }            -- Golang
  use { 'rust-lang/rust.vim' }       -- Rust
  use { 'simrat39/rust-tools.nvim' } -- Rust
  use { 'jvirtanen/vim-hcl' }        -- hcl
  use { 'yuezk/vim-js' }             -- js
  use { 'maxmellon/vim-jsx-pretty' } -- jsx
  use { 'wuelnerdotexe/vim-astro' }  -- astro
  use { 'prisma/vim-prisma' }        --prisma
  -- cmp
  use { "hrsh7th/nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-vsnip" }
  use { "hrsh7th/cmp-path" }
  use { "hrsh7th/cmp-buffer" }
  use { "hrsh7th/vim-vsnip" }
  -- Java
  use { 'mfussenegger/nvim-jdtls', ft = { "java" } } -- java
  use { 'vim-syntastic/syntastic' }

  -- Editor config
  use { 'editorconfig/editorconfig-vim' }

  -- Git
  use { "lewis6991/gitsigns.nvim" }

  -- telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use("mbbill/undotree")
  -- fzf
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use { 'junegunn/fzf.vim' }

  -- ranger
  use { 'francoiscabrol/ranger.vim' }
  use { 'rbgrouleff/bclose.vim' }
  use { 'kevinhwang91/rnvimr' }

  use { "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, }

  -- Automcatically set up your config after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
