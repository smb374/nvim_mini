return {
  {
    "nvim-treesitter",
    opts = function (_, opts)
      vim.list_extend(opts.ensure_installed, { "c", "cpp" })
    end
  },
  {
    "mason-lspconfig.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "clangd" })
    end,
  },
}
