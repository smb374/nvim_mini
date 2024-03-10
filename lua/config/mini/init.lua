require("config.mini.bufremove")

require("mini.extra").setup()
require("mini.notify").setup()
require("mini.operators").setup()

vim.notify = require("mini.notify").make_notify()

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
