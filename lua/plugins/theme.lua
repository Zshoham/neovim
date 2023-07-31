return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "moon",
      on_colors = function(colors)
        local gitColors = {
          add = colors.green,
          change = colors.yellow,
          delete = colors.red,
        }
        colors.gitSigns = gitColors
        colors.git = gitColors
        colors.border = colors.blue
      end,
      on_highlights = function(highlights, colors)
        highlights.TreesitterContextLineNumber = {
          fg = colors.green,
        }
      end,
    },
  },
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
      opts.custom_highlights = function(colors)
        return {
          TreesitterContextLineNumber = { fg = colors.green },
          TreesitterContext = { bg = colors.surface0 },
          NavicText = { fg = colors.text },
        }
      end
      opts.integrations.leap = true
      opts.integrations.rainbow_delimiters = true
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
