-- autocmds
local autocmd = vim.api.nvim_create_autocmd

autocmd("VimEnter", {
  callback = function()
    vim.cmd "lua require('packer').compile()"
  end,
})