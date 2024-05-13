-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local vim = vim
local opt = vim.opt

vim.g.autoformat = false
opt.foldcolumn = "1"
opt.foldlevel = 90
opt.foldlevelstart = 90
opt.foldenable = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

opt.pumblend = 0 -- Enables pseudo-transparency for the popup-menu

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"
