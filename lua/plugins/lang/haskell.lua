return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "haskell" })
    end
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.external_servers, { "hls" })
    end
  },
  {
    "mrcjkb/haskell-tools.nvim",
    version = "^3", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  }
}
