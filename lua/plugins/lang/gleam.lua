return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "gleam" })
    end
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.external_servers, { "gleam" })
    end
  }
}

