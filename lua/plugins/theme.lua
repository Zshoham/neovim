return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = function(_, opts)
      local Colors = require("catppuccin.palettes").get_palette()
      opts.styles = {
        comments = { "italic" },
        keywords = { "italic" },
      }
      opts.integrations.navic = { enabled = true, custom_bg = Colors.mantle }
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
