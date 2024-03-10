local clue = require("mini.clue")
clue.setup({
  triggers = {
    -- Leader triggers
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },

    -- Built-in completion
    { mode = "i", keys = "<C-x>" },

    -- `g` key
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },

    -- Marks
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },

    -- Registers
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },

    -- `s` key
    { mode = "n", keys = "s" },
    { mode = "x", keys = "s" },

    -- Window commands
    { mode = "n", keys = "<C-w>" },

    -- `z` key
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    clue.gen_clues.builtin_completion(),
    clue.gen_clues.g(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers(),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),
    -- Custom Clues
    { mode = "n", keys = "<Leader>b", desc = "+Buffers..." },
    { mode = "n", keys = "<Leader>f", desc = "+File..." },
    { mode = "n", keys = "<Leader>w", desc = "+Windows..." },
    { mode = "n", keys = "<Leader><Tab>", desc = "+Tabs..." },
    -- Pick
    { mode = "n", keys = "<Leader>s", desc = "+Pick..." },
    { mode = "n", keys = "<Leader>sg", desc = "+Pick Git..." },
    { mode = "n", keys = "<Leader>sl", desc = "+Pick Lsp..." },
    { mode = "n", keys = "<Leader>sL", desc = "+Pick List..." },
  },
  window = {
    delay = 50,
    config = {
      width = "auto",
      border = "single",
    },
  },
})
