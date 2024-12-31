-- vim.filetype.add({
--     extension = {
--         templ = "templ",
--     },
-- })

--     signs = {
-- vim.diagnostic.config({
--         severity = { min = vim.diagnostic.severity.ERROR },
--     },
--     underline = {
--         severity = { min = vim.diagnostic.severity.WARN },
--     },
--     virtual_text = {
--         source = "if_many",
--     },
-- })
local util = require("config.util")
local server_settings = require("plugins.lsp.servers")

local servers = {
    "lua_ls",
    "pyright",
    "ruff",
    "gopls",
    "html",
    "htmx",
    "cssls",
    "tailwindcss",
    "marksman",
    "templ",
    "volar",
    "ts_ls",
}

local lsp_keymaps = {
    {
        "<leader>R",
        function()
            vim.cmd("LspRestart")
            vim.cmd("echomsg 'LSP reloaded!'")
        end,
        "Restart language server"
    },
    { "K",          vim.lsp.buf.hover,           "Display hover information" },
    { "<C-s>",      vim.lsp.buf.signature_help,  "Display signature information" },
    { "gD",         vim.lsp.buf.declaration,     "Jump to the declaration" },
    { "gd",         vim.lsp.buf.definition,      "Jump to the definition" },
    { "gi",         vim.lsp.buf.implementation,  "List all implementations" },
    { "gr",         vim.lsp.buf.references,      "List all references" },
    { "<leader>D",  vim.lsp.buf.type_definition, "Jump to definition" },
    { "<leader>rn", vim.lsp.buf.rename,          "Rename all references" },
    { "<leader>ca", vim.lsp.buf.code_action,     "Select available code action" },
}


-- NOTE: Set up the plugins in the following order:
-- mason.nvim
-- mason-lspconfig.nvim
-- lspconfig servers
return {
    {

        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {}
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            { "williamboman/mason.nvim" },
        },
        opts = {
            ensure_installed = servers,
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                version = "v2.3",
                dependencies = { "rafamadriz/friendly-snippets" },
                build = "make install_jsregexp"
            },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "saadparwaiz1/cmp_luasnip" },

        },
        config = function()
            -- friendly-snippets
            -- Quoting from the README:
            -- If you're using LuaSnip make sure to use require("luasnip.loaders.from_vscode").lazy_load(),
            -- and add friendly-snippets as a dependency for LuaSnip, otherwise snippets might not be detected.
            -- If you don't use lazy_load() you might notice a slower startup-time
            require("luasnip.loaders.from_vscode").lazy_load()

            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        -- Configure snippet engine. Otherwise, it will throw `snippet engine is not configured` error.
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = function(entry, item)
                        local menu = {
                            copilot  = "[Copilot]",
                            nvim_lsp = "[LSP]",
                            luasnip  = "[Snip]",
                            buffer   = "[Buff]",
                            path     = "[Path]",
                        }

                        item.menu = menu[entry.source.name]

                        local ok, tailwindcss_colorizer_cmp = pcall(require, "tailwindcss-colorizer-cmp")
                        if ok then
                            return tailwindcss_colorizer_cmp.formatter(entry, item)
                        end

                        return item
                    end
                },
                mapping = {
                    -- Confirm completion menu
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                    -- Toggle completion menu
                    ["<C-e>"] = cmp.mapping(function()
                        if cmp.visible() then
                            cmp.abort()
                        else
                            cmp.complete()
                        end
                    end),

                    -- Navigate menu items
                    ["<C-u>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior, count = 5 }),
                    ["<C-d>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior, count = 5 }),

                    -- Navigate to next menu item / snippet placeholder
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        elseif luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    -- Navigate to previous menu item / snippet placeholder
                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
            })

            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            { "williamboman/mason.nvim",           optional = true },
            { "williamboman/mason-lspconfig.nvim", optional = true },
            { "hrsh7th/nvim-cmp" },
            { "folke/neodev.nvim" }, -- TODO: replace this with folke/lazydev.nvim (neovim >= 0.10)
        },
        keys = {
            { "<leader>e", vim.diagnostic.open_float, desc = "Show diagnostics" },
            { "[d",        vim.diagnostic.goto_prev,  desc = "Move to previous diagnostic" },
            { "]d",        vim.diagnostic.goto_next,  desc = "Move to next diagnostic" },
            { "<leader>q", vim.diagnostic.setloclist, desc = "Add diagnostics to location list" },
        },
        opts = {
            on_attach = function(_, bufnr)
                for _, key in ipairs(lsp_keymaps) do
                    util.nnoremap(bufnr, key[1], key[2], key[3])
                end
            end
        },
        config = function(_, opts)
            -- Copied from ThePrimeagen's config. I am not sure if this is necessary. At some point, I will investigate.
            local capabilities = vim.tbl_deep_extend(
                "force", {}, vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities()
            )

            local lsp = require("lspconfig")

            for _, server in ipairs(servers) do
                if server == "lua_ls" then
                    -- NOTE: This MUST be configured before lspconfig.
                    require("neodev").setup()
                end

                local c = { on_attach = opts.on_attach, capabilities = capabilities }

                if server_settings[server] ~= nil then
                    c = util.tbl_extend(c, server_settings[server])
                end

                lsp[server].setup(c)
            end
        end,
    },
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        ft = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
        },
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 15,
            })
        end
    },
    {
        "stevearc/conform.nvim",
        -- cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>ft",
                function()
                    require("conform").format(
                        { async = true, lsp_fallback = true }
                    )
                end,
                desc = "conform: Format"
            },
        },
        opts = {
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                markdown = { "prettier" },
            },
        },
    },
}
