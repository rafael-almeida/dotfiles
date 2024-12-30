-- TODO:
-- Check if there is overlaps between plugins. I wonder if I need so many git plugins.
-- `vim-fugitive` seems to do a lot of things already.
-- Maybe add comment notes on what each plugin does differently.
return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<leader>gD", "<cmd>Gitsigns preview_hunk<CR>", desc = "gitsigns: Open hunk diff" },
            { "<leader>gA", "<cmd>Gitsigns stage_hunk<CR>",   desc = "gitsigns: Stage hunk" },
        },
        opts = {
            numhl = true,
        },
    },
    {
        "tpope/vim-fugitive",
        -- cmd = { "Git" },
        keys = {
            -- Related keymaps currently in use:
            --  <leader>gs
            --  <leader>gc
            { "<leader>gg", "<cmd>Git<CR>",       desc = "vim-fugitive: Open git status" },
            { "<leader>gp", "<cmd>Git pull<CR>",  desc = "vim-fugitive: Pull from remote" },
            { "<leader>gP", "<cmd>Git push<CR>",  desc = "vim-fugitive: Push to remote" },
            { "<leader>ga", "<cmd>Git add %<CR>", desc = "vim-fugitive: Add current file to git" },
            { "<leader>gb", "<cmd>Git blame<CR>", desc = "vim-fugitive: Open git blame" },
            { "<leader>gl", "<cmd>Git log<CR>",   desc = "vim-fugitive: Open git log" },
        },
    },
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen" },
        keys = function()
            local is_open = false
            return {
                {
                    "<leader>gd",
                    function()
                        if is_open then
                            vim.cmd("DiffviewClose")
                        else
                            vim.cmd("DiffviewOpen")
                        end
                        is_open = not is_open
                    end,
                    desc = "diffview: Toggle DiffView"
                },
            }
        end,
    },
    {
        "rhysd/git-messenger.vim",
        cmd = { "GitMessenger" },
        keys = {
            { "<leader>gh", "<cmd>GitMessenger<CR>", desc = "git-messenger: Show commit message for the current line" },
        },
    },
}
