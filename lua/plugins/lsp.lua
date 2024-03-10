return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "VonHeikemen/lsp-zero.nvim",
    },
    opts = function()
      local lsp_zero = require("lsp-zero")
      return {
        ensure_installed = { "lua_ls" },
        handlers = {
          lsp_zero.default_setup,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },
      "VonHeikemen/lsp-zero.nvim",
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function(_, _)
      local lspconfig = require("lspconfig")
      local lsp_zero = require("lsp-zero")
      local external_servers = require("config.external_servers")

      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
        lsp_zero.buffer_autoformat()
      end)
      for _, server in ipairs(external_servers) do
        lspconfig[server].setup({
          mason = false,
        })
      end
    end
  },
}
