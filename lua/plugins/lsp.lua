return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {},
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "VonHeikemen/lsp-zero.nvim" },
    opts = function()
      local lsp_zero = require("lsp-zero")
      return {
        ensure_installed = {},
        handlers = {
          lsp_zero.default_setup,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    opts = {
      external_servers = {},
    },
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(_, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
        lsp_zero.buffer_autoformat()
      end)
      local lspconfig = require("lspconfig")
      for _, server in ipairs(opts.external_servers) do
        lspconfig[server].setup({
          mason = false,
        })
      end
    end,
  },
}
