return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt", lsp_format = "fallback", },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
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
