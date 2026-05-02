return {
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "dlyongemallo/diffview.nvim", -- Maintained fork of "sindrets/diffview.nvim".
    },
    build = function()
      require("gitlab.server").build(true) -- Builds the Go binary
    end,
    config = function()
      require("gitlab").setup()
    end,
  },
}
