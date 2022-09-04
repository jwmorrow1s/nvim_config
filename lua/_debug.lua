local module = {}
local utils = require("_vim_utils")

function module.setup_vimspector()
  local expand = vim.fn.expand

  vim.g.vimspector_enable_mappings = 'HUMAN'
  vim.g.vimspector_base_dir = expand("$HOME/.config/vimspector-config")
  vim.g.vimspector_install_gadgets = { 'delve', 'CodeLLDB', 'vscode-node-debug2' }
  utils.keymap('<space>dd', vim.fn["vimspector#Launch"])
  utils.keymap('<space>dr', vim.fn["vimspector#Reset"])
  utils.keymap('<space>do', vim.fn["vimspector#StepOut"])
  utils.keymap('<space>di', vim.fn["vimspector#StepInto"])
  utils.keymap('<space>drs', vim.fn["vimspector#Restart"])
  utils.keymap('<space>dn', vim.fn["vimspector#Continue"])
  utils.keymap('<space>drc', vim.fn["vimspector#RunToCursor"])
  utils.keymap('<space>db', vim.fn["vimspector#ToggleBreakpoint"])
  utils.keymap('<space>dk', vim.fn["vimspector#ToggleConditionalBreakpoint"])
  utils.keymap('<space>dx', vim.fn["vimspector#ClearBreakpoints"])
  utils.keymap('<space>dw', function()
      local word = expand("<cexpr>")
      vim.fn["vimspector#AddWatch"](word)
  end)
end

function module.setup_nvim_dap()
  local dap = require('dap')
  local dap_ui = require('dapui')
  dap_ui.setup()

  utils.keymap("<space>dd", function()
    dap.continue()
    dap_ui.open({})
  end)
  utils.keymap("<space>di", dap.step_into)
  utils.keymap("<space>ds", dap.step_over)
  utils.keymap("<space>do", dap.step_out)
  utils.keymap("<space>db", dap.toggle_breakpoint)
  utils.keymap("<space>dbl", dap.list_breakpoints)
  utils.keymap("<space>dx", dap.clear_breakpoints)
  utils.keymap("<space>dr", function()
    dap.disconnect()
    dap_ui.close({})
  end)
  utils.keymap("<space>drs", dap.run_last)
  utils.keymap("<space>dro", dap.repl.open)
  utils.keymap("<space>drc", dap.repl.close)
end

return module
