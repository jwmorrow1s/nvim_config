local do_vim = vim.api.nvim_exec

do_vim([[
  let g:blamer_enabled = 1
  let g:blamer_delay = 500
  let g:blamer_show_in_insert_modes = 0
  let g:blamer_date_format = '%m.%d.%y'
]], true)
