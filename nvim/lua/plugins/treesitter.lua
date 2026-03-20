return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "query",
          "bash", "json", "jsonc", "yaml", "toml",
          "markdown", "markdown_inline",
          "python", "javascript", "typescript", "tsx",
          "html", "css", "go", "rust",
        },
        auto_install = true,
        -- tmux: treesitter highlighting is inaccurate, fall back to vim regex
        highlight = { enable = true, disable = { "tmux" } },
        indent = { enable = true },
      })
    end,
  },
}
