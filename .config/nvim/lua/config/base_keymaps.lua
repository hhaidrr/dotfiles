vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Go to NetRW
vim.keymap.set('n', '<leader>e', ':Explore<CR>', { noremap = true, silent = true })
-- Select all
vim.keymap.set({'n','v'}, '<leader>a', 'ggVG', { noremap = true })


