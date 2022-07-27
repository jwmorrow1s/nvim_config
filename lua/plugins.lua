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
    -- lsp
    use 'neovim/nvim-lspconfig'
    -- better syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- elixir lsp
    use({ "mhanberg/elixir.nvim", requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" }})
    -- file search
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} } }
    -- formatting
    use 'dense-analysis/ale'
    --theme
    use 'luisiacc/gruvbox-baby'
    --completion
    setup_completion(use)
    -- /My plugins

    -- Automatically set up your configuration after cloning packer.vim (if missing)
    -- NOTE: Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
