local lspkind = require "lspkind"
lspkind.init()

local cmp = require("cmp")
cmp.setup {
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<c-y>"] = cmp.mapping(
      cmp.mapping.confirm{
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
        {'i', 'c'}
      }),
    ["<c-space>"] = cmp.mapping.complete{},

  },
  ["<c-space>"] = cmp.mapping {
  i = cmp.mapping.complete{},
  c = function(
    _ --[[fallback]]
  )
    if cmp.visible() then
      if not cmp.confirm { select = true } then
        return
      end
    else
      cmp.complete()
    end
  end,
  },
  ["<tab>"] = cmp.config.disable,

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  -- sources are list in priority of how they try and get applied
  -- you can configure:
  --   keyword_length
  --   priority
  --   max_item_count
  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keyword_length = 5 },
  }),

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  formatting = {
    format = lspkind.cmp_format{
      with_text = true,
      menu = {
        buffer = '[buf]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[api]',
        path = '[path]',
        luasnip = '[snip]',
        gh_issues = '[issues]',
      },
    },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  }
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['tsserver'].setup{
  capabilities = capabilities
}
require('lspconfig')['elixirls'].setup{
  capabilities = capabilities
}
require('lspconfig')['gopls'].setup {
  capabilities = capabilities
}
require('lspconfig')['sumneko_lua'].setup {
  capabilities = capabilities
}
