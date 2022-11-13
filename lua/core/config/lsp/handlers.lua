local M = {}

M.uiSetup = function()
	local function lspSymbol(name, icon)
		local hl = "DiagnosticSign" .. name
		vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
	end

	lspSymbol("Error", "")
	lspSymbol("Info", "")
	lspSymbol("Hint", "")
	lspSymbol("Warn", "")
	lspSymbol("other", "")

	vim.diagnostic.config({
		virtual_text = false,
		signs = true,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		focusable = false,
		relative = "cursor",
	})

	-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	-- 	virtual_text = true,
	-- 	spacing = 7,
	-- 	prefix = " << ",
	-- 	source = "always",
	-- })
end

M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	local keymap = vim.keymap.set

	keymap(
		"n",
		"]d",
		"<cmd>lua vim.diagnostic.goto_next({" .. bufnr .. "})<cr>",
		{ noremap = true, silent = true, desc = "Lsp buf goto_next" }
	)
	keymap(
		"n",
		"[d",
		"<cmd>lua vim.diagnostic.goto_prev({" .. bufnr .. "})<cr>",
		{ noremap = true, silent = true, desc = "Lsp buf goto_prev" }
	)
	keymap(
		"n",
		"gD",
		"<cmd>lua vim.lsp.buf.declaration()<CR>",
		-- "<cmd>Telescope lsp_declarations<CR>",
		{ noremap = true, silent = true, desc = "Lsp Buf declaration", buffer = bufnr }
	)
	keymap(
		"n",
		"gd",
		"<cmd>lua vim.lsp.buf.definition()<CR>",
		-- "<cmd>Telescope lsp_definitions<CR>",
		{ noremap = true, silent = true, desc = "Lsp Buf definition", buffer = bufnr }
	)
	keymap(
		"n",
		"K",
		"<cmd>lua vim.lsp.buf.hover()<CR>",
		{ noremap = true, silent = true, desc = "Lsp Buf hover", buffer = bufnr }
	)
	keymap(
		"n",
		"gi",
		"<cmd>lua vim.lsp.buf.implementation()<CR>",
		-- "<cmd>Telescope lsp_implementations<CR>",
		{ noremap = true, silent = true, desc = "Lsp Buf implementation", buffer = bufnr }
	)
	keymap(
		"n",
		"gr",
		"<cmd>lua vim.lsp.buf.references()<CR>",
		-- "<cmd>Telescope lsp_references<CR>",
		{ noremap = true, silent = true, desc = "Lsp Buf references", buffer = bufnr }
	)
	keymap(
		"n",
		"<C-k>",
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		{ noremap = true, silent = true, desc = "Lsp Buf signatureHelp", buffer = bufnr }
	)
	keymap(
		"n",
		"<leader>ll",
		"<cmd>lua vim.diagnostic.open_float()<CR>",
		{ noremap = true, silent = true, desc = "Diagnostics open_float" }
	)
	keymap(
		"n",
		"<leader>ld",
		"<cmd>lua vim.lsp.buf.type_definition<cr>",
		{ noremap = true, silent = true, desc = "Buf rename", buffer = bufnr }
	)
	keymap(
		"n",
		"<leader>lf",
		"<cmd>lua vim.lsp.buf.format{ async = true }<cr>",
		{ noremap = true, silent = true, desc = "Buf format", buffer = bufnr }
	)
	keymap(
		"n",
		"<leader>la",
		"<cmd>lua vim.lsp.buf.code_action()<cr>",
		{ noremap = true, silent = true, desc = "Buf code_action", buffer = bufnr }
	)
	keymap(
		"n",
		"<leader>lr",
		"<cmd>lua vim.lsp.buf.rename()<cr>",
		{ noremap = true, silent = true, desc = "Buf rename", buffer = bufnr }
	)

	-- jdtls
	if client.name == "jdtls" then
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls").add_commands()
		require("jdtls.dap").setup_dap_main_class_configs()
	end

	-- local status_ok, illuminate = pcall(require, "illuminate")
	-- if not status_ok then
	-- 	return
	-- end
	-- illuminate.on_attach(client)
end

M.capablities = function()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then
		return cmp_nvim_lsp.default_capabilities()
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}

	return capabilities
end

return M
