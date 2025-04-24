local tb = require('telescope.builtin')
local live_grep_args_module = require('telescope').extensions.live_grep_args

vim.keymap.set('n', '<leader>ff', tb.find_files, { desc = 'Telescope find files' })

vim.keymap.set('n', '<leader>fb', tb.buffers, { desc = 'Telescope buffers' })

vim.keymap.set('n', '<leader>fh', tb.help_tags, { desc = 'Telescope help tags' })

--vim.keymap.set("n", "<leader>fs", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set("n", "<leader>fs", live_grep_args_module.live_grep_args, { desc = 'Telescope live grep args' })

vim.keymap.set('n', 'gr', tb.lsp_references, { noremap = true, silent = true, desc = 'Telescope LSP references' })

vim.keymap.set('n', 'gd', tb.lsp_definitions, { noremap = true, silent = true, desc = 'Telescope LSP definitions' })

vim.keymap.set('n', '<leader>dd', function()
    tb.diagnostics({
        bufnr = 0,
    })
end, { noremap = true, silent = true, desc = 'Telescope diagnostics' })
