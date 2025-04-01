local vim = vim

local green = "#c3e88d"
local yellow = "#ffcb6b"
local blue = "#82aaff"
local red = "#f07178"
local purple = "#c792ea"
local orange = "#f78c6c"
local cyan = "#89ddff"
local gray = "#717CB4"
local white = "#eeffff"
local error = "#ff5370"

vim.api.nvim_create_augroup('colorSchemeEvents', { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
    group = "colorSchemeEvents",   -- Specify the group name
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "CustomKeyword", { fg = purple })
    end,
})
