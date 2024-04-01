local icons = require("config").icons

return {
    {
        "numToStr/Comment.nvim",
        dependencies = {
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                dependencies = { "nvim-treesitter/nvim-treesitter" },
                ft = { "vue", "svelte", "javascriptreact", "typescriptreact" },
                opts = {
                    enable_autocmd = false,
                },
            },
        },
        event = { "BufRead", "BufNewFile" },
        opts = {
            pre_hook = function(ctx)
                return require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()(ctx)
            end,
        }
    },
    {
        "windwp/nvim-ts-autotag",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte", "vue", "tsx", "jsx", "xml", "markdown"  },
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = true
    },
    {
        "tpope/vim-surround",
        event = { "BufRead", "BufNewFile" },
    },
    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufRead", "BufNewFile" },
        config = true
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
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
            highlight = {
                keyword = "fg",
                pattern = [[.*<(KEYWORDS)\s*]]
            }
        }
    }
}
