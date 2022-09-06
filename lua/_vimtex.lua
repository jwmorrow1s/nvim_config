local utils = require('_vim_utils')

utils.lang_autocmd('LaTex', { 'tex' }, function()
  vim.api.nvim_exec([[
    filetype plugin indent on
    syntax enable
  ]], true)
  vim.g.vimtex_view_method = 'zathura'
  vim.g.vimtex_view_general_viewer = 'okular'
  vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
  vim.g.vimtex_compiler_method = 'latexrun'
  vim.g.maplocalleader = ','

  utils.keymap("<space>di", function()
    utils.exec("VimtexInfo")
  end)
  utils.keymap("<space>ll", function()
    utils.exec("VimtexCompile")
  end)
end)
