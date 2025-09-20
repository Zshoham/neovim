local function update_lazy()
  require("lazy").update({ wait = true, show = false })
end

local function update_treesitter()
  -- wait a maximum of 10 minutes for all the parsers to update.
  require("nvim-treesitter").install(require("external").treesitter):wait(600000)
  require("nvim-treesitter").update(require("external").treesitter):wait(600000)
  print("Done updating treesitter.")
end

local function update_lsp()
  local to_update = require("mason-lspconfig.settings").current.ensure_installed
  require("mason-registry").update()
  require("mason-lspconfig.api.command").LspInstall(to_update)
  print("Done updating lsps.")
end

local function update_mason()
  require("mason-registry").update()
  local mason_cmd = require("mason.api.command")
  -- for some reason mason fails to install on the first try, so 
  -- we just try again...
  local ok, _ = pcall(mason_cmd.MasonInstall, require("external").mason)
  if not ok then
    mason_cmd.MasonInstall(require("external").mason)
  end
  print("Done updating mason tools.")
end

local function update_blink()
  local download_done = false
  local download_result = {}

  require("blink.cmp.fuzzy.download").ensure_downloaded(function(err, implementation)
    download_result.err = err
    download_result.implementation = implementation
    download_done = true
  end)

  vim.wait(60000, function()
    return download_done
  end)

  if download_result.err then
    print("Blink download failed:", download_result.err)
    -- just try again until its successfull.
    update_blink()
  else
    print("Blink download succeeded. Implementation:", download_result.implementation)
  end

  print("Done updating blink fuzzy finder.")
end

local function update_all()
  update_lazy()
  update_mason()
  update_lsp()
  update_treesitter()
  update_blink()
end

return {
  update_lazy = update_lazy,
  update_treesitter = update_treesitter,
  update_mason = update_mason,
  update_lsp = update_lsp,
  update_all = update_all,
  update_blink = update_blink,
}
