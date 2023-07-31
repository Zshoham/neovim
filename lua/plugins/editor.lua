return {
  { "fedepujol/move.nvim" },
  { -- Nerd Fonts v3 fix (unstaged icon would render wrong)
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.default_component_configs.icon = {
        icon = {
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
        },
      }
      opts.default_component_configs.git_status = {
        symbols = {
          renamed = "󰁕",
          unstaged = "󰄱",
        },
      }
    end,
  },
}
