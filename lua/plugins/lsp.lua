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
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },
      "VonHeikemen/lsp-zero.nvim",
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      external_servers = {},
      ensure_installed = {},
      server_config = {},
    },
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
        lsp_zero.buffer_autoformat(client, bufnr)
      end)

      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed,
        handlers = {
          lsp_zero.default_setup,
        },
      })
      local lspconfig = require("lspconfig")
      for _, server in ipairs(opts.external_servers) do
        if opts.server_config[server] ~= nil then
          opts.server_config[server].mason = false
        else
          lspconfig[server].setup({
            mason = false,
          })
        end
      end
      for server, opt in pairs(opts.server_config) do
        lspconfig[server].setup(opt)
      end
    end,
  },
}
