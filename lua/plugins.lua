require("lazy").setup({ -- Theme
  {
    "EdenEast/nightfox.nvim",
    lazy = false, -- make sure we load this during startup as this is the main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme nightfox]])
    end,
  },
  -- Show indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    config = function()
      require("ibl").setup({
        exclude = {
          buftypes = { "terminal", "nofile" },
          filetypes = { "help", "packer" },
        },
        whitespace = {
          remove_blankline_trail = true
        }
      })
    end,
  },
  -- telecope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = { "tami5/sqlite.lua" },
    config = function()
      require"telescope".load_extension("frecency")
    end,
  },
  -- Move around fast
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps()
    end,
  },
  -- Automatic brackets
  {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,
      })
    end,
  },
  -- Copy/pasting
  'svermeulen/vim-cutlass',
  {'svermeulen/vim-yoink',
    config = function()
      vim.g.yoinkIncludeDeleteOperations = 1
    end
  },
  -- Surround
  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
          require("nvim-surround").setup()
      end
  },
  -- dotenv
  'tpope/vim-dotenv',
  -- Search/replace
  {
    "windwp/nvim-spectre",
    config = function()
      require("spectre").setup()
    end,
  },
  -- File browser
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },
  -- Beter quickfix
  "kevinhwang91/nvim-bqf",
  -- Editorconfig
  "editorconfig/editorconfig-vim",
  -- Search
  "BurntSushi/ripgrep",
  -- tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config/tree-sitter")
    end,
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- use("eddiebergman/nvim-treesitter-pyfold")
  -- Status line
  {
    "hoob3rt/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          globalstatus = true,
          icons_enabled = true,
          theme = "nightfox",
          component_separators = { '', '' },
          section_separators = { '', '' },
          disabled_filetypes = {}
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
      })
    end,
  },

  -- Git gutter signs
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { hl = "GitGutterAdd", text = "+" },
          change = { hl = "GitGutterChange", text = "~" },
          delete = { hl = "GitGutterDelete", text = "_" },
          topdelete = { hl = "GitGutterDelete", text = "‾" },
          changedelete = { hl = "GitGutterChange", text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})
        end
      })
    end,
  },

  -- git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  -- more git
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim'
  },

  -- Have the terminal floating about
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-t>]],
        persist_size = false,
        -- size can be a number or function which is passed the current terminal
        size = function(term)
          if term.direction == "horizontal" then
            return 30
          elseif term.direction == "vertical" then
            -- return vim.o.columns * 2
            return 100
          end
        end
      })
      function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-w>h", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-w>j", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-w>k", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<C-w>l", [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd([[ autocmd! TermOpen term://* lua set_terminal_keymaps() ]])
    end,
  },


  -- Tab magic to jump out of stuff
  {
    "abecodes/tabout.nvim",
    config = function()
      require("tabout").setup({})
    end,
    dependencies = { "nvim-treesitter", "nvim-cmp" },
  },

  -- LSP configuration
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig"
    },
    config = function()
      require("mason").setup()
      local opts = {
        on_attach = require("config/lsp").on_attach
      }
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = {
          "pyright", "volar"
        }
      })

      mason_lspconfig.setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- Default handler (optional)
          require("lspconfig")[server_name].setup {
            on_attach = opts.on_attach,
            capabilities = opts.capabilities,
          }
        end,

        ["pyright"] = function()
          local workspace = vim.fn.getcwd()
          local util = require('lspconfig/util')
          local path = util.path
          local p = 'python'
          local match = vim.fn.glob(path.join(workspace, '.venv'))
          if match ~= '' then
            p = path.join('.venv', 'bin', 'python')
          end
          require("lspconfig").pyright.setup({
            on_attach = opts.on_attach,
            settings = {
              python = {
                pythonPath = p
              }
            },
          })
        end,
    })
    end
  },
  -- non-LSP
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("config/lsp/null")
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- LSP format
  {
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require("lsp-format").setup({ sync = true })
      require("lspconfig").gopls.setup { on_attach = require "lsp-format".on_attach }
    end,
  },

  -- use("onsails/lspkind-nvim")
  -- use({
  --   "ray-x/lsp_signature.nvim",
  --   config = function()
  --     require("lsp_signature").setup({
  --       doc_lines = 0,
  --       floating_window = false,
  --       hint_prefix = " ",
  --     })
  --   end,
  -- })

  -- Show where stuff is failing in projects
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({})
    end,
  },

  -- LSP loading spinners and information
  -- use({
  --   "j-hui/fidget.nvim",
  --   config = function()
  --     require("fidget").setup({})
  --   end,
  -- })

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip").config.setup({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
      },
    },
    config = function()
      return require("config/completion")
    end
  },

  -- Commenting
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },

  -- DAP
  'mfussenegger/nvim-dap',
  'mfussenegger/nvim-dap-python',
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap"},
    config = function()
        require("dapui").setup()
        local dap, dapui = require("dap"), require("dapui")
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
    end
  },

  -- Testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = {"--hypothesis-show-statistics"},
          }),
          require("neotest-plenary"),
        },
        output = {
          enabled = true,
          open_on_run = true,
        },
      })
    end
  }
}, {
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
  },
})
