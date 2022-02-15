local sources = { 'filetype', 'fix-cursor-hold' }

local M = {}

for _, source in ipairs(sources) do 
  M[source] = require("plugins.configs." .. source).config
end

return M

