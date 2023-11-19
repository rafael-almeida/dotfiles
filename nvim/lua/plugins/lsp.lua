local servers = {
    "lua_ls",      -- Lua
    "ruff_lsp",    -- Python
    "pyright",     -- Python
    "gopls",       -- Go
    "templ",       -- Go
    "biome",       -- JSON, Javascript, Typescript
    "html",        -- HTML
    "cssls",       -- CSS
    "tailwindcss", -- Tailwind CSS
    "svelte",      -- Svelte
    "marksman",    -- Markdown
}

return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        keys = {
            { "<leader>cm", "<Cmd>Mason<CR>", desc = "Mason" }
        },
        opts = {
            ensure_installed = servers,
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        opts = {
            ensure_installed = servers,
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
            { "folke/neodev.nvim" },
        },
        keys = {
            { "K",          vim.lsp.buf.hover,           desc = "Hover" },
            { "<C-s>",      vim.lsp.buf.signature_help,  desc = "Signature Help" },
            { "gD",         vim.lsp.buf.declaration,     desc = "Declaration" },
            { "gd",         vim.lsp.buf.definition,      desc = "Definition" },
            { "gi",         vim.lsp.buf.implementation,  desc = "Implementation" },
            { "gr",         vim.lsp.buf.references,      desc = "References" },
            { "<leader>D",  vim.lsp.buf.type_definition, desc = "Type Definition" },
            { "<leader>rn", vim.lsp.buf.rename,          desc = "Rename" },
            { "<leader>ca", vim.lsp.buf.code_action,     desc = "Code Action" },
            {
                "<leader>ft",
                function()
                    vim.lsp.buf.format({ async = true })
                end,
                desc = "Format"
            },
        },
        config = function(_, opts)
            local lsp = require("lspconfig")

            for _, server in ipairs(servers) do
                local c = {
                    on_attach = opts.on_attach,
                }

                if server == "lua_ls" then
                    c.settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }, -- Fix Undefined global "vim" warning
                            },
                            format = {
                                enable = true,
                                defaultConfig = {
                                    quote_style = "double",
                                }
                            }
                        }
                    }
                end

                if server == "pyright" then
                    c = {
                        settings = {
                            python = {
                                analysis = {
                                    ignore = { "**/*" }, -- Disables all linting
                                },
                            }
                        },
                        on_attach = function(client, bufnr)
                            opts.on_attach(client, bufnr)
                            -- Disable formatting capability to prevent conflicts with ruff
                            client.resolved_capabilities.document_formatting = false
                            client.resolved_capabilities.document_range_formatting = false
                        end
                    }
                end

                if server == "ruff_lsp" then
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

                    c.init_options = {
                        settings = {
                            lint = {
                                args = {
                                    -- "--select=ALL",
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
                end

                lsp[server].setup(c)
            end

            local cmp = require("cmp")

            cmp.setup({
                sources = {
                    { name = "nvim_lsp" },
                },
                mapping = cmp.mapping.preset.insert({
                    -- Enter key confirms completion item
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),

                    -- Ctrl + space triggers completion menu
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end,
    }
}
