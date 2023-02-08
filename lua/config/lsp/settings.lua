local M = {}
local keys = require("keys")

M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	keys.lsp_attach(bufnr)
	-- jdtls
	if client.name == "jdtls" then
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls").add_commands()
		require("jdtls.dap").setup_dap_main_class_configs()
	end
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- M.capabilities = function()
-- 	local capabilities = vim.lsp.protocol.make_client_capabilities()
-- 	capabilities.textDocument.completion.completionItem = {
-- 		snippetSupport = true,
-- 		resolveSupport = {
-- 			properties = {
-- 				"documentation",
-- 				"detail",
-- 				"additionalTextEdits",
-- 			},
-- 		},
-- 	}
-- 	return capabilities
-- end

return M
