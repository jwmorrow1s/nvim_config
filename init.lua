require('plugins')
require('lsp')
require('treesitter')
require('_telescope')
require('keymaps')
require('completions')
require('_ale')

local do_vim = vim.api.nvim_exec

do_vim([[
    set number "set line numbers
    autocmd FileType * setlocal formatoptions-=r formatoptions-=o "disable newline comments. Very annoying
    set expandtab     " these two settings change tabs to 2 spaces
    set shiftwidth=2  " these two settings change tabs to 2 spaces
    colorscheme gruvbox-baby
    " fix highlighting
    if (&background == 'dark')
      hi Visual cterm=NONE ctermfg=NONE ctermbg=237 guibg=#3a3a3a
    else
      hi Visual cterm=NONE ctermfg=NONE ctermbg=223 guibg=#ffd7af
    endif
    set mouse=a
]], true)

-- Able to diagnose in buffer with :LspLog
vim.lsp.set_log_level("debug")
