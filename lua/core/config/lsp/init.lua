local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("base46").load_highlight("lsp")

local opts = {}
local handlers = require("core.config.lsp.handlers")
local on_attach = handlers.on_attach
local capablities = handlers.capablities()

local servers = {
	"html",
	"bashls",
	"jsonls",
	"cssls",
	"clangd",
	"eslint",
	"vuels",
	"pylsp",
	"sqlls",
}

handlers.uiSetup()

lspconfig.sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capablities,
	settings = {
		Lua = {
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

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capablities,
	})
end
