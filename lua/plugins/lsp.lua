---@diagnostic disable: inject-field
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		dependencies = {
			{
				-- "pmizio/typescript-tools.nvim",
				-- "folke/neodev.nvim",
				-- "folke/neoconf.nvim",
				"nvim-lua/plenary.nvim",
				-- "simrat39/rust-tools.nvim",
				"ray-x/lsp_signature.nvim",
				"simrat39/inlay-hints.nvim",
			},
		},
		config = function()
			local keys = require("keys")
			local lspconfig = require("lspconfig")
			local lsp_signature = require("lsp_signature")
			local inlay_hints = require("inlay-hints")

			inlay_hints.setup({
				renderer = "inlay-hints/render/eol",
				eol = {
					parameter = {
						format = function(hints)
							return string.format(" <- (%s)", hints)
						end,
					},

					type = {
						separator = ", ",
						format = function(hints)
							return string.format(" => %s", hints)
						end,
					},
				},
			})

			local on_attach = function(client, buffer)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				-- client.server_capabilities.semanticTokensProvider = nil
				keys.lsp_attach(buffer)
				lsp_signature.on_attach({
					handler_opts = {
						border = "single",
					},
					hint_enable = false,
				}, buffer)
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

			local icons = require("icons").diagnostics

			lspSymbol("Error", icons.error)
			lspSymbol("Info", icons.info)
			lspSymbol("Hint", icons.hint)
			lspSymbol("Warn", icons.warn)
			lspSymbol("other", icons.other)

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local servers = {
				"html",
				"bashls",
				"jsonls",
				"cssls",
				"ccls",
				-- "vuels",
				"pylsp",
				-- "gopls",
				-- "tsserver",
				"yamlls",
				"nil_ls",
				"eslint",
			}

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
					vim.g.inlay_hints_enabled = true
					-- vim.lsp.inlay_hint(buffer, true)
					inlay_hints.on_attach(client, buffer)
					lsp_signature.on_attach({
						handler_opts = {
							border = "single",
						},
						hint_enable = false,
					}, buffer)
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

			lspconfig.rust_analyzer.setup({
				on_attach = function(client, buffer)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					keys.lsp_attach(buffer)
					inlay_hints.on_attach(client, buffer)
					lsp_signature.on_attach({
						handler_opts = {
							border = "single",
						},
						hint_enable = false,
					}, buffer)
				end,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						procMacro = {
							enable = true,
						},
						experimental = {
							procAttrMacros = true,
						},
						checkOnSave = {
							command = "clippy",
						},
						inlayHints = {
							lifetimeElisionHints = {
								enable = true,
								useParameterNames = true,
							},
						},
					},
				},
			})

			lspconfig.tsserver.setup({
				on_attach = function(client, buffer)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					keys.lsp_attach(buffer)
					vim.g.inlay_hints_enabled = true
					inlay_hints.on_attach(client, buffer)
					lsp_signature.on_attach({
						handler_opts = {
							border = "single",
						},
						hint_enable = false,
					}, buffer)
				end,
				capabilities = capabilities,
				settings = {
					separate_diagnostic_server = true,
					tsserver_file_preferences = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "literals", -- 'none' | 'literals' | 'all';
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
			})

			lspconfig.tailwindcss.setup({
				on_attach = function(client, buffer)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					keys.lsp_attach(buffer)
					inlay_hints.on_attach(client, buffer)
				end,
				capabilities = capabilities,
				filetypes = {
					"css",
					"django-html",
					"gohtml",
					"gohtmltmpl",
					"html",
					"htmldjango",
					"javascript",
					"javascriptreact",
					"postcss",
					"rust",
					"sass",
					"scss",
					"svelte",
					"typescript",
					"typescriptreact",
					"vue",
				},
				init_options = {
					userLanguages = {
						rust = "html",
					},
				},
			})

			local function toggle_inlay_hints()
				local current_buffer = vim.api.nvim_get_current_buf()
				if not vim.g.inlay_hints_enabled then
					vim.g.inlay_hints_enabled = true
					vim.lsp.inlay_hint(current_buffer, true)
				else
					vim.g.inlay_hints_enabled = false
					vim.lsp.inlay_hint(current_buffer, false)
				end
			end
			vim.api.nvim_create_user_command("ToggleInlayHints", function()
				toggle_inlay_hints()
			end, { nargs = 0 })
		end,
	},
}
