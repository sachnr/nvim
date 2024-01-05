---@diagnostic disable: inject-field, need-check-nil
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
				"mrcjkb/rustaceanvim",
				"simrat39/inlay-hints.nvim",
				"folke/neodev.nvim",
			},
		},
		config = function()
			local keys = require("keys")
			local lspconfig = require("lspconfig")
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

			local on_attach_common = function(client, buffer)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				-- client.server_capabilities.semanticTokensProvider = nil
				keys.lsp_attach(buffer)
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
					inlay_hints.on_attach(client, buffer)
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

			require("neodev").setup()

			lspconfig.lua_ls.setup({
				on_attach = on_attach_common,
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

			vim.g.rustaceanvim = function()
				local exepath = ""
				local libpath = ""
				local cfg = require("rustaceanvim.config")
				return {
					dap = {
						adapter = cfg.get_codelldb_adapter(exepath, libpath),
					},
					tools = {},
					server = {
						on_attach = function(client, bufnr)
							on_attach_common(client, bufnr)
							inlay_hints.on_attach(client, bufnr)
							local opts = { silent = true, noremap = true, buffer = bufnr }
							vim.keymap.set("n", "ga", function()
								vim.cmd.RustLsp("codeAction")
							end, opts)
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
					},
				}
			end

			lspconfig.tsserver.setup({
				on_attach = function(client, bufnr)
					on_attach_common(client, bufnr)
					inlay_hints.on_attach(client, bufnr)
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
					inlay_hints.on_attach(client, bufnr)
				end,
				capabilities = capabilities,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client.progress then
						client.progress = vim.ringbuf(10000)
						client.progress.pending = {}
					end
				end,
			})
		end,
	},
}
