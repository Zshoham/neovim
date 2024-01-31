return {
  { "fedepujol/move.nvim" },
  { "HiPhish/rainbow-delimiters.nvim" },
  { "nvim-treesitter/nvim-treesitter-context", opts = { separator = "─", max_lines = 2 } },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  {
    "rmagatti/goto-preview",
    lazy = false,
    opts = {
      default_mappings = true,
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
      provider_selector = function(_, _, _)
        return { "treesitter", "indent" }
      end,
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
}
