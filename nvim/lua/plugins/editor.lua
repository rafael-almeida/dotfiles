return {
  -------------------------------------------------------------------------------------------------
  --- File Editing --------------------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------

  -- Commenting
  {
    "numToStr/Comment.nvim",
    dependencies = {
      {
        -- NOTE(2026-03-28): Comment.nvim already supports treesitter out-of-the-box for all the languages except tsx/jsx.
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = {
          { "nvim-treesitter/nvim-treesitter" }
        },
        opts = {
          enable_autocmd = false,
        },
      },
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      pre_hook = function(ctx)
        return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(ctx)
      end,
    }
  },

  -- Auto-close brackets/quotes
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {}
  },

  -- Auto-close HTML tags
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" }
    },
    ft = { "astro", "glimmer", "handlebars", "html", "javascript", "jsx", "markdown", "php", "rescript", "svelte", "tsx", "twig", "typescript", "vue", "xml" },
    opts = {}
  },

  -- Automatically detect and set indentation based on the current file or neighboring files of the same type
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Surround operations (ys, cs, ds)
  {
    "tpope/vim-surround",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Toggle between single-line and multi-line code structures
  {
    "Wansmer/treesj",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" }
    },
    opts = {
      max_join_length = 9999,
    },
    keys = {
      {
        "<leader>m",
        "<cmd>TSJToggle<cr>",
        desc = "treesj: Toggle between single-line and multi-line",
      },
      {
        "<leader>M",
        function()
          require("treesj").toggle({
            split = {
              recursive = true,
            },
          })
        end,
        desc = "treesj: Toggle between single-line and multi-line (recursively)",
      },
    },
  },

  -------------------------------------------------------------------------------------------------
  --- File Navigation and Search ------------------------------------------------------------------
  -------------------------------------------------------------------------------------------------

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    lazy = false, -- NOTE(2026-03-28): neo-tree will lazily load itself
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
          never_show = {
            ".git",
            "node_modules",
          },
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
      -- window = {
      --   width = 50,
      -- }
    },
    keys = {
      {
        "<leader>n",
        "<cmd>Neotree toggle<cr>",
        desc = "Neotree: Toggle sidebar",
      }
    },
  },

  -- Seamless navigation between tmux panes and Neovim splits
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  desc = "Navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>",  desc = "Navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>",    desc = "Navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    opts = {
      defaults = {
        layout_config = {
          preview_width = 0.70,
          width = 0.95,
          height = 0.99,
        },
        file_ignore_patterns = { "node_modules", ".git/" },
        path_display = { "truncate" },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      pcall(telescope.load_extension, "fzf")
    end,
    keys = {
      -- Find
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",              desc = "telescope: Search for help tags" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>",                desc = "telescope: Search for keybindings" },
      { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "telescope: Search for files (includes hidden)" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",              desc = "telescope: Search for text" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>",            desc = "telescope: Search for word under the cursor" },
      { "<leader>fv", "<cmd>Telescope vim_options<cr>",            desc = "telescope: Search for vim options" },
      -- Git
      -- NOTE(2026-03-28): this might be redundant. I want to see if other git plugins provide similar functionality.
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",            desc = "telescope: List git commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>",             desc = "telescope: List git status" },
    }
  },

  -- Undo history visualizer
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" }

    },
    init = function()
      vim.g.undotree_WindowLayout = 4       -- Positions the undotree window on the right and sets the diff window to full width.
      vim.g.undotree_SetFocusWhenToggle = 1 -- Automatically focuses the undotree window when toggled.
    end,
  },

}
