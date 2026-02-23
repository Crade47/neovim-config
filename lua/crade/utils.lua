local UtilsModule = {}

function UtilsModule.Get_visual_selection()
    vim.cmd('normal! "zy')
    local text = vim.fn.getreg('z')
    -- Clean up the text (remove newlines, etc.)
    text = string.gsub(text, "\n", " ")
    text = string.gsub(text, "^%s*(.-)%s*$", "%1") -- trim
    return text
end

return UtilsModule

