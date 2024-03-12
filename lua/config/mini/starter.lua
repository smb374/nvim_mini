local augroup = require("lib").augroup

-- Disable indentscope on some buffers.
vim.api.nvim_create_autocmd("User", {
  group = augroup("disable_indentscope_starter"),
  pattern = "MiniStarterOpened",
  callback = function(_)
    vim.b.miniindentscope_disable = true
  end,
})
local starter = require("mini.starter")

local logo = table.concat({
  "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
  "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
  "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
  "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
  "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
}, "\n")

local pad = string.rep(" ", 22)
local function new_section(name, action, section)
  return { name = name, action = action, section = pad .. section }
end

local config = {
  evaluate_single = true,
  header = logo,
  items = {
    new_section("Find file", "Pick files", "Pick"),
    new_section("Recent files", "Pick oldfiles", "Pick"),
    new_section("Grep Text", "Pick grep_live", "Pick"),
    new_section("Projects", function()
      local history = require("project_nvim.utils.history")
      local pick = require("mini.pick")
      pick.start({ source = { items = history.get_recent_projects() } })
    end, "Pick"),
    new_section("Lazy", "Lazy", "Config"),
    new_section("Edit Config", function()
      local pick = require("mini.pick")
      pick.builtin.files({}, { source = { cwd = "~/.config/nvim" } })
    end, "Config"),
    new_section("New file", "ene | startinsert", "Built-in"),
    new_section("Quit", "qa", "Built-in"),
  },
  footer = "",
  content_hooks = {
    starter.gen_hook.adding_bullet(pad .. "░ ", false),
    starter.gen_hook.aligning("center", "center"),
  },
}

starter.setup(config)
