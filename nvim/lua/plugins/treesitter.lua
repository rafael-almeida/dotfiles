local util = require("config.util")

local parsers = {
    "lua",
    "python",
    "go",
    "javascript",
    "typescript",
    "tsx",
    "vue",
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
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts = {
            auto_install = true,
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
        main = "nvim-treesitter.configs",
        init = function(plugin)
            -- NOTE: Copied from LazyVim
            -- Makes sure that the treesitter queries are available early, so other plugins can use them.
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            max_lines = 2,
        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

            -- Repeats latest textobjects movement
            util.noremap({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            util.noremap({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- ts_repeat_move does not work with f, F, t, T by default. This fixes that.
            util.noremap({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
            util.noremap({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
            util.noremap({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
            util.noremap({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
        end
    },
}
