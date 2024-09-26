return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "nix" })
    end
  },
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.external_servers, { "nil_ls" })
      opts.server_config["nil_ls"] = {
        settings = {
          ["nil"] = {
            formatting = {
              command = { "nixfmt" }
            }
          }
        }
      }
    end
  }
}
