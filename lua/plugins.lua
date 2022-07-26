local fn = vim.fn

local install_path = fn.stdpath('data')..'site/pack/packer/start/packer.nvim'

local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local function setup_completion(use)
  use 'hrsh7th/nvim-cmp'
  -- auto-completes with words from the current buffer
  use 'hrsh7th/cmp-buffer'
  -- auto-completes with writing files
  use 'hrsh7th/cmp-path'
  -- auto-completes lua with nvim/vim api functions
  use 'hrsh7th/cmp-nvim-lua'
  -- auto-completes with info from lsp
  use 'hrsh7th/cmp-nvim-lsp'
  -- luasnip for snippet implementation
  use 'saadparwaiz1/cmp_luasnip'
end

return require('packer').startup(function(use)
    -- packer itself
    use 'wbthomason/packer.nvim'
    use 'onsails/lspkind.nvim'

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
