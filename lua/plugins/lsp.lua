return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		dependencies = {
			{
				"pmizio/typescript-tools.nvim",
				-- "folke/neodev.nvim",
				-- "folke/neoconf.nvim",
				"nvim-lua/plenary.nvim",
				"simrat39/rust-tools.nvim",
			},
		},
		config = function()
			local keys = require("keys")

			local on_attach = function(client, buffer)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				-- client.server_capabilities.semanticTokensProvider = nil
				keys.lsp_attach(buffer)
				vim.lsp.log.set_level(vim.log.levels.OFF)
			end

			--lsp signs
			local function lspSymbol(name, icon)
				local hl = "DiagnosticSign" .. name
				vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
			end

			-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			-- signs = {
			-- 	severity_limit = "Warning",
			-- },
			-- 	underline = {
			-- 		severity_limit = "Warning",
			-- 	},
			-- })

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

			-- jump to first definition
			-- vim.lsp.handlers["textDocument/definition"] = function(_, result)
			-- 	if not result or vim.tbl_isempty(result) then
			-- 		print("[LSP] Could not find definition")
			-- 		return
			-- 	end
			--
			-- 	local params = vim.lsp.util.make_position_params()
			-- 	if vim.tbl_islist(result) then
			-- 		vim.lsp.util.jump_to_location(result[1], "utf-8")
			-- 	else
			-- 		vim.lsp.util.jump_to_location(result, "utf-8")
			-- 	end
			-- end

			vim.diagnostic.config({
				virtual_text = {
					source = "always",
					prefix = "■",
					spacing = 2,
					severity = {
						min = vim.diagnostic.severity.ERROR,
					},
				},
				float = {
					source = "always",
					border = "single",
				},
				signs = true,
				underline = {
					severity = {
						min = vim.diagnostic.severity.WARN,
					},
				},
				update_in_insert = false,
				severity_sort = true,
			})

			lspSymbol("Error", " ")
			lspSymbol("Info", " ")
			lspSymbol("Hint", " ")
			lspSymbol("Warn", " ")
			lspSymbol("other", " ")

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				"html",
				"bashls",
				"jsonls",
				"cssls",
				"ccls",
				-- "vuels",
				"pylsp",
				"sqlls",
				-- "gopls",
				-- "tsserver",
				"yamlls",
				-- "nil_ls",
			}

			local lspconfig = require("lspconfig")
			local ts_tools = require("typescript-tools")
			local rust_tools = require("rust-tools")

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			lspconfig.gopls.setup({
				on_attach = function(client, buffer)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					require("keys").lsp_attach(buffer)
					vim.lsp.inlay_hint(buffer, true)
				end,
				capabilities = capabilities,
				settings = {
					gopls = {
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
			})

			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
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

			rust_tools.setup({
				tools = {
					hover_actions = {
						border = "single",
					},
				},
				server = {
					on_attach = function(client, bufnr)
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
						keys.lsp_attach(bufnr)
						local opt = { silent = true, noremap = true, buffer = bufnr }
						local set = vim.keymap.set
						set(
							"n",
							"K",
							rust_tools.hover_actions.hover_actions,
							vim.tbl_deep_extend("force", opt, { desc = "Hover" })
						)
						set(
							"n",
							"ga",
							rust_tools.code_action_group.code_action_group,
							vim.tbl_deep_extend("force", opt, { desc = "code_action" })
						)
					end,
					capabilities = capabilities,
					cmd = {
						"rustup",
						"run",
						"stable",
						"rust-analyzer",
					},
				},
			})

			ts_tools.setup({
				on_attach = function(client, buffer)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					keys.lsp_attach(buffer)
					vim.lsp.inlay_hint(buffer, true)
				end,
				settings = {
					separate_diagnostic_server = true,
					tsserver_file_preferences = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
			})
		end,
	},
}
