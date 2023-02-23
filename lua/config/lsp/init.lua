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
	"pylsp",
	"sqls",
	"gopls",
	"tsserver",
	-- "eslint",
	"yamlls",
	"rnix",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capablities,
	})
end

-- lua
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capablities,
	settings = {
		Lua = {
			completion = {
				workspaceWord = true,
				callSnippet = "Both",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})

