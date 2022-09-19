local module = {}

---@param augroup_name string The name of the autogroup to be used to create the auto command
---@param filetype_patterns table The list of filetypes for the autommand to be used on
---@param callbackfn function The function to be applied when the file matches one of the patterns in filetype_patterns
---@return boolean success if command set successfully
function module.lang_autocmd(augroup_name, filetype_patterns, callbackfn)
  if type(augroup_name) == "string" and type(filetype_patterns) == "table" and type(callbackfn) == "function" then
    local augroup = vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetype_patterns,
      callback = callbackfn,
      group = augroup,
    })
    return true
  else
    print("[ERROR] - could not create auto command for augroup name: " ..
      augroup_name .. " because incorrect types were supplied")
    return false
  end
end

---@param keybinding string The keys to be applied for the fn
---@param fn function The function to execute for the binding
---@param mode string | nil The mode to execute the keymap in. If nil, defaults to 'normal'
---@return boolean Whether the binding suceeded
function module.keymap(keybinding, fn, mode)
  local keybinding_t, fn_t, mode_t = type(keybinding), type(fn), type(mode)
  if keybinding_t == "string" and fn_t == "function" and mode_t == "string" then
    vim.keymap.set(mode, keybinding, fn)
    return true
  elseif keybinding_t == "string" and fn_t == "function" then
    vim.keymap.set("n", keybinding, fn)
    return true
  else
    return false
  end
end

---@param msg string The string you want to print to the window
---@param width integer | nil The width of the window. Defaults to 50
---@param height integer | nil The height of the window. Defaults to 10
function module.alert(msg, width, height)
  local the_width, the_height = width or 50, height or 10
  -- current ui
  local ui = vim.api.nvim_list_uis()[1] -- 1-indexed
  local buf = vim.api.nvim_create_buf(false, true)
  local opts = {
    ['relative'] = 'editor',
    ['width'] = the_width,
    ['height'] = the_height,
    ['col'] = (ui.width / 2) - (the_width / 2),
    ['row'] = (ui.height / 2) - (the_height / 2),
    ['anchor'] = 'NW',
    ['style'] = 'minimal',
  }
  -- draw the window
  vim.api.nvim_open_win(buf, 1, opts)
  -- place the message on the drawn window
  vim.api.nvim_buf_set_lines(buf, 0, 0, nil, { msg })
end

---@param cmd string The command to execute
---@return boolean success if command is found
function module.exec(cmd)
    if type(cmd) == "string" and vim.fn.exists(":"..cmd) then
      vim.api.nvim_exec(cmd, false)
      return true
    else
      return false
    end
end

---@param path_to_file string The path the the file
---@return boolean The file can be opened(exists)
function module.file_exists(path_to_file)
  local f = io.open(path_to_file, "r")
  local res = f ~= nil
  if res then
    io.close(f)
  end
  return res
end

return module
