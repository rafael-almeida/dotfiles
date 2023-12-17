return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>gd", "<Cmd>Gitsigns preview_hunk<CR>",    desc = "gitsigns: Open hunk diff" },
            { "<leader>ga", "<Cmd>Gitsigns stage_hunk<CR>",      desc = "gitsigns: Stage hunk" },
        },
        opts = {
            numhl = true,
            linehl = true,
        },
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git" },
        keys = {
            -- Related keymaps currently in use:
            --  <leader>gs
            --  <leader>gc
            { "<leader>gg", "<Cmd>Git<CR>",         desc = "vim-fugitive: Open git status" },
            { "<leader>gp", "<Cmd>Git pull<CR>",    desc = "vim-fugitive: Pull from remote" },
            { "<leader>gP", "<Cmd>Git push<CR>",    desc = "vim-fugitive: Push to remote" },
            { "<leader>gD", "<Cmd>Gvdiffsplit<CR>", desc = "vim-fugitive: Open git diff" },
            { "<leader>gA", "<Cmd>Git add %<CR>",   desc = "vim-fugitive: Add current file to git" },
            { "<leader>gb", "<Cmd>Git blame<CR>",   desc = "vim-fugitive: Open git blame" },
            { "<leader>gl", "<Cmd>Git log<CR>",     desc = "vim-fugitive: Open git log" },
        },
    },
    {
        "rhysd/git-messenger.vim",
        cmd = { "GitMessenger" },
        keys = {
            { "<leader>gh", "<Cmd>GitMessenger<CR>", desc = "git-messenger: Show commit message for the current line" },
        },
    }
}
