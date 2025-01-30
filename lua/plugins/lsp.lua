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
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        config = true,
        dependencies = { "nvim-lspconfig" },
      },
      { "folke/neodev.nvim", opts = {} },
      { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
      { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "lukas-reineke/lsp-format.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      external_servers = {},
      ensure_installed = {},
      server_config = {},
    },
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")

      local lspconfig_defaults = require("lspconfig").util.default_config
      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig_defaults.capabilities,
        -- require("cmp_nvim_lsp").default_capabilities()
        require("cmp_nvim_lsp").default_capabilities({
          resolveSupport = {
            properties = {
              "documentation",
              "detail",
              "additionalTextEdits",
              "sortText",
              "filterText",
              "insertText",
              "insertTextFormat",
              "insertTextMode",
            },
          },
        })
      )

      local lsp_attach = function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })
        if client.supports_method("textDocument/formatting") then
          require("lsp-format").on_attach(client)
        end
        require("nvim-navic").attach(client, bufnr)
      end
      lsp_zero.extend_lspconfig({
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
        sign_text = true,
        lsp_attach = lsp_attach,
      })

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
        opt.on_attach = lsp_attach
        lspconfig[server].setup(opt)
      end
    end,
  },
}
