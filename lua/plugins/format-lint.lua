return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {},
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {},
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
}
