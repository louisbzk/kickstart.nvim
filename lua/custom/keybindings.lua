vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Center cursor after moving up half-page' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Center cursor after moving down half-page' })
vim.keymap.set('n', '<C-b>', '<C-b>zz', { desc = 'Center cursor after moving up full page' })
vim.keymap.set('n', '<C-f>', '<C-f>zz', { desc = 'Center cursor after moving down full page' })
vim.keymap.set('n', "<leader>'", '`', { noremap = true, silent = true, desc = 'Jump to mark (Backtick)' })
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', { desc = 'Open file browser' })
vim.keymap.set('n', '<leader>d<CR>', ':lua require("neogen").generate()<CR>', { desc = 'Generate [D]ocstring' })
vim.keymap.set('n', '<F4>', ':let @+ = expand("%:p")<CR>', { desc = 'Copy full path of current buffer to clipboard' })
vim.keymap.set('n', '<leader>nh', ':Gitsigns next_hunk<CR>', { desc = 'Gitsigns [N]ext_[H]unk' })
vim.keymap.set('n', '<leader>ph', ':Gitsigns prev_hunk<CR>', { desc = 'Gitsigns [P]rev_[H]unk' })
vim.keymap.set('n', '<leader>vh', ':Gitsigns preview_hunk<CR>', { desc = 'Gitsigns pre[V]iew [H]unk' })
