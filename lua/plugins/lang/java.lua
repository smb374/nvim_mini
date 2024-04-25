return {
  {
    "nvim-lspconfig",
    opts = {
      server_config = {
        jdtls = {
          handlers = {
            ["$/progress"] = function()
            end
          }
        },
      },
    },
  },
}
