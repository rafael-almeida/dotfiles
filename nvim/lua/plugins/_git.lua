return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            numhl = true,
            linehl = false, -- TODO: I wanted to try this, but the text color in replace mode is too hard to see. That needs to be fixed before it can be used.
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git" },
        keys = {
            -- Related keymaps currently in use:
            --  <leader>gs
            --  <leader>gc
            { "<leader>gg", "<Cmd>Git<CR>" },
            { "<leader>gd", "<Cmd>Gdiffvsplit<CR>" }, -- TODO: This command does not seem to exist.
            { "<leader>ga", "<Cmd>Git add %<CR>" },
        },
    },
    {
        "rhysd/git-messenger.vim",
        cmd = { "GitMessenger" },
        keys = {
            { "<leader>gh", vim.cmd.GitMessenger, desc = "git-messenger: Show commit message for the current line" },
        },
    }
}
