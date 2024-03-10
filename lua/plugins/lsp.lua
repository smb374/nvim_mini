local minideps = require("mini.deps")
local add, later = minideps.add, minideps.later

later(function()
  add("williamboman/mason.nvim")
  add("williamboman/mason-lspconfig.nvim")
  add("VonHeikemen/lsp-zero.nvim")
  add("folke/neodev.nvim")
  add("folke/neoconf.nvim")
  add({
    source = "neovim/nvim-lspconfig",
    depends = {
      "folke/neodev.nvim",
      "folke/neoconf.nvim",
      "VonHeikemen/lsp-zero.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  })

  local lspconfig = require("lspconfig")
  local lsp_zero = require("lsp-zero")
  local external_servers = require("config.external_servers")

  lsp_zero.on_attach(function(_, bufnr)
    lsp_zero.default_keymaps({ buffer = bufnr })
    lsp_zero.buffer_autoformat()
  end)
  require("neoconf").setup()
  require("neodev").setup()
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })
  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" },
    handlers = {
      lsp_zero.default_setup,
    },
  })
  for _, server in ipairs(external_servers) do
    lspconfig[server].setup({
      mason = false,
    })
  end
end)
