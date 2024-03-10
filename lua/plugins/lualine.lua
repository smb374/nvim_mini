local minideps = require("mini.deps")
local add, later = minideps.add, minideps.later

later(function()
  add({
    source = "nvim-lualine/lualine.nvim",
    depends = { "nvim-tree/nvim-web-devicons" },
  })
  require("lualine").setup({})
end)
