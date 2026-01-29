require("config")
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

-- Define the full statusline format
-- %f - Filename
-- %m - Modified status ([+])
-- %r - Readonly status (RO)
-- %= - Separator (pushes items to the right)
-- %l/%L - Current line/Total lines
-- %c - Current column
-- vim.opt.statusline = [[%f%m%r%=%l/%L %c]]
--
vim.opt.statusline = "%<%f%{&modified?' [+]':''}%r%=%-14.(%l,%c%V%)%P [%{winnr()}]"

vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,
    virtual_lines = true,
})

vim.keymap.set("n", "<leader>ds", function()
    vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
    })
end)

if vim.fn.filereadable("Session.vim") == 1 then
    vim.cmd("source Session.vim")
end

-- This shouldnt be needed, this is just a workaround for the nvm bug where filetype detect does not trigger for the first bugger opened
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWinEnter" }, {
    callback = function()
        -- Only run if filetype is empty (i.e., failed to detect)
        if vim.bo.filetype == "" then
            vim.cmd("filetype detect")
        end
    end,
})

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
---
---- Set nvim inactivity timeout in milliseconds (e.g., 30 minutes = 1800000 ms) (frees resources when we leave nvim open on multiple tmux panes and sessions)
local second = 1000
local minute = 60 * second
local hour = 60 * minute

local idle_timeout = 5 * hour
local timeout_timer = vim.loop.new_timer()

local function reset_timer()
    timeout_timer:stop()
    timeout_timer:start(idle_timeout, 0, vim.schedule_wrap(function()
        -- Check if there are unsaved changes before quitting
        if not vim.bo.modified then
            vim.cmd('qall')
        else
            -- Optional: Save and quit, or just notify
            -- vim.cmd('wqall')
        end
    end))
end

-- Reset the timer on any key press or mouse click
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertCharPre", "TextChanged" }, {
    callback = reset_timer,
})

-- Start the timer on launch
reset_timer()
