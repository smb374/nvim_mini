return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "dart",
      })
    end
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.external_servers, { "dartls" })
    end
  },
  {
    "dart-lang/dart-vim-plugin",
    ft = "dart",
  }
}
