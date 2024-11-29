return {
  "j-hui/fidget.nvim",
  opts = {
    progress = {
      ignore = {
        -- "rust_analyzer",
        function(msg)
          return string.find(msg.title, "Invalid offset LineCol") ~= nil
        end,
        function(msg)
          return string.find(msg.title, "Loading proc-macros") ~= nil
        end,
        ---@param msg ProgressMessage
        function(msg)
          return string.find(msg.title, "does not support document") ~= nil
        end,
      },
    },
  },
  config = function(_, opts)
    require("fidget").setup(opts)
    vim.notify = require("fidget.notification").notify
  end,
}
