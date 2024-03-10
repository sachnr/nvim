---@diagnostic disable: inject-field, need-check-nil
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		dependencies = {
			{
				"nvim-lua/plenary.nvim",
				"mrcjkb/rustaceanvim",
				"folke/neodev.nvim",
			},
		},

		config = function()
			local keys = require("keys")
			local lspconfig = require("lspconfig")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local on_attach_common = function(client, buffer)
				client.server_capabilities.semanticTokensProvider = nil
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				keys.lsp_attach(buffer)
			end

			--lsp signs
			local function lspSymbol(name, icon)
				local hl = "DiagnosticSign" .. name
				vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
			end

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

			local servers = {
				"html",
				"glsl_analyzer",
				"wgsl_analyzer",
				"bashls",
				"jsonls",
				"cssls",
				-- "ccls",
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
					on_attach = on_attach_common,
					capabilities = capabilities,
				})
			end

			require("neodev").setup({
				override = function(root_dir, library)
					if root_dir:find("/etc/nixos", 1, true) == 1 then
						library.enabled = true
						library.plugins = true
					end
				end,
			})

			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--all-scopes-completion",
					"--cross-file-rename",
					"--completion-style=detailed",
					"--header-insertion-decorators",
					"--header-insertion=iwyu",
					"--pch-storage=memory",
					"--pretty",
				},
				on_attach = on_attach_common,
				capabilities = capabilities,
				-- settings = {},
			})

			lspconfig.gopls.setup({
				on_attach = function(client, buffer)
					on_attach_common(client, buffer)
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

			vim.g.rustaceanvim = function()
				return {
					server = {
						on_attach = function(client, bufnr)
							on_attach_common(client, bufnr)
							require("keys").lsp_attach(bufnr)
						end,
						capabilities = capabilities,
						settings = {
							["rust-analyzer"] = {
								procMacro = {
									enable = true,
								},
								experimental = { procAttrMacros = true },
								checkOnSave = { command = "clippy" },
								inlayHints = {
									lifetimeElisionHints = { enable = true, useParameterNames = true },
								},
							},
						},
					},
				}
			end

			lspconfig.tsserver.setup({
				on_attach = function(client, bufnr)
					on_attach_common(client, bufnr)
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
				root_dir = function(fname)
					local root_pattern = require("lspconfig").util.root_pattern(
						"tailwind.config.cjs",
						"tailwind.config.js",
						"postcss.config.js"
					)
					return root_pattern(fname)
				end,
				init_options = {
					userLanguages = {
						rust = "html",
					},
				},
			})

			lspconfig.zls.setup({
				on_attach = function(client, bufnr)
					on_attach_common(client, bufnr)
					vim.lsp.inlay_hint.enable(bufnr, true)
				end,
				capabilities = capabilities,
			})
		end,
	},
}
