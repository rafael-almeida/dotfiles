local servers = {
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            "vim"
          }
        }
      }
    }
  },

  basedpyright = {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    settings = {
      basedpyright = {
        analysis = {
          diagnosticMode = "openFilesOnly",
          inlayHints = {
            callArgumentNames = true
          }
        }
      }
    }
  },
}

vim.lsp.config('*', {
  root_markers = { '.git' },
})

for server, config in pairs(servers) do
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
