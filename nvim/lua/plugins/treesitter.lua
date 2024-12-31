return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
        opts = {
            auto_install = true,
            ensure_installed = { "lua", "python", "go", "javascript", "typescript", "html", "css", "json", "markdown", "yaml" },
            highlight = { enable = true },
            indent = { enable = true },
            -- TODO: Decide how useful these really are:
            incremental_selection = {
                enable = true,
                keymaps = {
                    node_incremental = "tt",
                    node_decremental = "TT",
                    scope_incremental = false,
                },
            },
            -- Uses `nvim-treesitter-textobjects`.
            -- TODO: Decide how useful these really are:
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
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
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["[c"] = "@class.outer",
                        ["[f"] = "@function.outer",
                    },
                    goto_next_end = {
                        ["]c"] = "@class.outer",
                        ["]f"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["[C"] = "@class.outer",
                        ["[F"] = "@function.outer",
                    },
                    goto_previous_end = {
                        ["]C"] = "@class.outer",
                        ["]F"] = "@function.outer",
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
            },

        },
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
        },
        -- TODO: Is this really necessary?
        -- config = function()
        --     local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
        --     -- Ensures ; goes forward and , goes backward regardless of the last direction
        --     vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        --     vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
        --     -- Makes builtin f, F, t, T also repeatable with ; and ,
        --     vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        --     vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        --     vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        --     vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        -- end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" }
        },
        opts = {
            max_lines = 2,
        },
    },
}
