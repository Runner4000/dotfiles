local cmd = vim.cmd
local opt = vim.opt
local api = vim.api

-- Encoding
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
--Tab spacing
opt.tabstop = 2
opt.shiftwidth = 2
opt.smarttab = true
opt.expandtab = true
opt.smartindent = true
-- Relative hybrid number
vim.wo.number = true
local number_toggle = api.nvim_create_augroup('NumToggle', {clear = true})
api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },{
  command = 'if &nu && mode() != "i" | set rnu   | endif',
	group = number_toggle
})
api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },{
	command = 'if &nu | set nornu | endif',
	group = number_toggle
})
-- Minor configs
opt.backup = false
opt.shell = "zsh"
opt.backupskip = "/tmp"
opt.ignorecase = true
opt.swapfile = false
-- ui config
opt.termguicolors = true
opt.hlsearch = true
opt.cursorline = true
opt.laststatus = 2
opt.scrolloff = 7
opt.title = true
opt.wrap = false
-- Clipboard support (install wl-clipboard utility for support)
opt.clipboard:append { "unnamedplus" }
