return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            {
                "<leader>ga",
                "<cmd>Gitsigns stage_hunk<cr>",
                desc = "gitsigns: Stage hunk",
            },
        },
        opts = {
            numhl = true,
        },
    },
    {
        "tpope/vim-fugitive",
        cmd = "Git",
        keys = {
            -- Related keymaps currently in use:
            --  <leader>gs
            --  <leader>gc
            { "<leader>gg", "<cmd>Git<cr>",       desc = "vim-fugitive: Open git status" },
            { "<leader>gp", "<cmd>Git pull<cr>",  desc = "vim-fugitive: Pull from remote" },
            { "<leader>gP", "<cmd>Git push<cr>",  desc = "vim-fugitive: Push to remote" },
            { "<leader>gA", "<cmd>Git add %<cr>", desc = "vim-fugitive: Add current file" },
            { "<leader>gb", "<cmd>Git blame<cr>", desc = "vim-fugitive: Open git blame" },
            { "<leader>gl", "<cmd>Git log<cr>",   desc = "vim-fugitive: Open git log" },
        },
    },
    -- {
    --     "sindrets/diffview.nvim",
    --     cmd = "DiffviewOpen",
    --     keys = function()
    --         local is_open = false
    --         return {
    --             {
    --                 "<leader>gd",
    --                 function()
    --                     if is_open then
    --                         vim.cmd("DiffviewClose")
    --                     else
    --                         vim.cmd("DiffviewOpen")
    --                     end
    --                     is_open = not is_open
    --                 end,
    --                 desc = "diffview: Toggle DiffView"
    --             },
    --         }
    --     end,
    --     opts = {
    --         file_panel = {
    --             win_config = {
    --                 width = 30,
    --             },
    --         }
    --     },
    -- },
    -- {
    --     "rhysd/git-messenger.vim",
    --     cmd = "GitMessenger",
    --     keys = {
    --         {
    --             "<leader>gh",
    --             "<cmd>GitMessenger<cr>",
    --             desc = "git-messenger: Show commit message for the current line",
    --         },
    --     },
    -- },
}
