local minideps = require("mini.deps")
local add, now, later = minideps.add, minideps.now, minideps.later

-- Use external plugins with `add()`
now(function()
  -- Add to current session (install if absent)
  add("nvim-tree/nvim-web-devicons")
  require("nvim-web-devicons").setup()
end)

require("plugins.treesitter")
