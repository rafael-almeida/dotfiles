return {
  -- Claude Code MCP integration
  -- {
  --   "coder/claudecode.nvim",
  --   opts = {},
  --   keys = {
  --     { "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "Claude Code toggle" },
  --     { "<leader>as", "<cmd>ClaudeCodeSend<CR>", desc = "Send to Claude", mode = "v" },
  --   },
  -- },

  -- Inline ghost-text completions (GitHub Copilot)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<Tab>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<M-e>",
        },
      },
      filetypes = {
        markdown = true,
        help = false,
      },
    },
  },
}
