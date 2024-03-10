local keys = require("keys")
return {
	{
		"pmizio/typescript-tools.nvim",
		event = { "BufReadPre *.ts,*.tsx,*.js,*.jsx", "BufNewFile *.ts,*.tsx,*.js,*.jsx" },
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lspconfig" },
		opts = {
			on_attach = function(client, bufnr)
				client.server_capabilities.semanticTokensProvider = nil
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				keys.lsp_attach(bufnr)
			end,

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
