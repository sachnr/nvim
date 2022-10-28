local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("base46").load_highlight("lsp")

local handlers = require("core.config.lsp.handlers")
local on_attach = handlers.on_attach
local capablities = handlers.capablities()

local servers = {
	"html",
	"bashls",
	"jsonls",
	"cssls",
	"clangd",
	"vuels",
	"pylsp",
	"sqlls",
	"gopls",
}

handlers.uiSetup()

local eslint = {
	lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m" },
	lintIgnoreExitCode = true,
	formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
	formatStdin = true,
}

-- javascript, typescript
lspconfig.efm.setup({
	on_attach = on_attach,
	capablities = capablities,
	settings = {
		languages = {
			javascript = { eslint },
			javascriptreact = { eslint },
			["javascript.jsx"] = { eslint },
			typescript = { eslint },
			["typescript.tsx"] = { eslint },
			typescriptreact = { eslint },
		},
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
	},
})

-- lua
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
