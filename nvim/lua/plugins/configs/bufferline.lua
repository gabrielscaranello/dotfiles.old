local close_func = function(bufnum)
    local bufdelete_avail, bufdelete = pcall(require, "bufdelete")
    if bufdelete_avail then
        bufdelete.bufdelete(bufnum, true)
    else
        vim.cmd.bdelete {
            args = {bufnum},
            bang = true
        }
    end
end

local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

bufferline.setup {
    options = {
        offsets = {{
            filetype = "neo-tree",
            text = "File Explorer",
            padding = 0,
            separator = true,
            text_align = "left"
        }},
        modified_icon = "",
        buffer_close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        show_close_icon = true,
        close_command = close_func,
        right_mouse_command = close_func,
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 16,
        separator_style = "thick"
    }
}

