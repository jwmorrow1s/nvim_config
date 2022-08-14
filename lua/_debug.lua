local keymap = vim.keymap.set
local expand = vim.fn.expand

vim.g.vimspector_enable_mappings = 'HUMAN'
vim.g.vimspector_base_dir = expand("$HOME/.config/vimspector-config")
vim.g.vimspector_install_gadgets = { 'delve', 'CodeLLDB', 'vscode-node-debug2' }
keymap('n', '<space>dd', vim.fn["vimspector#Launch"])
keymap('n', '<space>dr', vim.fn["vimspector#Reset"])
keymap('n', '<space>do', vim.fn["vimspector#StepOut"])
keymap('n', '<space>di', vim.fn["vimspector#StepInto"])
keymap('n', '<space>drs', vim.fn["vimspector#Restart"])
keymap('n', '<space>dn', vim.fn["vimspector#Continue"])
keymap('n', '<space>drc', vim.fn["vimspector#RunToCursor"])
keymap('n', '<space>db', vim.fn["vimspector#ToggleBreakpoint"])
keymap('n', '<space>dk', vim.fn["vimspector#ToggleConditionalBreakpoint"])
keymap('n', '<space>dx', vim.fn["vimspector#ClearBreakpoints"])
keymap('n', '<space>dw', function()
    local word = expand("<cexpr>")
    vim.fn["vimspector#AddWatch"](word)
end)
