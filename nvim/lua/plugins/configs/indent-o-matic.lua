local status_ok, indent_o_matic = pcall(require, "indent-o-matic")
if not status_ok then
    return
end

indent_o_matic.setup()
indent_o_matic.detect()
