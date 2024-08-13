-- vim.filetype.add({
--     extension = {
--         templ = "templ",
--     },
-- })

-- vim.diagnostic.config({
--     signs = {
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
    "ruff_lsp",
    "gopls",
    "html",
    "htmx",
    "cssls",
    "tailwindcss",
    "marksman",
    -- "templ",
}

local lsp_keymaps = {
    { "<leader>R", function()
        vim.cmd("LspRestart")
        vim.cmd("echomsg 'LSP reloaded'")
    end, "Restart language server" },
    { "K",          vim.lsp.buf.hover,           "Display hover information" },
    { "<C-s>",      vim.lsp.buf.signature_help,  "Display signature information" },
    { "gD",         vim.lsp.buf.declaration,     "Jump to the declaration" },
    { "gd",         vim.lsp.buf.definition,      "Jump to the definition" },
    { "gi",         vim.lsp.buf.implementation,  "List all implementations" },
    { "gr",         vim.lsp.buf.references,      "List all references" },
    { "<leader>D",  vim.lsp.buf.type_definition, "Jump to definition" },
    { "<leader>rn", vim.lsp.buf.rename,          "Rename all references" },
    { "<leader>ca", vim.lsp.buf.code_action,     "Select available code action" },
    -- { "<leader>wA", vim.lsp.buf.add_workspace_folder,    "Add to workspace folders" },
    -- { "<leader>wR", vim.lsp.buf.remove_workspace_folder, "Remove from workspace folders" },
    -- { "<leader>wL", vim.lsp.buf.list_workspace_folders,  "List workspace folders" },
}

return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        keys = {
            { "<leader>cm", "<Cmd>Mason<CR>", desc = "Mason" }
        },
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
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "saadparwaiz1/cmp_luasnip" },
        },
        config = function()
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
        end
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        -- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        dependencies = {
            { "williamboman/mason.nvim",           optional = true },
            { "williamboman/mason-lspconfig.nvim", optional = true },
            { "hrsh7th/nvim-cmp" },
            { "folke/neodev.nvim" }, -- TODO: replace this with folke/lazydev.nvim (neovim >= 0.10)
        },
        keys = {
            {
                "<leader>tp",
                function()
                    local ft = vim.fn.input("Filetype: ")

                    if ft == "" then
                        vim.cmd("echohl WarningMsg | echomsg 'No filetype provided!' | echohl None")
                        return;
                    end

                    vim.bo.filetype = ft
                end,
                desc = "Set filetype"
            },
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
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
    }
}
