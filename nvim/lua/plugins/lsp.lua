return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        },
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                typeCheckingMode = "standard",
              },
            },
          },
        },
        ruff = {
          init_options = {
            settings = {},
          },
        },
      }

      vim.lsp.config('*', {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      for server, config in pairs(servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end

      -- Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf

          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client.name == "ruff" then
            -- basedpyright handles hover
            client.server_capabilities.hoverProvider = false
          end

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buf })
          vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = buf })
          vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { buffer = buf })
          vim.keymap.set("n", "grr", vim.lsp.buf.references, { buffer = buf })
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = buf })
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = buf })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = buf })
        end,
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>ft",
        function()
          require("conform").format()
        end,
        desc = "Format file",
      },
    },
    opts = {
      async = true,
      lsp_format = "fallback", -- Use LSP formatting for missing formatters.

      -- NOTE(03-31-2026): These formatters must be installed globally or in the workspace.
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
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
}
