local minideps = require("mini.deps")
local add, later = minideps.add, minideps.later

later(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    -- Use 'master' while monitoring updates in 'main'
    checkout = "master",
    monitor = "main",
    -- Perform action after every checkout
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true, additional_vim_regex_highlighting = {} },
    indent = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<nop>",
        node_decremental = "<bs>",
      },
    },
    ensure_installed = {
      "bash",
      "bibtex",
      "c",
      "cpp",
      "css",
      "diff",
      "dockerfile",
      "elixir",
      "fish",
      "fennel",
      "git_rebase",
      "gitattributes",
      "gitcommit",
      "gitignore",
      "go",
      "haskell",
      "html",
      "ini",
      "javascript",
      "jq",
      "jsdoc",
      "json",
      "latex",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "meson",
      "ninja",
      "nix",
      "ocaml",
      "ocaml_interface",
      "proto",
      "python",
      "rasi",
      "regex",
      "rst",
      "rust",
      "scss",
      "sql",
      "ssh_config",
      "toml",
      "typescript",
      "vimdoc",
      "xml",
      "yaml",
      "yuck",
      "zig",
    },
  })
end)
