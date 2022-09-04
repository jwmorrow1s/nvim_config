local keymap = vim.keymap.set
local nvim_keymap = vim.api.nvim_set_keymap
-- local expr_opts = { noremap = true, expr = true, silent = true }
local default_opts = { noremap = true, silent = true }
local telescope = require('telescope.builtin')

-- telescope
keymap('n', '<space>ff', function()
    telescope.find_files()
end)
keymap('n', '<space>fs', function()
    telescope.live_grep()
end)
nvim_keymap("n", "<space>tt", "<cmd>Trouble<cr>", {silent = true, noremap = true})

-- debug
