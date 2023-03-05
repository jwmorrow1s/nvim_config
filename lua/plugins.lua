local fn = vim.fn

local install_path = fn.stdpath('data')..'site/pack/packer/start/packer.nvim'

local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local function setup_completion(use)
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
end

return require('packer').startup(function(use)
    -- packer itself
    use 'wbthomason/packer.nvim'

    -- My plugins

    use 'redhat-developer/yaml-language-server'
    use 'simrat39/rust-tools.nvim'
    -- lsp
    use 'LuaLs/lua-language-server'
    use 'neovim/nvim-lspconfig'
    use ({ "p00f/nvim-ts-rainbow", requires = 'nvim-treesitter/nvim-treesitter' })
    use ({'vlime/vlime', rtp = 'vim/'})
    use 'prabirshrestha/asyncomplete.vim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    -- nvim api completion
    use 'nvim-lua/completion-nvim'
    -- better syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- elixir lsp
    use({ "mhanberg/elixir.nvim", requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" }})
    -- scala lsp
    use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})
    -- file search
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} } }
    -- formatting
    use 'dense-analysis/ale'
    --theme
    use 'luisiacc/gruvbox-baby'
    --git blame integration
    use 'APZelos/blamer.nvim'
    --git diff
    use 'airblade/vim-gitgutter'
    -- debugger
    use 'puremourning/vimspector'
    use 'mfussenegger/nvim-dap'
    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' }}
    --completion
    setup_completion(use)
    -- diagnostic for lsp
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
    end
    }
    -- lualine (status line)
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- LaTeX
    use 'lervag/vimtex'
    -- /My plugins

    -- Automatically set up your configuration after cloning packer.vim (if missing)
    -- NOTE: Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
