return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "typst" })
    end
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
