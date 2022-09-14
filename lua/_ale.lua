vim.g.ale_fix_on_save = 1
vim.g.ale_linters = {
  ['*'] = { 'remove_trailing_lines', 'trim_whitespace' },
  javascript = {'eslint', 'prettier'},
  typescript = {'tslint', 'eslint', 'tsserver', 'prettier'},
  typescriptreact = {'tslint', 'eslint', 'prettier'},
  go = {'gopls', 'gofmt'},
  scala = {'metals', 'sbtserver', 'scalac'},
  rust = { 'rust-analyzer' },
}

vim.g.ale_fixers = {
  ['*'] = { 'remove_trailing_lines', 'trim_whitespace' },
  javascript = {'eslint', 'prettier'},
  typescript = {'tslint', 'eslint', 'prettier'},
  typescriptreact = {'tslint', 'eslint', 'prettier'},
  go = {'gofmt'},
  scala = {'scalafmt'},
  rust = { 'rustfmt' },
}
