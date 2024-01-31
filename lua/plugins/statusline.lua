return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = require("lazyvim.config").icons
      local UI = require("lazyvim.util").ui

      opts.options.section_separators = " "
      opts.options.component_separators = " "

      local disabled_filetypes_winbar = { "dashboard", "alpha", "lazy", "neo-tree", "trouble" }

      opts.options.disabled_filetypes = {
        statusline = { "dashboard", "alpha" },
        winbar = disabled_filetypes_winbar,
        inactive_winbar = disabled_filetypes_winbar,
      }

      local winbar_config = {
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 1 } },
          { "filename", path = 1, separator = "|>", symbols = { modified = icons.git.modified, readonly = "", unnamed = "" } },
        },
      }

      opts.winbar = winbar_config
      opts.inactive_winbar = winbar_config

      opts.sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 1 } },
          {
            "filename",
            path = 0,
            separator = "|>",
            padding = { right = 1 },
            symbols = { modified = icons.git.modified, readonly = "", unnamed = "" },
          },
          {
            function()
              return require("nvim-navic").get_location()
            end,
            cond = function()
              return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
            end,
          },
        },
        lualine_x = {
          { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = UI.fg("Special") },
          { "diagnostics" },
          {
            function()
              ---@diagnostic disable-next-line: undefined-field
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              ---@diagnostic disable-next-line: undefined-field
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = UI.fg("Constant"),
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_y = {
          { "location", padding = { left = 1, right = 0 } },
        },
        lualine_z = {
          { "hostname" },
        },
      }
    end,
  },
}
