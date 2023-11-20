local servers = {
    "lua_ls",   -- Lua
    "pyright",  -- Python
    "ruff_lsp", -- Python
    -- "gopls",       -- Go
    -- "templ",       -- Go
    -- "biome",       -- JSON, Javascript, Typescript
    -- "html",        -- HTML
    -- "cssls",       -- CSS
    -- "tailwindcss", -- Tailwind CSS
    -- "svelte",      -- Svelte
    -- "marksman",    -- Markdown
}

return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason", -- According to the docs, lazy-loading is not recommended
        build = ":MasonUpdate",
        keys = {
            { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" }
        },
        config = function()
            require("mason").setup()
        end
    },
    {
        -- This plugin is not required
        -- This is only being used to auto install servers
        -- NOTE: It is the slowers plugin to load. It takes about 20ms to load, while the second slowest takes 10ms (nvim-lspconfig)
        --
        -- It's important to set up the plugins in the following order:
        --   * mason
        --   * mason-lspconfig
        --   * lspconfig
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            { "williamboman/mason.nvim" },
        },
        opts = {
            ensure_installed = servers,
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
        end
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim", optional = true },
            -- { "hrsh7th/nvim-cmp" },
            -- { "hrsh7th/cmp-nvim-lsp" },
            -- { "L3MON4D3/LuaSnip" },
            -- { "folke/neodev.nvim" },
        },
        keys = {
            { "<leader>e", vim.diagnostic.open_float, desc = "" },
            { "[d",        vim.diagnostic.goto_prev,  desc = "" },
            { "]d",        vim.diagnostic.goto_next,  desc = "" },
            { "<leader>q", vim.diagnostic.setloclist, desc = "" },
        },
        opts = {
            on_attach = function(_, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

                local bufopts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "<leader>R", ":LspRestart<CR>")
                vim.keymap.set("n", "<leader>wA", vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set("n", "<leader>wR", vim.lsp.buf.remove_workspace_folder, bufopts)
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
            end,
            custom_settings = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }, -- Fix `Undefined global "vim"` warning
                            },
                            format = {
                                enable = true,
                                defaultConfig = {
                                    quote_style = "double",
                                }
                            }
                        }
                    }
                },
                ruff_lsp = function()
                    local selects = {
                        "F",     -- Pyflakes: Identifies common errors in code
                        "E",     -- pycodestyle: Enforces PEP 8 style guidelines
                        "W",     -- pycodestyle: Warns about style and complexity
                        "C90",   -- mccabe: Checks function cyclomatic complexity
                        "I",     -- isort: Sorts import statements
                        "N",     -- pep8-naming: Checks PEP 8 naming conventions
                        "D",     -- pydocstyle: Ensures docstring conventions
                        "UP",    -- pyupgrade: Upgrades syntax for newer Python versions
                        "ASYNC", -- flake8-async: Lints async/await syntax
                        "S",     -- flake8-bandit: Security-focused static analysis
                        "BLE",   -- flake8-blind-except: Warns against bare 'except:'
                        "FBT",   -- flake8-boolean-trap: Detects confusing boolean checks
                        "B",     -- flake8-bugbear: Finds bugs and design issues
                        "A",     -- flake8-builtins: Prevents overwriting built-ins
                        "COM",   -- flake8-commas: Enforces trailing commas
                        "C4",    -- flake8-comprehensions: Optimizes comprehensions
                        "DTZ",   -- flake8-datetimez: Safeguards date/time usage
                        "ISC",   -- flake8-implicit-str-concat: Flags implicit concatenation
                        "G",     -- flake8-logging-format: Standardizes logging formats
                        "INP",   -- flake8-no-pep420: Disallows PEP 420 namespaces
                        "PIE",   -- flake8-pie: Extends error checking
                        "T20",   -- flake8-print: Checks for print statements
                        "PT",    -- flake8-pytest-style: Enforces pytest style rules
                        "Q",     -- flake8-quotes: Standardizes quote usage
                        "RSE",   -- flake8-raise: Ensures proper exception raising
                        "RET",   -- flake8-return: Analyzes function returns
                        "SLF",   -- flake8-self: Checks 'self' usage in methods
                        "SLOT",  -- flake8-slots: Verifies '__slots__' usage
                        "SIM",   -- flake8-simplify: Simplifies code structures
                        "TCH",   -- flake8-type-checking: Ensures proper type hinting
                        "ARG",   -- flake8-unused-arguments: Finds unused arguments
                        "PTH",   -- flake8-use-pathlib: Promotes 'pathlib' usage
                        "TRY",   -- tryceratops: Analyzes try/except blocks
                        "PERF",  -- Perflint: Identifies performance-impacting patterns
                        "FURB",  -- refurb: Updates outdated Python syntax
                        "LOG",   -- flake8-logging: Checks logging usage
                        "RUF",   -- Ruff-specific rules: Unique to Ruff linter
                    }

                    local ignores = {
                        "E501", -- line too long

                        -- Docstring conventions
                        -- Don't enforce docstring usage, but enforce the conventions when they do get used
                        "D100", -- Missing docstring in public module
                        "D101", -- Missing docstring in public class
                        "D102", -- Missing docstring in public method
                        "D103", -- Missing docstring in public function
                        "D104", -- Missing docstring in public package
                        "D105", -- Missing docstring in magic method
                        "D106", -- Missing docstring in public nested class
                        "D107", -- Missing docstring in __init__

                        -- Conflicting lint rules
                        -- Recommended by Ruff when using their formatter
                        -- None of these are included in Ruff's default configuration
                        -- https://docs.astral.sh/ruff/formatter/#conflicting-lint-rules
                        "W191",   -- tab-indentation
                        "E111",   -- indentation-with-invalid-multiple
                        "E114",   -- indentation-with-invalid-multiple-comment
                        "E117",   -- over-indented
                        "D206",   -- indent-with-spaces
                        "D300",   -- triple-single-quotes
                        "Q000",   -- bad-quotes-inline-string-concatenation
                        "Q001",   -- bad-quotes-multiline-string
                        "Q002",   -- bad-quotes-docstring
                        "Q003",   -- avoidable-escaped-quote
                        "COM812", -- missing-trailing-comma
                        "COM819", -- prohibited-trailing-comma
                        "ISC001", -- single-line-implicit-string-concatenation
                        "ISC002", -- multi-line-implicit-string-concatenation

                        -- Conflicting lint rules
                        -- TODO: Disable the following isort settings:
                        -- force-single-line
                        -- force-wrap-aliases
                        -- lines-after-imports
                        -- lines-between-types
                        -- split-on-trailing-comma
                    }

                    return {
                        init_options = {
                            settings = {
                                lint = {
                                    args = {
                                        "--select=" .. table.concat(selects, ","),
                                        "--ignore=" .. table.concat(ignores, ","),
                                    }
                                },
                                format = {
                                    args = {
                                        "--line-length=320",
                                    }
                                },
                            }
                        }
                    }
                end,
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                ignore = { "**/*" }, -- Disables linting; managed by Ruff. Pyright is used only for language server features (hover, go to definition, etc).
                            },
                        }
                    },
                },
            }
        },
        config = function(_, opts)
            local lsp = require("lspconfig")

            for _, server in ipairs(servers) do
                local c = { on_attach = opts.on_attach }

                if not opts.custom_settings[server] then
                    lsp[server].setup(c)
                end

                if type(opts.custom_settings[server]) == "function" then
                    c = vim.tbl_extend("force", c, opts.custom_settings[server]())
                else
                    c = vim.tbl_extend("force", c, opts.custom_settings[server])
                end

                lsp[server].setup(c)
            end
        end
    }
}
