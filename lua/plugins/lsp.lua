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
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/neoconf.nvim",
        config = true,
        dependencies = { "nvim-lspconfig" },
      },
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
        vim.lsp.set_log_level(vim.log.levels.WARN)
        vim.lsp.log.set_format_func(vim.inspect)
        local map = function(m, lhs, rhs, desc)
          local key_opts = { buffer = buffer, desc = desc, nowait = true }
          vim.keymap.set(m, lhs, rhs, key_opts)
        end
        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map("n", "gs", vim.lsp.buf.signature_help, "Show function signature")
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
        map("n", "gr", vim.lsp.buf.references, "Go to reference")
        map("n", "<F2>", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<F3>", function()
          vim.lsp.buf.format({ async = true })
        end, "Format file")
        map("x", "<F3>", function()
          vim.lsp.buf.format({ async = true })
        end, "Format selection")
        map("n", "<F4>", vim.lsp.buf.code_action, "Execute code action")
        map("n", "]e", function()
          vim.diagnostic.get_next({ severity = vim.diagnostic.severity.ERROR })
        end, "Goto next error")
        map("n", "[e", function()
          vim.diagnostic.get_prev({ severity = vim.diagnostic.severity.ERROR })
        end, "Goto next error")
        map("n", "]w", function()
          vim.diagnostic.get_next({ severity = vim.diagnostic.severity.WARN })
        end, "Goto next error")
        map("n", "[w", function()
          vim.diagnostic.get_prev({ severity = vim.diagnostic.severity.WARN })
        end, "Goto next error")
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
            on_attach = lsp_attach,
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
  {
    "MysticalDevil/inlay-hints.nvim",
    event = "LspAttach",
    dependencies = { "neovim/nvim-lspconfig" },
    config = true,
  },
  {
    "jedrzejboczar/exrc.nvim",
    dependencies = { "neovim/nvim-lspconfig" }, -- (optional)
    config = true,
    opts = { --[[ your config ]]
    },
  },
}
