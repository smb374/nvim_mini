return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ron",
        "rust",
        "toml",
      })
    end,
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "taplo" })
      vim.list_extend(opts.external_servers, { "rust_analyzer" })
    end,
  },
}
