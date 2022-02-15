local M = {}

M.config = function()
  require("luasnip.loaders.from_vscode").load()
end

return M
