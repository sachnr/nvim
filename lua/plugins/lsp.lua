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
			local set = vim.keymap.set
			local opts = {
				silent = true,
				noremap = true,
			}
			local merge = function(table1, table2)
				return vim.tbl_deep_extend("force", table1, table2)
			end
			local lsp_attach = function(bufnr)
				set("n", "<space>e", vim.diagnostic.open_float, merge(opts, { desc = "diagnostic float" }))
				set("n", "[d", vim.diagnostic.goto_prev, merge(opts, { desc = "diagnostic goto prev" }))
				set("n", "]d", vim.diagnostic.goto_next, merge(opts, { desc = "diagnostic goto next" }))
				-- set("n", "<leader>lq", vim.diagnostic.setloclist, merge(opts, { desc = "diagnostic setlocklist" }))
				local lsp_opts = merge(opts, { buffer = bufnr })
				set("n", "ga", vim.lsp.buf.code_action, merge(lsp_opts, { desc = "code_action" }))
				-- set("n", "ga", "<cmd> FzfLua lsp_code_actions <cr>", merge(lsp_opts, { desc = "code_action" }))
				set("n", "gh", vim.lsp.buf.references, merge(lsp_opts, { desc = "goto references" }))
				set("n", "gr", vim.lsp.buf.rename, merge(lsp_opts, { desc = "lsp rename" }))
				set("n", "K", vim.lsp.buf.hover, merge(lsp_opts, { desc = "hover" }))
				set("n", "gD", vim.lsp.buf.declaration, merge(lsp_opts, { desc = "goto declaration" }))
				set("n", "gd", vim.lsp.buf.definition, merge(lsp_opts, { desc = "goto definition" }))
				set("n", "gi", vim.lsp.buf.implementation, merge(lsp_opts, { desc = "goto implementation" }))
				set("n", "<C-k>", vim.lsp.buf.signature_help, merge(lsp_opts, { desc = "signature_help" }))
				set("n", "<leader>ld", vim.lsp.buf.type_definition, merge(lsp_opts, { desc = "Type Definition" }))
			end

			local lspconfig = require("lspconfig")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local on_attach_common = function(client, buffer)
				client.server_capabilities.semanticTokensProvider = nil
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				lsp_attach(buffer)
			end

			--lsp signs
			local function lspSymbol(name, icon)
				local hl = "DiagnosticSign" .. name
				vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
			end

			local icons = require("icons").diagnostics

			vim.diagnostic.config({
				virtual_text = {
					source = true,
					prefix = "■",
					spacing = 2,
					severity = {
						min = vim.diagnostic.severity.ERROR,
					},
				},

				float = {
					source = true,
					border = "single",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = icons.error,
						[vim.diagnostic.severity.WARN] = icons.warn,
						[vim.diagnostic.severity.HINT] = icons.hint,
						[vim.diagnostic.severity.INFO] = icons.info,
					},
				},
				-- signs = true,
				underline = {
					severity = {
						min = vim.diagnostic.severity.WARN,
					},
				},
				update_in_insert = false,
				severity_sort = true,
			})

			local servers = {
				"html",
				"glsl_analyzer",
				"wgsl_analyzer",
				"bashls",
				"jsonls",
				"cssls",
				-- "pylsp",
				"yamlls",
				"nil_ls",
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
				on_attach = function(client, buffer)
					on_attach_common(client, buffer)
				end,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						telemetry = { enable = false },
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})

			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--clang-tidy",
					"--compile-commands-dir=.",
					"--cross-file-rename",
					"--header-insertion-decorators",
					"--header-insertion=iwyu",
				},
				on_attach = on_attach_common,
				capabilities = capabilities,
			})

			lspconfig.gopls.setup({
				on_attach = function(client, buffer)
					on_attach_common(client, buffer)
				end,
				capabilities = capabilities,
				filetypes = { "go", "gomod", "gowork", "gotmpl", "tmpl" },
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
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
							lsp_attach(bufnr)
						end,
						capabilities = capabilities,
						settings = {
							["rust-analyzer"] = {
								procMacro = {
									enable = true,
									ignored = {
										leptos_macro = {
											-- optional: --
											-- "component",
											"server",
										},
									},
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

			local util = require("lspconfig.util")

			local function get_typescript_server_path(root_dir)
				local global_ts = "/home/" .. os.getenv("USER") .. "/.config/yarn/global/node_modules/typescript/lib"
				-- Alternative location if installed as root:
				-- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
				local found_ts = ""
				local function check_dir(path)
					found_ts = util.path.join(path, "node_modules", "typescript", "lib")
					if util.path.exists(found_ts) then
						return path
					end
				end
				if util.search_ancestors(root_dir, check_dir) then
					return found_ts
				else
					return global_ts
				end
			end

			lspconfig.volar.setup({
				filetypes = { "vue" },
				init_options = {
					vue = {
						hybridMode = false,
					},
					typescript = {
						tsdk = get_typescript_server_path(vim.fn.getcwd()),
					},
				},
			})

			lspconfig.ts_ls.setup({
				on_attach = function(client, bufnr)
					on_attach_common(client, bufnr)
				end,
				init_options = {
					plugins = {
						-- {
						-- 	name = "@vue/typescript-plugin",
						-- 	location = "/home/"
						-- 		.. os.getenv("USER")
						-- 		.. "/.config/yarn/global/node_modules/@vue/typescript-plugin",
						-- 	languages = { "javascript", "typescript", "vue" },
						-- },
					},
				},
				capabilities = capabilities,
				settings = {
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "all",
						includeInlayVariableTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
					},
				},
				filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			})

			lspconfig.pyright.setup({
				on_attach = function(client, bufnr)
					on_attach_common(client, bufnr)
				end,
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			lspconfig.tailwindcss.setup({
				on_attach = function(client, buffer)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					lsp_attach(buffer)
				end,
				capabilities = capabilities,
			})

			lspconfig.zls.setup({
				on_attach = function(client, bufnr)
					on_attach_common(client, bufnr)
				end,
				capabilities = capabilities,
			})

			local autocmd = vim.api.nvim_create_autocmd
			autocmd("FileType", {
				pattern = "liquid",
				callback = function()
					local root_dir = vim.fs.dirname(vim.fs.find({ ".theme-check.yml" }, { upward = true })[1])
					local client = vim.lsp.start({
						on_attach = function(_, bufnr)
							lsp_attach(bufnr)
						end,
						capabilities = capabilities,
						name = "shopify_ls",
						cmd = { "shopify", "theme", "language-server" },
						root_dir = root_dir,
					})
					if client then
						vim.lsp.buf_attach_client(vim.api.nvim_get_current_buf(), client)
					end
				end,
			})
		end,
	},
}
