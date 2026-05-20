local map = vim.keymap.set

-- Set space as the leader key
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("v", ".", ":normal .<cr>")

-- Easier window movement
map("n", "<C-j>", "<C-W>j")
map("n", "<C-k>", "<C-W>k")
map("n", "<C-h>", "<C-W>h")
map("n", "<C-l>", "<C-W>l")

-- Cutting with m (move) — d only yanks (via vim-cutlass)
map({ "n", "x" }, "m", "d")
map("n", "mm", "dd")
map("n", "M", "D")
-- Let me paste multiple times!
map("x", "p", "pgvy")
-- yoink
map("n", "p", "<Plug>(YoinkPaste_p)")
map("n", "P", "<Plug>(YoinkPaste_P)")

-- telescope
map("n", "<C-p>", function() require("telescope.builtin").find_files() end)
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end)
map("n", "<leader>ff", function() require("telescope.builtin").grep_string() end)
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end)

-- spectre
map("n", "<leader>s", function() require("spectre").open() end)
map("n", "<leader>sfw", function() require("spectre").open_visual({ select_word = true }) end)
map("v", "<leader>sf", function() require("spectre").open_visual() end)
map("n", "<leader>fp", function() require("spectre").open_file_search() end)

-- nvim-tree
map("n", "<leader><space>", "<cmd>NvimTreeToggle<cr>")
map("n", "<leader>n", "<cmd>NvimTreeFindFile<cr>")

-- trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { silent = true })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { silent = true })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { silent = true })

-- dap
map("n", "<leader>p", function() require("dap").continue() end)
map("n", "<leader>b", function() require("dap").toggle_breakpoint() end)
map("n", "<leader>do", function() require("dap").step_over() end)
map("n", "<leader>di", function() require("dap").step_into() end)
map("n", "<leader>dl", function() require("dap").run_last() end)
