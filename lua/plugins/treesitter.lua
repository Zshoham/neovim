return {
  { "HiPhish/rainbow-delimiters.nvim" },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "java",
        "rust",
        "python",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "fish",
        "gitignore",
        "gitcommit",
        "json",
        "make",
        "markdown",
        "sql",
        "regex",
        "kdl",
        "html",
        "javascript",
        "typescript",
        "toml",
        "yaml",
        "nix",
        "go",
        "git_rebase",
        "c_sharp",
        "cuda",
        "cmake",
        "zig",
        "julia",
      },
      rainbow = { enable = true, query = "rainbow-delimiters" },
    },
  },
  { "nvim-treesitter/nvim-treesitter-context", opts = { separator = "─", max_lines = 2 } },
}
