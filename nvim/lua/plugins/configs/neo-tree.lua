local status_ok, neo_tree = pcall(require, "neo-tree")
if not status_ok then
    return
end

neo_tree.setup({
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false,
    window = {
        width = 32
    }
})

