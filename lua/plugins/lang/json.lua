return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "json",
        "json5",
        "jsonc",
      })
    end
  },
  {
    "mason-lspconfig.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "jsonls" })
    end,
  }
}
