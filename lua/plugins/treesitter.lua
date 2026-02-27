return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      enable_autocmd = false,
    },
    config = function(_, opts)
      require("ts_context_commentstring").setup(opts)
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
          vim.b.minicomment_config = {
            options = {
              custom_commentstring = function()
                return vim.bo.commentstring
                -- return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
              end,
            },
          }
        end,
        desc = "Update Commentstring",
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    branch = "master",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
      },
      ensure_installed = {
        "bash",
        "diff",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "ini",
        "json",
        "make",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "ssh_config",
        "vimdoc",
        "yaml",
      },
    },
    config = function(_, opts)
      local configs = require("nvim-treesitter.configs")
      configs.setup(opts)
    end,
  },
}
