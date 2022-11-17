local servers = {
	"sumneko_lua",
	"pyright",
	"jsonls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "+",
			package_uninstalled = "-",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then return end
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_install = true,
})
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then return end
local opts = {
  on_attach = require("xm4000.lsp.handlers").on_attach,
  capabilities = require("xm4000.lsp.handlers").capabilities,
}
mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup(opts)
  end,
  ["pyright"] = function()
    local opts = vim.tbl_extend("force", require("xm4000.lsp.servers.pyright"), opts)
    lspconfig.pyright.setup(opts)
  end,
  ["sumneko_lua"] = function()
    local opts = vim.tbl_extend("force", require("xm4000.lsp.servers.sumneko_lua"), opts)
    lspconfig.sumneko_lua.setup(opts)
  end,
})
