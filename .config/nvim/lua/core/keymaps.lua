vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- tab keys
vim.keymap.set('n', '<leader>h', ':tabprev<CR>')
vim.keymap.set('n', '<leader>l', ':tabnext<CR>')

-- find files
vim.keymap.set('n', '<leader>.', ':Telescope find_files<CR>')

-- files
vim.keymap.set('n', '<leader>fs', ':w<CR>')

-- buffers
vim.keymap.set('n', '<leader>bb', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>bk', ':bd<CR>')
vim.keymap.set('n', '<leader>bp', ':bnext<CR>')
vim.keymap.set('n', '<leader>bn', ':bprevious<CR>')

-- windows
vim.keymap.set('n', '<leader>ww', '<c-w>w')
vim.keymap.set('n', '<leader>wv', '<c-w>v')
vim.keymap.set('n', '<leader>wn', '<c-w>n')

-- follow definition
vim.keymap.set('n', '<M-.>', 'gd')

-- indentation
vim.keymap.set('n', '<TAB>', '==')
vim.keymap.set('v', '<TAB>', '=')

-- comments
vim.keymap.set('n', '<C-/>', ':CommentToggle<CR>')
vim.keymap.set('v', '<C-/>', ':\'<,\'>CommentToggle<CR>')
