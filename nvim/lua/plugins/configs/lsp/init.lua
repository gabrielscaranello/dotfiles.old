local M = {}

M.config = function()

  local status, _ = pcall(require, "lspconfig")
  if not status then
    return
  end

  require("plugins.configs.lsp.lsp-installer")
  require("plugins.configs.lsp.handlers").setup()
end

return M
