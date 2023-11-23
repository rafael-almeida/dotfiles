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
            -- { "JoosepAlviste/nvim-ts-context-commentstring" },
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
                move = {
                    enable = true,
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

    }

    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     version = false,
    --     cmd = { "TSUpdateSync" },
    --     event = { "BufReadPost", "BufNewFile" },
    --     build = ":TSUpdate",
    --     dependencies = {
    --         -- { "nvim-treesitter/nvim-treesitter-context" },     -- Shows the current code context, e.g., class name > function name > condition > loop.
    --         -- { "nvim-treesitter/nvim-treesitter-textobjects" }, -- Enhances `commentstring` for embedded languages in certain types of files, e.g., React, Svelte, and Vue (html, css, and js in a single file).
    --         -- { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true }, -- Defines custom text object mappings.
    --     },
    --     opts = {
    --         ensure_installed = parsers,
    --         highlight = { enable = true },
    --         indent = { enable = true },
    --
    --         incremental_selection = {
    --             enable = true, -- TODO: I don't think I will use these.
    --             keymaps = {
    --                 init_selection = "gnn",
    --                 node_incremental = "grn",
    --                 scope_incremental = "grc",
    --                 node_decremental = "grm",
    --             },
    --         },
    --
    --         -- nvim-ts-context-commentstring
    --         --context_commentstring = {
    --         --    enable = true,
    --         --    enable_autocmd = false,
    --         --},
    --         -- end
    --
    --         -- nvim-treesitter-textobjects
    --         textobjects = {
    --             -- I found `select` particularly useful for languages like Python.
    --             -- TODO: this does not seem to work with Typescript inside of Svelte
    --             select = {
    --                 enable = true,
    --                 lookahead = true,
    --                 keymaps = {
    --                     ["iif"] = "@function.inner",
    --                     ["iof"] = "@function.outer",
    --                     ["iic"] = "@class.inner",
    --                     ["ioc"] = "@class.outer",
    --                 },
    --             },
    --             swap = {
    --                 enable = true,
    --                 swap_previous = {
    --                     ["<leader>ah"] = "@parameter.inner",
    --                 },
    --                 swap_next = {
    --                     ["<leader>al"] = "@parameter.inner",
    --                 },
    --             },
    --             move = { enable = false },
    --         },
    --         -- end
    --     },
    --     init = function(plugin)
    --         -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    --         -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    --         -- no longer trigger the **nvim-treeitter** module to be loaded in time.
    --         -- Luckily, the only thins that those plugins need are the custom queries, which we make available
    --         -- during startup.
    --         require("lazy.core.loader").add_to_rtp(plugin)
    --         require("nvim-treesitter.query_predicates")
    --     end,
    --     config = function(_, opts)
    --         require("nvim-treesitter.configs").setup(opts)
    --     end
    -- },
}
