local keymap = function(mode, l, r, opt)
	local opts = opt or {}
	vim.keymap.set(mode, l, r, opts)
end

-- Do Not Yunk With X
keymap('n', 'x', '"_x')
-- Increment/decrement
-- keymap('n', '+', '<C-a>')
-- keymap('n', '-', '<C-x>')
-- Select All
keymap('n', '<C-a>', 'gg<S-v>G')
-- New Tab
keymap('n', 'te', ':tabedit<Cr>', { silent = true })
-- Split Window
keymap('n', 'ss', ':split<CR><C-w>w', { silent = true })
keymap('n', 'sv', ':vsplit<CR><C-w>w', { silent = true })
-- Window Move
keymap('n', 'sh', '<C-W>h', { silent = true })
keymap('n', 'sj', '<C-W>j', { silent = true })
keymap('n', 'sk', '<C-W>k', { silent = true })
keymap('n', 'sl', '<C-W>l', { silent = true })
-- Alternative
keymap('n', 's<Left>', '<C-W>h', { silent = true })
keymap('n', 's<Down>', '<C-W>j', { silent = true })
keymap('n', 's<Up>', '<C-W>k', { silent = true })
keymap('n', 's<Right>', '<C-W>l', { silent = true })
--Resize Window
keymap('n', '<C-Left>', '<C-w><', { silent = true })
keymap('n', '<C-Right>', '<C-w>>', { silent = true })
keymap('n', '<C-Up>', '<C-w>+', { silent = true })
keymap('n', '<C-Down>', '<C-w>-', { silent = true })
-- Clipboard
keymap({ 'n', 'v' }, 'p', 'gp', { silent = true })
keymap('i', '<C-p>', '<Esc>gpa', { silent = true })
keymap('n', 'yy', 'ma0vg_y`a')
-- Save All Buffers
keymap({ 'n', 'i' }, 'Sa', '<Cmd>wa<CR>')

