return {
	{
		"mhartington/formatter.nvim",
		enabled = false,
		keys = {
			{ "<leader>f", "<cmd> :Format <CR>", desc = "Format" },
		},
		config = function()
			local formatter = require("formatter")
			local util = require("formatter.util")

			local embedded_sql_format = function()
				require("format_embedded")
					:builder({
						exe = "pg_format",
						args = { "-" },
						ts_query_lang = "rust",
						ts_query = [[
                        (macro_invocation
                          (scoped_identifier
                            path: (identifier) @path (#eq? @path "sqlx")
                            name: (identifier) @name (#eq? @name "query"))
       
                          (token_tree
                            (raw_string_literal) @sql_query) 
                            (#offset! @sql_query 1 0 -1 0))
                        ]],
						ts_cap_name = "sql_query",
					})
					:run()
			end


			local prettier = function(parser)
				if not parser then
					return {
						exe = "prettier",
						args = {
							"--config-precedence",
							"prefer-file",
							"--single-quote",
							"--no-bracket-spacing",
							"--prose-wrap",
							"always",
							"--arrow-parens",
							"always",
							"--trailing-comma",
							"all",
							"--tab-width 4",
							"--stdin-filepath",
							util.escape_path(util.get_current_buffer_file_path()),
						},
						stdin = true,
						try_node_modules = true,
					}
				else
					return {
						exe = "prettier",
						args = {
							"--tab-width 4",
							"--stdin-filepath",
							util.escape_path(util.get_current_buffer_file_path()),
							"--parser",
							parser,
						},
						stdin = true,
						try_node_modules = true,
					}
				end
			end

			local clang = function()
				local style = [[ -style="{ SortIncludes: false }" ]]
				return {
					exe = "clang-format",
					args = {
						style,
						"-assume-filename",
						util.escape_path(util.get_current_buffer_file_name()),
					},
					stdin = true,
					try_node_modules = true,
				}
			end

			local wgslfmt = function()
				return {
					exe = "wgslfmt",
					arg = util.escape_path(util.get_current_buffer_file_path()),
					stdin = false,
				}
			end

			local filetypes = {
				c = clang,
				cpp = clang,
				cs = require("formatter.filetypes.cs").astyle,
				css = require("formatter.filetypes.css").prettier,
				go = require("formatter.filetypes.go").gofmt,
				glsl = clang,
				html = require("formatter.filetypes.html").prettier,
				java = {
					function()
						return {
							exe = "astyle",
							args = { "--mode=" .. "java" },
							stdin = true,
						}
					end,
				},
				javascript = prettier,
				javascriptreact = prettier,
				json = require("formatter.filetypes.json").jq,
				jsonc = require("formatter.filetypes.json").jq,
				liquid = vim.lsp.buf.format(),
				lua = require("formatter.filetypes.lua").stylua,
				markdown = require("formatter.filetypes.markdown").prettier,
				nix = require("formatter.filetypes.nix").nixfmt,
				python = require("formatter.filetypes.python").black,
				rust = function()
					embedded_sql_format()
					-- embedded_json_format()
					return {
						exe = "rustfmt",
						args = { "--edition 2021" },
						stdin = true,
					}
				end,
				scss = prettier,
				sh = require("formatter.filetypes.sh").shfmt,
				sql = require("formatter.filetypes.sql").pgformat,
				toml = require("formatter.filetypes.toml").taplo,
				typescript = prettier,
				typescriptreact = prettier,
				wgsl = wgslfmt,
				yaml = require("formatter.filetypes.yaml").prettier,
				zig = require("formatter.filetypes.zig").zigfmt,
			}

			formatter.setup({
				logging = true,
				filetype = filetypes,
			})
		end,
	},
}
