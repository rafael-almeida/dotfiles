local nnoremap = function(bufnr, lhs, rhs, desc)
    local opts = { buffer = bufnr, remap = false, desc = desc }
    vim.keymap.set("n", lhs, rhs, opts)
end

local servers = {
    "lua_ls",

    "pyright",
    "ruff_lsp",

    "gopls",
    "templ",

    "rust_analyzer",

    "tsserver",
    "volar",
    "svelte",

    "html",
    "cssls",
    "tailwindcss",

    "htmx",

    "marksman",
    "yamlls",
}

-- NOTE: It's IMPORTANT to set up the plugins in the following order:
--   * mason
--   * mason-lspconfig
--   * lspconfig
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
        -- It is the slowers plugin to load (20ms).
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
            end,
            custom_settings = {
                -- TODO: Look custom settings instead of hardcoding each of them.
                lua_ls = function()
                    return require("plugins.lsp.servers.lua_ls")
                end,
                ruff_lsp = function()
                    return require("plugins.lsp.servers.ruff_lsp")
                end,
                pyright = function()
                    return require("plugins.lsp.servers.pyright")
                end,
                volar = function()
                    return require("plugins.lsp.servers.volar")
                end,
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
                            luasnip  = "[Snip]",
                            path     = "[Path]",
                            buffer   = "[Buff]",
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
                        if luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            -- NOTE: `fallback` executes the original mapping.
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-b>"] = cmp.mapping(function(fallback)
                        -- Navigates to previous snippet placeholder.
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            -- NOTE: `fallback` executes the original mapping.
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
                        -- NOTE: This MUST be configured before lspconfig.
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
    {
        "stevearc/conform.nvim",
        cmd = { "ConformInfo" },
        opts = {
            formatters_by_ft = {
                vue = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
                markdown = { "prettier" },
            },
        },
        keys = {
            {
                "<leader>ft",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                desc = "conform: Format"
            },
        },
    },
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        ft = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
        },
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 15,
            })
        end
    },
}
