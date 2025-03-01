return {
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  { "HiPhish/rainbow-delimiters.nvim" },
  { "nvim-treesitter/nvim-treesitter-context", opts = { separator = "─", max_lines = 2 } },
  {
    "rmagatti/goto-preview",
    lazy = false,
    opts = {
      default_mappings = true,
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      statuscolumn = { folds = { open = true } },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_next()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_prev()
            end
          end,
          "snippet_backward",
          "fallback",
        },
      },
    },
  },
}
