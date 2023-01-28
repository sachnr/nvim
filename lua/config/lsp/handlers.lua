local border = require("utils").border("FloatBorder")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	signs = {
		severity_limit = "Warning",
	},
	underline = {
		severity_limit = "Warning",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

-- jump to first definition
vim.lsp.handlers["textDocument/definition"] = function(_, result)
	if not result or vim.tbl_isempty(result) then
		print("[LSP] Could not find definition")
		return
	end

	local params = vim.lsp.util.make_position_params()
	if vim.tbl_islist(result) then
		vim.lsp.util.jump_to_location(result[1], "utf-8")
	else
		vim.lsp.util.jump_to_location(result, "utf-8")
	end
end

vim.diagnostic.config({
	virtual_text = {
		source = "always",
		prefix = "■",
		-- Only show virtual text matching the given severity
		severity = {
			-- Specify a range of severities
			min = vim.diagnostic.severity.ERROR,
		},
	},
	float = {
		source = "always",
		border = "rounded",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

--lsp signs
local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end
lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")
lspSymbol("other", "")
