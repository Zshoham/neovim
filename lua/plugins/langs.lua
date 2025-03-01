return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "basic",
              },
            },
          },
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "vim",
        "yaml",
        "xml",
        "c",
        "cuda",
        "cmake",
        "bitbake",
        "cpp",
        "diff",
        "devicetree",
        "gitcommit",
        "git_rebase",
        "fish",
        "just",
        "make",
        "kconfig",
        "sql",
        "typst",
      },
    },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "hadolint",
        "markdownlint-cli2",
        "markdown-toc",
        "cmakelint",
        "cmakelang",
        "sqlfluff",
        "basedpyright",
        "ruff",
        "marksman",
        "clangd",
        "neocmakelsp",
        "taplo",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "yaml-language-server",
        "lua-language-server",
        "json-lsp",
        "tinymist",
      },
    },
  },
}
