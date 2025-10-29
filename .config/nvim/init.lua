require 'config'
local vim = vim

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smartindent = true
-- This is slow, differ it to run async
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)
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

-- reproduce netrw issue https://github.com/neovim/neovim/issues/35747
-- vim.g.netrw_banner = 0
-- vim.g.netrw_liststyle = 3 -- this is the culprit option for the bug
-- vim.g.netrw_altv = 1
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_altfile = 1
--
-- 1. Mark a subdirectory:
-- Navigate to a subdirectory using your arrow keys.
-- Press mf to mark it. The marked directory will be highlighted.
-- 2. Execute a command:
-- Press mx to bring up the command prompt.
-- Type echo % and press Enter.
-- The output will be incorrect, showing path/to/my_dir/my_dir.
--
-- Investigation notes:
-- the issue is specifically with liststyle 3 (tree view).
-- And specifically when marking a sub-directory but NOT a sub-file (under the top level directories). No other liststyle has the option to mark sub-directories, so the issue doesn't arise there.
