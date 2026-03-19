return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = { "lua_ls", "basedpyright", "ruff", "bashls", "jsonls", "yamlls" },
        },
      },
      {
        "j-hui/fidget.nvim",
        opts = {},
      },
    },
    config = function()
      -- Attach keymaps when an LSP connects to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach_keymaps", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local builtin = require("telescope.builtin")

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gI", vim.lsp.buf.implementation, "Go to implementation")
          map("gr", builtin.lsp_references, "References")
          map("K", vim.lsp.buf.hover, "Hover docs")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev diagnostic")
          map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
          map("<leader>q", vim.diagnostic.setloclist, "Diagnostics list")
        end,
      })

      -- Global LSP config: capabilities for all servers
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Enable servers (mason-lspconfig ensures they're installed)
      vim.lsp.enable({ "lua_ls", "basedpyright", "ruff", "bashls", "jsonls", "yamlls" })

      -- Lua-specific settings
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { globals = { "vim" } },
          },
        },
      })
    end,
  },
}
