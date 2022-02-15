local sources = { 'filetype', 'fix-cursor-hold', 'icons', 'lualine' }

local M = {}

for _, source in ipairs(sources) do 
  M[source] = require("plugins.configs." .. source).config
end

return M

