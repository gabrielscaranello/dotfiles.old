local sources = { 
  'bufferline',
  'filetype', 
  'fix-cursor-hold', 
  'icons', 
  'lualine', 
  'nvim-tree',
}

local M = {}

for _, source in ipairs(sources) do 
  M[source] = require("plugins.configs." .. source).config
end

return M

