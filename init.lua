require('plugins')
require('lsp')
require('treesitter')
require('_telescope')
require('keymaps')
require('_ale')
require('completions')
require('blame')
require('_vimtex')
require('_lualine')
require('_nvim_web_devicons')
require('_mason')
require('_asyncomplete')

vim.o.number = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.opt_local.cursorline = true
vim.o.mouse = "a"

vim.api.nvim_exec([[
    colorscheme gruvbox-baby
    " fix highlighting
    if (&background == 'dark')
      hi Visual cterm=NONE ctermfg=NONE ctermbg=237 guibg=#3a3a3a
    else
      hi Visual cterm=NONE ctermfg=NONE ctermbg=223 guibg=#ffd7af
    endif
]], true)

-- Able to diagnose in buffer with :LspLog
vim.lsp.set_log_level("debug")
-- Needed to allow autocmd creation for Metals (Scala lsp)
vim.opt_global.shortmess:remove("F")
