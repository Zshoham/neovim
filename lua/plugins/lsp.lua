return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "stylua",
          "shellcheck",
          "shfmt",
          "black",
          "ruff",
        })
      end
    end,
  },
  { "williamboman/mason-lspconfig.nvim", opts = { automatic_installation = true } },
  {
    "nvimtools/none-ls.nvim",
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
