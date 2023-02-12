local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

local lsp_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "<leader>R", ":LspRestart<CR>")
    vim.keymap.set("n", "<leader>wA", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wR", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wL", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
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

    vim.cmd [[
        augroup lsp_buf_format
            au! BufWritePre <buffer>
            autocmd BufWritePre <buffer> :lua vim.lsp.buf.format({ async = true })
        augroup END
    ]]
end

local servers = {
    "sumneko_lua",
    "tsserver",
    "pylsp",
    "gopls",
    "zk",
}

require('mason').setup()
require('mason-lspconfig').setup({ ensure_installed = servers })

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

require('mason-lspconfig').setup_handlers({
    function(server)
        local config = {
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
        }

        if server == "sumneko_lua" then
            config.settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        end

        lspconfig[server].setup(config)
    end
})
