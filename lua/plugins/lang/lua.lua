return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "lua" })
    end
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "lua_ls" })
    end,
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "stylua" })
    end,
  },
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.lua = {
        "stylua"
      };
    end
  },
}
