return {
  { "christoomey/vim-tmux-navigator", lazy = false },
  {
    "rmagatti/goto-preview",
    lazy = false,
    opts = {
      default_mappings = true,
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = { "neovim/nvim-lspconfig", "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
    lazy = false,
    keys = { { "<leader>cs", "<cmd>Navbuddy<cr>", desc = "Symbols Outline" } },
    opts = {
      window = { border = "rounded" },
      lsp = { auto_attach = true },
    },
  },
}
