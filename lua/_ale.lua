local do_vim = vim.api.nvim_exec
-- 'cspell', 'deno', 'eslint', 'standard', 'tslint', 'tsserver', 'typecheck', 'xo'
do_vim([[
    let g:ale_linters = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': ['eslint', 'prettier'],
    \ 'typescript': ['tslint', 'eslint', 'tsserver', 'prettier'],
    \ 'typescriptreact': ['tslint', 'eslint', 'prettier'],
    \ 'go': ['gopls', 'gofmt'],
    \}
    let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'javascript': ['eslint', 'prettier'],
    \ 'typescript': ['tslint', 'eslint', 'tsserver', 'prettier'],
    \ 'typescriptreact': ['tslint', 'eslint', 'prettier'],
    \ 'go': ['gofmt'],
    \}
    let g:ale_fix_on_save = 1
]], true)
