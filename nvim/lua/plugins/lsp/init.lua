-- vim.filetype.add({
--     extension = {
--         templ = "templ",
--     },
-- })

local util = require("config.util")

local servers = {
    "lua_ls",
    "pyright",
    "gopls",
    "html",
}

local server_settings = require("plugins.lsp.servers")

local setup_lsp = function()
    local lsp = require("lspconfig")

    local on_attach = function(_, bufnr)
        util.nnoremap(bufnr, "<leader>R", "<Cmd>LspRestart<CR>", "Restart language server")
        util.nnoremap(bufnr, "<leader>wA", vim.lsp.buf.add_workspace_folder, "Add to workspace folders")
        util.nnoremap(bufnr, "<leader>wR", vim.lsp.buf.remove_workspace_folder, "Remove from workspace folders")
        util.nnoremap(bufnr, "K", vim.lsp.buf.hover, "Display hover information")
        util.nnoremap(bufnr, "<C-s>", vim.lsp.buf.signature_help, "Display signature information")
        util.nnoremap(bufnr, "gD", vim.lsp.buf.declaration, "Jump to the declaration")
        util.nnoremap(bufnr, "gd", vim.lsp.buf.definition, "Jump to the definition")
        util.nnoremap(bufnr, "gi", vim.lsp.buf.implementation, "List all implementations")
        util.nnoremap(bufnr, "gr", vim.lsp.buf.references, "List all references")
        util.nnoremap(bufnr, "<leader>D", vim.lsp.buf.type_definition, "Jump to definition")
        util.nnoremap(bufnr, "<leader>rn", vim.lsp.buf.rename, "Rename all references")
        util.nnoremap(bufnr, "<leader>ca", vim.lsp.buf.code_action, "Select available code action")
    end

    for _, server in ipairs(servers) do
        local c = {
            on_attach = on_attach,
        }

        if server_settings[server] ~= nil then
            c = util.tbl_extend(c, server_settings[server])
        end

        lsp[server].setup(c)
    end
end

util.noremap("n", "<leader>tp", function()
    local ft = vim.fn.input("Filetype: ")

    if ft == "" then
        print("No filetype provided!")
        return;
    end

    vim.bo.filetype = ft
    setup_lsp()
end)

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
        "neovim/nvim-lspconfig",
        lazy = false,
        keys = {
            { "<leader>e", vim.diagnostic.open_float, desc = "nvim-lspconfig: Show diagnostics" },
            { "[d",        vim.diagnostic.goto_prev,  desc = "nvim-lspconfig: Move to previous diagnostic" },
            { "]d",        vim.diagnostic.goto_next,  desc = "nvim-lspconfig: Move to next diagnostic" },
            { "<leader>q", vim.diagnostic.setloclist, desc = "nvim-lspconfig: Add diagnostics to location list" },
        },
        config = setup_lsp
    },
}
