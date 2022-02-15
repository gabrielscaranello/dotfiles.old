--- Speed load lua modules

local M = {}

M.config = function()
  require'impatient'.enable_profile()
end

return M

