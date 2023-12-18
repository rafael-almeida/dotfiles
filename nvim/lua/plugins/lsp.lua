local nnoremap = function(bufnr, lhs, rhs, desc)
    local opts = { buffer = bufnr, remap = false, desc = desc }
    vim.keymap.set("n", lhs, rhs, opts)
end

local servers = {
    "lua_ls",      -- Lua
    "pyright",     -- Python
    "ruff_lsp",    -- Python
    "gopls",       -- Go
    "templ",       -- Go
    "biome",       -- JSON, Javascript, Typescript
    "html",        -- HTML
    "htmx",        -- HTML
    "cssls",       -- CSS
    "tailwindcss", -- Tailwind CSS
    "svelte",      -- Svelte
    "marksman",    -- Markdown
    "yamlls",      -- YAML
}

return {
    {
        "williamboman/mason.nvim",
        enabled = true,
        build = ":MasonUpdate",
        keys = {
            { "<leader>cm", "<Cmd>Mason<CR>", desc = "Mason" }
        },
        opts = {}
    },
    {
        -- NOTE: This is optional, and it is only being used to auto install servers.
        -- It is the slowers plugin to load. This takes about 20ms to load, while the second slowest takes 10ms (nvim-lspconfig).
        --
        -- It's important to set up the plugins in the following order:
        --   * mason
        --   * mason-lspconfig
        --   * lspconfig
        "williamboman/mason-lspconfig.nvim",
        enabled = false,
        dependencies = {
            { "williamboman/mason.nvim" },
        },
        opts = {
            ensure_installed = servers,
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim",           optional = true },
            { "williamboman/mason-lspconfig.nvim", optional = true },
            { "folke/neodev.nvim" },
            {
                "hrsh7th/nvim-cmp",
                dependencies = {
                    {
                        "L3MON4D3/LuaSnip",
                        dependencies = { "rafamadriz/friendly-snippets" },
                    },
                    { "hrsh7th/cmp-nvim-lsp" },
                    { "hrsh7th/cmp-path" },
                    { "hrsh7th/cmp-buffer" },
                    { "saadparwaiz1/cmp_luasnip" },
                }
            },
        },
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        keys = {
            { "<leader>e", vim.diagnostic.open_float, desc = "nvim-lspconfig: Show diagnostics" },
            { "[d",        vim.diagnostic.goto_prev,  desc = "nvim-lspconfig: Move to previous diagnostic" },
            { "]d",        vim.diagnostic.goto_next,  desc = "nvim-lspconfig: Move to next diagnostic" },
            { "<leader>q", vim.diagnostic.setloclist, desc = "nvim-lspconfig: Add diagnostics to location list" },
        },
        opts = {
            on_attach = function(_, bufnr)
                -- NOTE: Using nvim-cmp instead.
                -- Enables completion triggered by <c-x><c-o>
                -- vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

                nnoremap(bufnr, "<leader>R", "<Cmd>LspRestart<CR>", "Restart language server")
                nnoremap(bufnr, "<leader>wA", vim.lsp.buf.add_workspace_folder, "Add to workspace folders")
                nnoremap(bufnr, "<leader>wR", vim.lsp.buf.remove_workspace_folder, "Remove from workspace folders")
                nnoremap(bufnr, "K", vim.lsp.buf.hover, "Display hover information")
                nnoremap(bufnr, "<C-s>", vim.lsp.buf.signature_help, "Display signature information")
                nnoremap(bufnr, "gD", vim.lsp.buf.declaration, "Jump to the declaration")
                nnoremap(bufnr, "gd", vim.lsp.buf.definition, "Jump to the definition")
                nnoremap(bufnr, "gi", vim.lsp.buf.implementation, "List all implementations")
                nnoremap(bufnr, "gr", vim.lsp.buf.references, "List all references")
                nnoremap(bufnr, "<leader>D", vim.lsp.buf.type_definition, "Jump to definition")
                nnoremap(bufnr, "<leader>rn", vim.lsp.buf.rename, "Rename all references")
                nnoremap(bufnr, "<leader>ca", vim.lsp.buf.code_action, "Select available code action")
                nnoremap(bufnr, "<leader>ft", function()
                    vim.lsp.buf.format({ async = true })
                end, "Format buffer")
            end,
            custom_settings = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = {
                                    "vim" -- Fixes `Undefined global "vim"` warning.
                                },
                                disable = {
                                    "missing-fields" -- Disables `Undefined field` warning. This warning shows up often when using neodev.
                                },
                            },
                            format = {
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
                        -- Don't enforce docstring usage, but enforce the conventions when they do get used.
                        "D100", -- Missing docstring in public module
                        "D101", -- Missing docstring in public class
                        "D102", -- Missing docstring in public method
                        "D103", -- Missing docstring in public function
                        "D104", -- Missing docstring in public package
                        "D105", -- Missing docstring in magic method
                        "D106", -- Missing docstring in public nested class
                        "D107", -- Missing docstring in __init__

                        -- Conflicting lint rules
                        -- Recommended when using Ruff formatter.
                        -- None of these are included in Ruff's default configuration.
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

                        -- Conflicting lint rules (isort)
                        -- Recommended when using Ruff formatter.
                        -- None of these are included in Ruff's default configuration.
                        -- https://docs.astral.sh/ruff/formatter/#conflicting-lint-rules
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
            -- friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- Configures snippet engine. Otherwise, it will throw `snippet engine is not configured` error.
                    end,
                },
                sources =
                    cmp.config.sources(
                        {
                            { name = "nvim_lsp", priority = 4 },
                            { name = "luasnip",  priority = 3 },
                            { name = "path",     priority = 2, max_item_count = 2 },
                            { name = "buffer",   priority = 1, max_item_count = 2 },
                        }
                    ),
                formatting = {
                    format = function(entry, item)
                        local menu = {
                            nvim_lsp = "[LSP]",
                            luasnip  = "[Lua]",
                            path     = "[Path]",
                            buffer   = "[Buff]",
                        }

                        item.menu = menu[entry.source.name]
                        return item
                    end
                },
                mapping = {
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-e>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.abort()
                        else
                            cmp.complete()
                        end
                    end),
                    ["<C-f>"] = cmp.mapping(function(fallback)
                        -- Navigates to next snippet placeholder.
                        -- NOTE: The `fallback` argument is a function that executes the original mapping.
                        if luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-b>"] = cmp.mapping(function(fallback)
                        -- Navigates to previous snippet placeholder.
                        -- NOTE: The `fallback` argument is a function that executes the original mapping.
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lsp = require("lspconfig")
            for _, server in ipairs(servers) do
                local c = { on_attach = opts.on_attach, capabilities = capabilities }

                if not opts.custom_settings[server] then
                    lsp[server].setup(c)
                else
                    if type(opts.custom_settings[server]) == "function" then
                        c = vim.tbl_extend("force", c, opts.custom_settings[server]())
                    else
                        c = vim.tbl_extend("force", c, opts.custom_settings[server])
                    end

                    if server == "lua_ls" then
                        -- NOTE: This must be configured before lspconfig.
                        require("neodev").setup()
                    end

                    lsp[server].setup(c)
                end
            end

            vim.diagnostic.config({
                signs = {
                    severity = { min = vim.diagnostic.severity.ERROR },
                },
                underline = {
                    severity = { min = vim.diagnostic.severity.WARN },
                },
                virtual_text = {
                    source = "if_many",
                },
            })
        end
    },
}
