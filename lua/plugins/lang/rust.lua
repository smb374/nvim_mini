return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ron",
        "rust",
        "toml",
      })
    end
  },
  {
    "mason-lspconfig.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "taplo" })
    end,
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.external_servers, { "rust_analyzer" })
    end
  }
}
