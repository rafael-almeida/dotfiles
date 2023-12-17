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
}
