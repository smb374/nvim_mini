return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "c", "cpp", "meson" })
    end,
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "mesonlsp" })
      vim.list_extend(opts.external_servers, { "clangd" })
      opts.server_config.mesonlsp = {}
      opts.server_config.clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--function-arg-placeholders",
          "--all-scopes-completion",
          "--cross-file-rename",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--header-insertion-decorators",
        },
        init_options = {
          clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
          usePlaceholders = true,
          completeUnimported = true,
          semanticHighlighting = true,
        },
      }
    end,
  },
}
