return {
	{
		"pmizio/typescript-tools.nvim",
		event = { "BufReadPre *.ts,*.tsx,*.js,*.jsx", "BufNewFile *.ts,*.tsx,*.js,*.jsx" },
		on_attach = function()
			local keys = require("keys")
			local on_attach_common = function(client, buffer)
				client.server_capabilities.semanticTokensProvider = nil
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				keys.lsp_attach(buffer)
			end
		end,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lspconfig" },
		opts = {
			settings = {
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayVariableTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
				},
			},
		},
	},
}
