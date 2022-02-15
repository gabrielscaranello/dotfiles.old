local sources = { 
  'bufferline',
  'filetype', 
  'fix-cursor-hold', 
  'icons', 
  'lualine', 
  'nvim-tree',
  'treesitter',
}

local M = {}

for _, source in ipairs(sources) do 
  M[source] = require("plugins.configs." .. source).config
end

return M

