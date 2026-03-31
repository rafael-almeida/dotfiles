return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- This plugin does not support lazy-loading
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        disable = { "tmux" }, -- tmux: treesitter highlighting is unreliable, fall back to vim regex
      },
      indent = {
        enable = true
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 2,
    },
  },
}
