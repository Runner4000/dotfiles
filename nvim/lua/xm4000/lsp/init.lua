local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then return end
require("xm4000.lsp.mason")
require("xm4000.lsp.handlers").setup()
vim.o.updatetime = 250
