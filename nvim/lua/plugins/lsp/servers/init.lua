M = {
    lua_ls = require("plugins.lsp.servers.lua_ls"),
    pyright = require("plugins.lsp.servers.pyright"),
    ruff = require("plugins.lsp.servers.ruff"),
    ts_ls = require("plugins.lsp.servers.ts_ls"),
    volar = require("plugins.lsp.servers.volar"),
    sourcekit = {
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
    }
}

return M
