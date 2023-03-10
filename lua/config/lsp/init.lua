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

require("neoconf").setup({
	import = {
		vscode = false, -- local .vscode/settings.json
		coc = false, -- global/local coc-settings.json
		nlsp = false, -- global/local nlsp-settings.nvim json settings
	},
	live_reload = false,
	plugins = {
		lua_ls = {
			enabled = true,
		},
	},
})
require("neodev").setup()

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capablities,
	})
end

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capablities,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})
