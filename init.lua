require('plugins')
require('lsp')
require('treesitter')
require('_telescope')
require('keymaps')

-- formatoptions-=ro not working
        
vim.api.nvim_exec([[
    set number "set line numbers
    autocmd FileType * setlocal formatoptions-=r formatoptions-=o "disable newline comments. Very annoying
    set expandtab     " these two settings change tabs to 4 spaces 
    set shiftwidth=4  " these two settings change tabs to 4 spaces 
    colorscheme gruvbox-baby
]], true)

-- Able to diagnose in buffer with :LspLog
vim.lsp.set_log_level("debug")
