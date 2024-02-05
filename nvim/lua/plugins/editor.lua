local icons = require("config").icons
local commentstring_filetypes = { "svelte", "typescriptreact" }

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
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = commentstring_filetypes,
        opts = {
            enable_autocmd = false, -- Commentstring is triggered by Comment.nvim
        },
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufRead", "BufNewFile" },
        opts = {
            pre_hook = function(ctx)
                return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(ctx)
            end,
        }
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
