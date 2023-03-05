-- the final command is to set up vlime autocomplete
vim.api.nvim_exec([[
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

  autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#vlime#get_source_options({ 'priority': 10 }))
]], true)
