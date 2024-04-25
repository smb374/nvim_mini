return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "markdown",
        "markdown_inline",
      })
    end
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "markdownlint" })
    end,
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "marksman" })
    end,
  },
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft.markdown = {
        "markdownlint",
      };
    end
  },
  {
    "nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.markdown = {
        "markdownlint",
      }
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
