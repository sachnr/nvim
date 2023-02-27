local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("config.lsp.handlers")
local opts = require("config.lsp.settings")
local on_attach = opts.on_attach
local capablities = opts.capablities

local servers = {
	"html",
	"bashls",
	"jsonls",
	"cssls",
	"ccls",
	"vuels",
	"lua_ls",
	"pylsp",
	"sqls",
	"gopls",
	"tsserver",
	-- "eslint",
	"yamlls",
	"rnix",
}

require("neoconf").setup({})
require("neodev").setup()

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capablities,
	})
end
