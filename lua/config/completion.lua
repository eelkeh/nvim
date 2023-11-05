local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  -- formatting = {
  --   format = lsp_kind.cmp_format({}),
  -- },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<Down>"] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Select,
    }),
    ["<Up>"] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Select,
    }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace
    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip", max_item_count = 4 },
    { name = "path", keyword_length = 3 },
  }, {
    { name = "buffer", keyword_length = 5 },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path', keyword_length = 2 }
  }, {
    { name = 'cmdline', keyword_length = 4 }
  })
})

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done({
    map_char = { tex = "", haskell = "" },
  })
)
