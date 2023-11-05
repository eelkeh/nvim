local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Set space as the leader key
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("v", ".", ":normal .<cr>")

-- easier window movement
map("n", "<C-j>", "<C-W>j")
map("n", "<C-k>", "<C-W>k")
map("n", "<C-h>", "<C-W>h")
map("n", "<C-l>", "<C-W>l")

-- cutting with m (move)
map("n", "m", "d")
map("x", "m", "d")
map("n", "mm", "dd")
map("n", "M", "D")
-- let me paste multiple times!
map("x", "p", "pgvy")
-- yoink
map("n", "p", "<plug>(YoinkPaste_p)")
map("n", "P", "<plug>(YoinkPaste_P)")

-- telescope
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').grep_string()<cr>")

-- spectre
map("n", "<leader>s", "<cmd>lua require('spectre').open()<cr>")
map("n", "<leader>sfw", "<cmd>lua require('spectre').open_visual({select_word=true})<cr>")
map("v", "<leader>sf", "<cmd>lua require('spectre').open_visual()<cr>")
map("n", "<leader>fp", "<cmd>lua require('spectre').open_file_search()<cr>")
--
-- Remap g/j to deal with word wrap better
-- vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {})
-- vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--
map("n", "<leader><space>", "<cmd>NvimTreeToggle<cr>")
map("n", "<leader>n", "<cmd>NvimTreeFindFile<cr>")

-- terminal
map("n", "<leader>tt", "<cmd>1ToggleTerm direction='float'<cr>")
map("n", "<leader>tv", "<cmd>1ToggleTerm direction='vertical' size=90 <cr>")
map("n", "<leader>tb", "<cmd>1ToggleTerm direction='horizontal' <cr>")


-- custom terminal stuff
local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

map("n", "<leader>lg", "<cmd>lua _lazygit_toggle() <cr>")


local dockercompose = Terminal:new({
  cmd = "docker compose up",
  dir = "git_dir",
  direction = "vertical",
  count = 5,
})

function _docker_toggle()
  dockercompose:toggle(90) -- toggle with size
end

map("n", "<leader>td", "<cmd>lua _docker_toggle() <cr>")

-- trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  { silent = true, noremap = true }
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  { silent = true, noremap = true }
)

-- dap
map("n", "<leader>p", "<cmd>lua require'dap'.continue()<cr>")
map("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
map("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>")
map("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>")
map("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")

-- test
local neotest = require('neotest')
function _runtestsfile()
  neotest.run.run(vim.fn.expand('%'))
  neotest.summary.open()
end

map("n", "tt", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>")
map("n", "tr", "<cmd>lua require('neotest').run.run()<cr>")
map("n", "tf", "<cmd>lua _runtestsfile() <cr>")
map("n", "tx", "<cmd>lua require('neotest').summary.toggle()<cr>")
map("n", "to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>")


-- fix terminal ctrl-l
-- vim.keymap.del("t", "<C-l>")

-- which_key.setup({})

-- which_key.register({
--   -- easier window movement
--   ["<leader>"] = {
--     b = {
--       name = "+buffer",
--       b = { lua_cmd("require('telescope.builtin').buffers()"), "buffers" },
--     },
--     f = {
--       name = "+file",
--       f = { lua_cmd("require('telescope.builtin').find_files()"), "find files" },
--       b = { cmd(":Telescope file_browser"), "file browser" },
--       g = { lua_cmd("require('telescope.builtin').live_grep()"), "live grep" },
--       s = { lua_cmd("require('telescope.builtin').grep_string()"), "grep string" },
--     },
--     t = {
--       name = "+terminal",
--       t = { cmd("ToggleTerm direction='float'"), "floating terminal" },
--       v = { cmd("ToggleTerm direction='vertical'"), "vertical terminal" },
--       r = { cmd("ToggleTerm direction='vertical'"), "vertical terminal" },
--       b = { cmd("ToggleTerm direction='horizontal'"), "bottom terminal" },
--     },
--   },
-- })
