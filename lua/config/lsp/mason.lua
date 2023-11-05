require("mason").setup({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup()

require("lspconfig").pyright.setup({
  settings = {
    python = {
      pythonPath = '/Users/eelke/Sites/penelope/athena/backend/app/.venv/bin'
    }
  }
})
