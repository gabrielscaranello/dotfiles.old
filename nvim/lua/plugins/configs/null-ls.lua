local M = {}

M.config = function()
    local status, null_ls = pcall(require, "null-ls")
    if not status then return end

    local formatting = null_ls.builtins.formatting
    local actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics

    local sources = {

        -- diagnostics ----------------------------------------------------
        diagnostics.eslint_d.with({extra_filetypes = {"vue"}}), diagnostics.php,

        -- formatting -----------------------------------------------------
        formatting.prettier.with({prefer_local = "node_modules/.bin"}),
        formatting.lua_format, formatting.phpcsfixer, formatting.yapf,

        -- actions ---------------------------------------------------------
        actions.gitsigns
    }

    null_ls.setup {
        debug = false,
        sources = sources,
        debounce = 150,
        update_in_insert = false,

        on_attach = function(client)
            if client.resolved_capabilities.document_formatting then
                vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 5000)"
            end
        end
    }
end

return M
