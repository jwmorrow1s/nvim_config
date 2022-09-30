local vim_utils = require('_vim_utils')
local debug = require('_debug')

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local function set_common_lsp_keybindings()
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', function()
      vim.lsp.buf.declaration()
    end, bufopts)
    vim.keymap.set('n', 'gd', function()
      vim.lsp.buf.definition()
    end, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format({async = true})
    end, bufopts)
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- enable completion trigger by <c-x> <c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    set_common_lsp_keybindings()
end

local lsp_flags = {
    -- this is the default for neovim > 0.7
    debounce_text_changes = 150,
}

local util = require('lspconfig/util')

local function setup_lua_lsp()
  local sumneko_binary_path = vim.fn.exepath('lua-language-server')
  local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h:h')

  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")
  set_common_lsp_keybindings()
require('lspconfig')['sumneko_lua'].setup {
      cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/lua-language-server/bin/main.lua"};
      settings = {
          Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
          },
      },
  }
end

local function setup_scala_lsp()
  local metals_config = require("metals").bare_config()
  metals_config.init_options.statusBarProvider = "on"

  vim_utils.lang_autocmd("nvim-metals", {"scala", "sbt", "java"}, function()
      require("metals").initialize_or_attach(metals_config)

      local dap = require('dap')
      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "RunOrTest",
          metals = {
            runType = "runOrTestFile",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        }
      }
      metals_config.on_attach = function()
        require("metals").setup_dap()
      end

      debug.setup_nvim_dap()
      set_common_lsp_keybindings()
  end)
end

local function setup_golang_lsp()
  -- set up vimspector
  vim_utils.lang_autocmd("golang", {"go"}, function()
    debug.setup_vimspector()
  end)

  require('lspconfig')['gopls'].setup {
      on_attach = on_attach,
      lsp_flags = lsp_flags,
      cmd = {"gopls", "serve"},
      filetypes = {"go", "gomod"},
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
  }
end

require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    lsp_flags = lsp_flags,
}
require('lspconfig')['elixirls'].setup{
    on_attach = on_attach,
    lsp_flags = lsp_flags,
    cmd = { '/Users/jeff/Personal/repos/elixir-ls/language_server.sh' }
}
require('lspconfig')['yamlls'].setup{
    on_attach = on_attach,
    lsp_flags = lsp_flags,
    settings = {
      yaml = {
        schemaStore = {
          url = "https://www.schemastore.org/api/json/catalog.json",
          enable = true,
        },
      },
    },
  cmd = { vim.env.HOME..'/.local/share/nvim/site/pack/packer/start/yaml-language-server/bin/yaml-language-server', '--stdio' },
}

local function setup_rust_lsp()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
      vim.schedule(function()
        debug.setup_nvim_dap()
        vim.api.nvim_set_keymap('n', '<Space>cr', "<cmd>RustRunnables<cr>", {silent = true, noremap = true})
        vim.api.nvim_set_keymap('n', '<Space>cc', "<cmd>RustCodeAction<cr>", {silent = true, noremap = true})
        vim.api.nvim_set_keymap('n', '<Space>cd', "<cmd>RustDebuggables<cr>", {silent = true, noremap = true})
        vim.api.nvim_set_keymap('n', '<Space>cha', "<cmd>RustHoverActions<cr>", {silent = true, noremap = true})
        vim.api.nvim_set_keymap('n', '<Space>rr', "<cmd>RustRun<cr>", {silent = true, noremap = true})
      end)
    end
  })

  local rt = require('rust-tools')
  local extension_path = vim.env.HOME.."/.local/share/nvim/mason/packages/codelldb/extension/"
  local codelldb_path = extension_path.."adapter/codelldb"
  local liblldb_path = nil
  if vim_utils.file_exists(extension_path.."lldb/lib/liblldb.so") then
    liblldb_path = extension_path.."lldb/lib/liblldb.so"
  else if vim_utils.file_exists(extension_path.."lldb/lib/liblldb.dylib") then
    liblldb_path = extension_path.."lldb/lib/liblldb.dylib"
  else
    print("[ERROR]\t\tNo lldb/lib/liblldb.[dylib|so] was found so either codelldb is not installed or you're on windows. Sorry.")
    return
  end
  end

  rt.setup({
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
      end,
      lsp_flags = lsp_flags,
      dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
      },
   })

end


setup_lua_lsp()
setup_scala_lsp()
setup_golang_lsp()
setup_rust_lsp()
