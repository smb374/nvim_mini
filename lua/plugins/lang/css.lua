return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css",
        "scss",
      })
    end,
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "cssls" })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }
      opts.server_config["cssls"] = {
        capabilities = capabilities,
      }
    end,
  },
}
