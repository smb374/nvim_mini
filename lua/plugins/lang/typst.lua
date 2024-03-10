local minideps = require("mini.deps")
local add, now = minideps.add, minideps.now

now(function ()
  add("kaarmu/typst.vim")
  add("MrPicklePinosaur/typst-conceal.vim")
end)
