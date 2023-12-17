local icons = require("config").icons
local commentstring_filetypes = { "svelte" }

return {
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        opts = {}
    },
    {
        "tpope/vim-surround",
        event = { "BufRead", "BufNewFile" },
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufRead", "BufNewFile" },
        opts = function(_, opts)
            if vim.tbl_contains(commentstring_filetypes, vim.bo.filetype) then
                opts.pre_hook = require("ts_context_commentstring").get_commentstring
            end
        end,
    },
    {
        -- This is useful for files with multiple sections, each with a different style for comments (Svelte, Vue, etc).
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = commentstring_filetypes,
        opts = {
            enable_autocmd = false, -- Commentstring is triggered by Comment.nvim
        },
        init = function()
            vim.g.skip_ts_context_commentstring_module = true
        end,
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufRead", "BufNewFile" },
        opts = {}
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "Trouble", "TroubleToggle" },
        keys = {
            { "<leader>xd", "<Cmd>TroubleToggle document_diagnostics<CR>",  desc = "trouble: Toggle document diagnostics" },
            { "<leader>xw", "<Cmd>TroubleToggle workspace_diagnostics<CR>", desc = "trouble: Toggle workspace diagnostics" },
            { "<leader>xq", "<Cmd>TroubleToggle quickfix<CR>",              desc = "trouble: Toggle quickfix list" },
            { "<leader>xl", "<Cmd>TroubleToggle loclist<CR>",               desc = "trouble: Toggle location list" },
        },
        opts = {
            signs = {
                error = icons.diagnostics.error,
                warning = icons.diagnostics.warn,
                hint = icons.diagnostics.hint,
                information = icons.diagnostics.info,
                other = icons.diagnostics.info,
            },
        },
    },
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        keys = {
            {
                "<leader>u",
                function()
                    -- Toggles Undotree and set it as the current window (move the cursor)
                    vim.cmd("UndotreeToggle")
                    for _, win in pairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local buftype = vim.api.nvim_buf_get_option(buf, "filetype")

                        if buftype == "undotree" then
                            vim.api.nvim_set_current_win(win)
                            break
                        end
                    end
                end
            },
            desc = "undotree: Toggle Undotree",
        },
        init = function()
            vim.g.undotree_WindowLayout = 4 -- Moves undotree window to the right, and expand the diff window to full width
        end,
    },
}
