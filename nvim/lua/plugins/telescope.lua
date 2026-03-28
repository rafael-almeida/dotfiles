return {
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
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",            desc = "telescope: List git commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>",             desc = "telescope: List git status" },
    }
  }
}
