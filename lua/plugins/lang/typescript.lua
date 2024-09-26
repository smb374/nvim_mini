return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typescript",
        "tsx",
        "javascript",
      })
    end
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "ts_ls" })
    end
  },
}
