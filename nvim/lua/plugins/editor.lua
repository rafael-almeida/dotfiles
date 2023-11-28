local parsers = {
    "lua",
    "python",
    "go",
    "javascript",
    "typescript",
    "svelte",
    "html",
    "css",
    "json",
    "markdown",
    "yaml",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        build = ":TSUpdate",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
        opts = {
            ensure_installed = parsers,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "tt",
                    node_incremental = "tt",
                    node_decremental = "tT",
                    scope_incremental = false,
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["ab"] = "@block.outer",
                        ["ib"] = "@block.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["is"] = "@statement.inner",
                        ["as"] = "@statement.outer",
                        ["ad"] = "@comment.outer",
                        ["am"] = "@call.outer",
                        ["im"] = "@call.inner",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>al"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>ah"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@class.outer"
                    },
                    goto_previous_start = {
                        ["[F"] = "@function.outer",
                        ["[C"] = "@class.outer"
                    },
                    goto_previous_end = {
                        ["]F"] = "@function.outer",
                        ["]C"] = "@class.outer"
                    },
                },
            },

        },
        init = function(plugin)
            -- NOTE: Copied from LazyVim
            -- Makes sure that the treesitter queries are available early, so other plugins can use them.
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        config = function(_, opts)
            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

            -- Repeats latest textobjects movement
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- ts_repeat_move does not work with f, F, t, T by default. This fixes that.
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

            require("nvim-treesitter.configs").setup(opts)
        end
    },
    {
        -- Shows the current code context.
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
        },
        opts = {
            max_lines = 2,
        },
        config = function(_, opts)
            require("treesitter-context").setup(opts)
        end,
    },
    {
        -- This is useful for files with multiple sections, each with a different style for comments (Svelte, Vue, etc).
        "JoosepAlviste/nvim-ts-context-commentstring",
        ft = { "svelte", "vue" },
        opts = {
            enable_autocmd = false, -- Commentstring is trigger by Comment.nvim
        },
        config = function(_, opts)
            require("ts_context_commentstring").setup(opts)
            vim.g.skip_ts_context_commentstring_module = true
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufRead", "BufNewFile" },
        config = function()
            local c = {}

            -- Enables commenting for files with multiple sections (Svelte, Vue, etc).
            local has_ts_context_commentstring, ts_context_commentstring = pcall(require, "ts_context_commentstring")
            if has_ts_context_commentstring then
                c.pre_hook = ts_context_commentstring.get_commentstring
            end

            require("Comment").setup(c)
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "tpope/vim-surround",
        event = { "BufRead", "BufNewFile" },
    },
    {
        -- TODO: There is a better plugin for this called zbirenbaum/copilot.lua
        "github/copilot.vim",
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    },
}
