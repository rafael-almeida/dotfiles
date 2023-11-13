local icons = require("config").icons

return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
    },
    -- build = ':PylspInstall python-lsp-black',  -- TODO: fix this
    init = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
            "lua_ls",
            "html",
            "cssls",
            "pylsp",
            "tsserver",
            "ruff_lsp",
        })

        lsp.nvim_workspace() -- Fix Undefined global 'vim'

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        })

        cmp_mappings["<Tab>"] = nil
        cmp_mappings["<S-Tab>"] = nil

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = icons.error,
                warn = icons.warn,
                hint = icons.hint,
                info = icons.info
            }
        })

        local default_setup = function(_, bufnr)
            local bufopts = { buffer = bufnr, remap = false }
            vim.keymap.set("n", "<leader>R", ":LspRestart<CR>")
            vim.keymap.set("n", "<leader>wA", vim.lsp.buf.add_workspace_folder, bufopts)
            vim.keymap.set("n", "<leader>wR", vim.lsp.buf.remove_workspace_folder, bufopts)

            -- TODO: This does not seem useful to me.
            -- vim.keymap.set("n", "<leader>wL", function()
            --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            -- end, bufopts)

            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
            vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
            vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set("n", "<leader>ft", function()
                vim.lsp.buf.format({ async = true })
            end, bufopts)
        end

        lsp.on_attach(default_setup)

        require("lspconfig").lua_ls.setup({
            on_attach = default_setup,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }, -- Fix Undefined global 'vim' warning
                    },
                    format = {
                        enable = true,
                        defaultConfig = {
                            quote_style = "double",
                        }
                    }
                }
            }
        })


        require("lspconfig").ruff_lsp.setup({
            on_attach = default_setup,
            init_options = {
                settings = {
                    args = {}
                },
            }
        })

        -- require("lspconfig").pylsp.setup({
        --     on_attach = default_setup,
        --     settings = {
        --
        --         pylsp = {
        --             configurationSources = { "flake8" },
        --             plugins = {
        --                 -- Enabling flake8 for comprehensive error checking, with specific ignores and line length settings
        --                 flake8 = {
        --                     ignore = {
        --                     enabled = true,
        --                         "W503", -- line break before binary operator
        --                         "E203" -- whitespace before ':'
        --                     },
        --                     maxLineLength = 120
        --                 },
        --
        --                 -- Enabling Black for formatting with a maximum line length of 200
        --                 black = {
        --                     enabled = true,
        --                     extraArgs = { "--line-length", "200" }
        --                 },
        --
        --                 -- Enabling isort for import sorting with configuration
        --                 isort = {
        --                     enabled = true,
        --                     -- Additional configuration for isort can be added here
        --                 },
        --
        --                 -- Optional: Enable pydocstyle for docstring style checking
        --                 -- pydocstyle = {
        --                 --     enabled = true,
        --                 --     convention = 'numpy'  -- or 'pep257'
        --                 -- },
        --
        --                 -- Optional: Enable pylint for advanced linting
        --                 -- pylint = {
        --                 --     enabled = true,
        --                 --     args = { "--rcfile", "~/.pylintrc" }  -- Path to pylint configuration file
        --                 -- },
        --
        --                 -- Disabled linters (since they overlap with flake8)
        --                 pyflakes = { enabled = false },
        --                 pycodestyle = { enabled = false },
        --                 mccabe = { enabled = false },
        --
        --                 -- Disabled formatters (since Black and isort are enabled)
        --                 autopep8 = { enabled = false },
        --                 yapf = { enabled = false },
        --
        --                 -- Additional plugins can be configured as needed
        --                 -- jedi_completion, jedi_definition, jedi_hover, etc.
        --             }
        --         }
        --         -- pylsp = {
        --         --     configurationSources = { "flake8" },
        --         --     plugins = {
        --         --         -- Rope for Completions and renaming
        --         --
        --         --         -- Pyflakes linter to detect various errors
        --         --         -- McCabe linter for complexity checking
        --         --         -- pycodestyle linter for style checking
        --         --         -- pydocstyle linter for docstring style checking (disabled by default)
        --         --         -- pylint for code linting (disabled by default)
        --         --         -- flake8 for error checking (disabled by default)
        --         --
        --         --         -- code checking
        --         --         -- flake8 automatically runs pyflakes, pycodestyle, and mccabe
        --         --         flake8 = { enabled = true, ignore = { "W503", "E203" }, maxLineLength = 120 },
        --         --         pyflakes = { enabled = false },
        --         --         pycodestyle = { enabled = false },
        --         --         mccabe = { enabled = false },
        --         --
        --         --         -- formatter
        --         --         black = { enabled = true }, -- TODO: black recommends flake8-bugbear plugin for proper flake8 integration
        --         --         autopep8 = { enabled = false },
        --         --         yapf = { enabled = false },
        --         --
        --         --         isort = { enabled = true } -- TODO: this does not seem to support the `profile` option, as recommended by black
        --         --
        --         --
        --         --         -- jedi_completion = { enabled = false },
        --         --         -- jedi_definition = { enabled = false },
        --         --         -- jedi_hover = { enabled = false },
        --         --         -- jedi_references = { enabled = false },
        --         --         -- jedi_signature_help = { enabled = false },
        --         --         -- jedi_symbols = { enabled = false },
        --         --         --
        --         --         -- preload = { enabled = false },
        --         --         -- pydocstyle = { enabled = false, convention = 'pep257' },
        --         --         -- pylint = { enabled = false },
        --         --         -- rope_autoimport = { enabled = false, memory = false },
        --         --         -- rope_completion = { enabled = false },
        --         --     }
        --         -- }
        --     }
        -- })


        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true
        })
    end
}
