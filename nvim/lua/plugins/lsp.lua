local servers = {
    "lua_ls",      -- Lua
    "ruff_lsp",    -- Python
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

                if server == "ruff_lsp" then
                    local selects = {
                        "F",     -- Pyflakes: Checks for errors in Python source code
                        "E",     -- pycodestyle: Checks for PEP 8 style compliance
                        "W",     -- pycodestyle: Checks for PEP 8 style compliance
                        "C90",   -- mccabe: Checks for complex code
                        "I",     -- isort: Checks for import order
                        "N",     -- pep8-naming: Checks for naming conventions
                        "D",     -- pydocstyle: Checks for docstring conventions

                        "UP",    -- pyupgrade: Checks for outdated Python syntax
                        "ASYNC", -- flake8-async: Checks for bad async / asyncio practices
                        "S",     -- flake8-bandit: Checks for common security issues
                        "BLE",   -- flake8-blind-except: Checks for blind exceptions
                        "FBT",   -- flake8-boolean-trap: Checks for boolean traps (boolean argument that switches behaviour)
                        "B",     -- flake8-bugbear: Checks for common bugs and design problems
                        "A",     -- flake8-builtins: Checks for shadowing builtins
                        "COM",   -- flake8-commas: Checks for missing trailing commas
                        "C4",    -- flake8-comprehensions: Checks for bad comprehensions (list, dict, set)
                        "DTZ",   -- flake8-datetimez: Checks for the usage of unsafe naive datetime class
                        "ISC",   -- flake8-implicit-str-concat: Checks for string concatenation
                        "G",     -- flake8-logging-format: Checks for bad logging format
                        "INP",   -- flake8-no-pep420: Checks for usage of implicit namespace packages
                        "PIE",   -- flake8-pie: Miscellaneous lints
                        "T20",   -- flake8-print: Checks for print statements
                        "PT",    -- flake8-pytest-style: Checks for common pytest practices
                        "Q",     -- flake8-quotes: Checks for quotes
                        "RSE",   -- flake8-raise: Checks for common raise / reraise patterns
                        "RET",   -- flake8-return: Checks for common return / yield patterns
                        "SLF",   -- flake8-self: Checks for missing self argument
                        "SLOT",  -- flake8-slots: Checks for missing __slots__
                        "SIM",   -- flake8-simplify: Checks for simplifiable statements
                        "TCH",   -- flake8-type-checking: Checks for type checking related issues
                        "ARG",   -- flake8-unused-arguments: Checks for unused arguments
                        "PTH",   -- flake8-use-pathlib: Checks for usage of pathlib
                        "TRY",   -- tryceratops: Checks for common try / except patterns
                        "PERF",  -- Perflint: Checks for common performance issues
                        "FURB",  -- refurb: Checks for common refactoring issues
                        "LOG",   -- flake8-logging: Checks for common logging issues
                        "RUF",   -- Ruff-specific rules
                        "PD",    -- pandas-vet: Checks for common pandas issues
                        "NPY",   -- NumPy-specific rules: Checks for common NumPy issues
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
                        -- Recommended by Ruff formatter
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
