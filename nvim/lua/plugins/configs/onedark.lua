local status_ok, onedark = pcall(require, "onedark")
if not status_ok then return end

onedark.setup {
    style = 'darker'
}

onedark.load()
