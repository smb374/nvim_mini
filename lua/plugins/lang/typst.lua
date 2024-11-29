return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "typst" })
    end,
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      -- vim.list_extend(opts.ensure_installed, { "typst_lsp" })
      vim.list_extend(opts.external_servers, { "tinymist" })
    end,
  },
  {
    "kaarmu/typst.vim",
    ft = { "typ", "typst" },
  },
  {
    "MrPicklePinosaur/typst-conceal.vim",
    ft = { "typ", "typst" },
  },
}
