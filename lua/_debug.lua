local module = {}
local utils = require("_vim_utils")
local expand = vim.fn.expand

function module.setup_vimspector()

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
  dap_ui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
      {
        elements = {
        -- Elements can be strings or table with id and size keys.
          { id = "scopes", size = 0.25 },
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40, -- 40 columns
        position = "left",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 0.25, -- 25% of total lines
        position = "bottom",
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil, -- Can be integer or nil.
      max_value_lines = 100, -- Can be integer or nil.
    }
  })

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
  utils.keymap('<space>de', function()
      local expression = expand("<cexpr>")
      dap_ui.eval(expression, {})
  end)
end

return module
