return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elixir",
        "heex",
        "eex",
      })
    end
  },
  {
    "mason-lspconfig.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "elixirls" })
    end,
  }
}
