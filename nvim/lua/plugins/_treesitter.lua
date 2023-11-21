local parsers = {
    'markdown',
    'json',
    'yaml',
    'lua',
    'python',
    'go',
    'javascript',
    'typescript',
    'svelte',
    'css',
    'c',
}

-- TODO: I would like to have something to incrementally select nested objects, such as Python dictionaries.

return {
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = { 'BufReadPost', 'BufNewFile' },
        keys = {
            -- TODO: I might not need this.
            {
                '[c',
                function()
                    require('treesitter-context').go_to_context()
                end,
            },
        },
        config = function()
            require('treesitter-context').setup()
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-context',     lazy = true }, -- Shows the current code context, e.g., class name > function name > condition > loop.
            { 'nvim-treesitter/nvim-treesitter-textobjects', lazy = true }, -- Enhances `commentstring` for embedded languages in certain types of files, e.g., React, Svelte, and Vue (html, css, and js in a single file).
            -- { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true }, -- Defines custom text object mappings.
        },
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        cmd = { 'TSUpdateSync' },
        opts = {
            ensure_installed = parsers,
            highlight = { enable = true },
            indent = { enable = true },

            incremental_selection = {
                enable = true, -- TODO: I don't think I will use these.
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },

            -- nvim-ts-context-commentstring
            --context_commentstring = {
            --    enable = true,
            --    enable_autocmd = false,
            --},
            -- end

            -- nvim-treesitter-textobjects
            textobjects = {
                -- I found `select` particularly useful for languages like Python.
                -- TODO: this does not seem to work with Typescript inside of Svelte
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['iif'] = '@function.inner',
                        ['iof'] = '@function.outer',
                        ['iic'] = '@class.inner',
                        ['ioc'] = '@class.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_previous = {
                        ["<leader>ah"] = "@parameter.inner",
                    },
                    swap_next = {
                        ["<leader>al"] = "@parameter.inner",
                    },
                },
                move = { enable = false },
            },
            -- end
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end
    }
}
