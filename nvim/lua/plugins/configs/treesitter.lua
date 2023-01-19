local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

local ensure_installed = {"bash", "html", "javascript", "json", "lua", "php", "scss", "typescript", "vim", "vue"}

treesitter.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false
    },
    rainbow = {
        enable = true,
        disable = {"html"},
        extended_mode = true,
        max_file_lines = nil
    },
    autotag = {
        enable = true
    },
    incremental_selection = {
        enable = true
    },
    indent = {
        enable = false
    }
}

