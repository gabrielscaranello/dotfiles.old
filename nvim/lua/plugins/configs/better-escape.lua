local M = {}

M.config = function()

    local status, better_escape = pcall(require, "better_escape")
    if not status then return end

    better_escape.setup {
        mapping = {"ii", "jj", "jk", "kj"},
        timeout = vim.o.timeoutlen,
        keys = "<ESC>"
    }
end

return M
