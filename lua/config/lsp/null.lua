local null_ls = require("null-ls")
local builtins = null_ls.builtins

null_ls.setup({
  sources = {
    -- formatting
    -- builtins.formatting.stylua,
    -- builtins.formatting.cabal_fmt,
    -- builtins.formatting.rustfmt,
    -- builtins.formatting.eslint_d.with({ extra_args = { "--cache" } }),

    -- js
    builtins.formatting.prettier,

    -- python
    builtins.formatting.black.with({
      prefer_local = ".venv/bin",
    }),
    builtins.formatting.isort.with({
      args = { "--settings-path=/Users/eelke/Sites/penelope/athena/backend/app", "--stdout", "--filename", "$FILENAME", "-" },
      prefer_local = ".venv/bin",
    }),

    -- diagnostics
    builtins.diagnostics.eslint,
    -- builtins.diagnostics.mypy,

    -- code actions
    --[[ builtins.code_actions.eslint_d.with({ extra_args = { "--cache" } }), ]]
  },

  on_attach = function(client)
    require("lsp-format").on_attach(client)
  end,
})

