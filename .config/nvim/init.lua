require 'config'
local vim = vim

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smartindent = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"

vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
    virtual_lines = true,
})

vim.keymap.set('n', '<leader>ds', function()
    vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
    })
end
)

if vim.fn.filereadable("Session.vim") == 1 then
    vim.cmd("source Session.vim")
end
