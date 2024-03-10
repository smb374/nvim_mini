local minideps = require("mini.deps")
local add, now, later = minideps.add, minideps.now, minideps.later

later(function()
  add({
    source = "hrsh7th/nvim-cmp",
    depends = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
  })
  add({
    source = "L3MON4D3/LuaSnip",
    depends = {
      "hrsh7th/nvim-cmp",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    hooks = {
      post_checkout = function()
        vim.fn.jobstart("make install_jsregexp")
      end,
    },
  })
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  -- Setup luasnip
  luasnip.setup({
    history = true,
    delete_check_events = "TextChanged",
  })
  -- Load friendly-snippets snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  -- Setup nvim-cmp
  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

  local defaults = require("cmp.config.default")()
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    completion = {
      completeopt = "menu,menuone,noselect,noinsert",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<Up>"] = cmp.config.disable,
      ["<Down>"] = cmp.config.disable,
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.in_snippet() and luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
    }, {
      { name = "buffer" },
      { name = "path" },
    }, {
      { name = "luasnip" },
    }),
    formatting = {
      format = function(_, item)
        local icons = require("lib.icons").kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        return item
      end,
    },
    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },
    sorting = defaults.sorting,
  })
end)
