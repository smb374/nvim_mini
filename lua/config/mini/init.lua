local later = MiniDeps.later

require("config.mini.base16")
require("config.mini.bufremove")

require("mini.extra").setup()
require("mini.notify").setup()
require("mini.operators").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()

vim.notify = require("mini.notify").make_notify()
later(function()
  require("config.mini.clue")
  require("config.mini.files")
  require("config.mini.indentscope")
  require("config.mini.hipatterns")
  require("config.mini.pick")

  require("mini.ai").setup()
  require("mini.align").setup()
  require("mini.comment").setup()
  require("mini.pairs").setup()
  require("mini.surround").setup()
end)
