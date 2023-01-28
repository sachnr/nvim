local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local handlers = require("config.lsp.settings")
local on_attach = handlers.on_attach
local capablities = handlers.capablities

null_ls.setup({
	on_attach = on_attach,
	capablities = capablities,
	sources = {
		-- null_ls.builtins.diagnostics.eslint_d,
		-- null_ls.builtins.code_actions.eslint_d,
	},
})
