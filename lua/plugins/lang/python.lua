return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "pyright", "ruff" })
    end,
  },
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.python = {
        "isort",
        "ruff_format",
      }
    end,
  },
  {
    "nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.python = {
        "ruff",
      }
    end,
  },
}
