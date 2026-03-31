return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "tpope/vim-fugitive",
    cmd = "Git",
    keys = {
      -- These keymaps are used by Telescope:
      -- { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "telescope: List git commits" },
      -- { "<leader>gs", "<cmd>Telescope git_status<cr>",  desc = "telescope: List git status" },
      { "<leader>gg", "<cmd>Git<cr>",         desc = "View git status" },
      { "<leader>gp", "<cmd>Git pull<cr>",    desc = "Pull from remote repository" },
      { "<leader>gP", "<cmd>Git push<cr>",    desc = "Push changes to remote repository" },
      { "<leader>gA", "<cmd>Git add %<cr>",   desc = "Stage current file" },
      { "<leader>gb", "<cmd>Git blame<cr>",   desc = "Show git blame for current file" },
      { "<leader>gl", "<cmd>Git log<cr>",     desc = "View git commit log" },
      { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Open git diff tool" },
    },
  },
}
