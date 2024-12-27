M = {
    lua_ls = require("plugins.lsp.servers.lua_ls"),
    pyright = require("plugins.lsp.servers.pyright"),
    ruff_lsp = require("plugins.lsp.servers.ruff_lsp"),
    tsserver = require("plugins.lsp.servers.tsserver"),
    volar = require("plugins.lsp.servers.volar"),
}

return M
