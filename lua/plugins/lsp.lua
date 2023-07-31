return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "rust-analyzer",
        "clangd",
        "pyright",
        "black",
        "ruff",
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.black,
        nls.builtins.diagnostics.ruff,
      })
    end,
  },
  { "neovim/nvim-lspconfig", opts = { autoformat = false } },
}
