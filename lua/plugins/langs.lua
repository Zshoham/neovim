return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("external").treesitter
    end,
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("external").mason
    end,
  },
}
