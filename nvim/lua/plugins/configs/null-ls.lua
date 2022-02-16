local M = {}

M.config = function()
    local status, null_ls = pcall(require, "null-ls")
    if not status then return end

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    local sources = {
        diagnostics.eslint.with({prefer_local = './node_modules/bin'}),
        formatting.prettier, formatting.lua_format
    }

    null_ls.setup {
        debug = false,
        sources = sources,

        on_attach = function(client)
            if client.resolved_capabilities.document_formatting then
                vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 5000)"
            end
        end
    }
end

return M
