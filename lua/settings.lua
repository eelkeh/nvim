local default_settings = {
  fileencoding = "utf-8",
  -- Incremental live completion
  inccommand = "nosplit",

  -- Use system clipboard
  clipboard = vim.opt.clipboard + "unnamedplus",

  -- Hide the `-- INSERT --` messages
  showmode = false,

  hlsearch = true,
  relativenumber = false,

  -- Always show the sign column so the buffer doesn't shift around
  signcolumn = "yes",

  -- For faster completion
  updatetime = 250,
  timeoutlen = 500,

  completeopt = { "menu", "menuone", "noselect" },

  -- Tabs vs spaces
  expandtab = true,
  softtabstop = 2,
  shiftwidth = 2,
  tabstop = 2,
  smartindent = true,

  mouse = "a",

  ignorecase = true,
  smartcase = true,

  splitbelow = true,
  splitright = true,

  hidden = true,

  backup = false,
  swapfile = false,
  undofile = true,

  termguicolors = true,

  cmdheight = 1,
  laststatus = 3,

  -- Change vertical split character to be a space (essentially hide it)
  fillchars = "vert:│,diff:╱",

  -- Set floating window to be slightly transparent
  winblend = 10,
}

for k, v in pairs(default_settings) do
  vim.opt[k] = v
end

vim.opt.shortmess:append("c")

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("yank_highlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = highlight_group,
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  float = { border = "single" },
})
