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
                print("Setting up LSP for " .. server)

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
                    c.init_options = {
                        settings = {
                            lint = {
                                args = {
                                    -- https://docs.astral.sh/ruff/rules
                                    "--select=ALL",
                                    -- E501: line too long
                                    "--ignore=E501",
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
