local minideps = require("mini.deps")
local add, now = minideps.add, minideps.now

now(function()
  add("nvim-tree/nvim-web-devicons")
  require("nvim-web-devicons").setup()
end)
now(function()
  add("lewis6991/gitsigns.nvim")
  require("gitsigns").setup({
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
  })
end)

require("plugins.bufferline")
require("plugins.catppuccin")
require("plugins.cmp")
require("plugins.lsp")
require("plugins.lualine")
require("plugins.treesitter")
require("plugins.trouble")
-- Languages
require("plugins.lang.typst")
