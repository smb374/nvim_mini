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
    dependencies = {
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        config = true,
        dependencies = { "nvim-lspconfig" },
      },
      { "folke/neodev.nvim", opts = {} },
      { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "lukas-reineke/lsp-format.nvim",
      -- "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      external_servers = {},
      ensure_installed = {},
      server_config = {},
    },
    config = function(_, opts)
      local lsp_attach = function(client, buffer)
        local map = function(m, lhs, rhs, desc)
          local key_opts = { buffer = buffer, desc = desc, nowait = true }
          vim.keymap.set(m, lhs, rhs, key_opts)
        end
        map("n", "K", "<cmd>lua vim.lsp.buf.hover({border = vim.g.lsp_zero_border_style})<cr>", "Hover documentation")
        map(
          "n",
          "gs",
          "<cmd>lua vim.lsp.buf.signature_help({border = vim.g.lsp_zero_border_style})<cr>",
          "Show function signature"
        )
        map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition")
        map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration")
        map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation")
        map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Go to type definition")
        map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", "Go to reference")
        map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename symbol")
        map("n", "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format file")
        map("x", "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format selection")
        map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", "Execute code action")
        if client.supports_method("textDocument/formatting") then
          require("lsp-format").on_attach(client)
        end
        require("nvim-navic").attach(client, buffer)
      end

      local capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
          completion = {
            completionItem = {
              snippetSupport = true,
              commitCharactersSupport = true,
              deprecatedSupport = true,
              preselectSupport = true,
              tagSupport = { valueSet = { 1 } },
              insertReplaceSupport = true,
              resolveSupport = {
                properties = {
                  "documentation",
                  "detail",
                  "additionalTextEdits",
                },
              },
              labelDetailsSupport = true,
            },
          },
        },
      }
      vim.lsp.config("*", {
        capabilities = capabilities,
        root_markers = { ".git" },
      })
      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed,
        automatic_enable = true,
        automatic_installation = false,
      })
      for _, server in ipairs(opts.external_servers) do
        if opts.server_config[server] ~= nil then
          opts.server_config[server].mason = false
        else
          vim.lsp.config(server, {
            mason = false,
            capabilities = require("blink.cmp").get_lsp_capabilities(capabilities),
          })
          vim.lsp.enable(server)
        end
      end
      for server, opt in pairs(opts.server_config) do
        opt.on_attach = lsp_attach
        if opt.capabilities ~= nil then
          local server_cap = vim.tbl_deep_extend("force", capabilities, opt.capabilities)
          opt.capabilities = require("blink.cmp").get_lsp_capabilities(server_cap)
        else
          opt.capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
        end
        vim.lsp.config(server, opt)
        vim.lsp.enable(server)
      end
    end,
  },
}
