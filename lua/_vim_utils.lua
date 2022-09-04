local module = {}

---@param augroup_name string The name of the autogroup to be used to create the auto command
---@param filetype_patterns table The list of filetypes for the autommand to be used on
---@param callbackfn function The function to be applied when the file matches one of the patterns in filetype_patterns
---@return boolean success if command set successfully
function module.lang_autocmd(augroup_name, filetype_patterns, callbackfn)
  if type(augroup_name) == "string" and type(filetype_patterns) == "table" and type(callbackfn) =="function" then
    local augroup = vim.api.nvim_create_augroup(augroup_name, { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetype_patterns,
      callback = callbackfn,
      group = augroup,
    })
    return true
  else
    print("[ERROR] - could not create auto command for augroup name: "..augroup_name.." because incorrect types were supplied")
    return false
  end
end

---@param keybinding string The keys to be applied for the fn
---@param fn function The function to execute for the binding
---@returns boolean Whether the binding suceeded
function module.keymap(keybinding, fn)
  if type(keybinding) == "string" and type(fn) == "function" then
    vim.keymap.set("n", keybinding, fn)
    return true
  else
    return false
  end
end

return module
