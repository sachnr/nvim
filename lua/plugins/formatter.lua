return {
	{
		"mhartington/formatter.nvim",
		keys = {
			{ "<leader>f", "<cmd>Format<cr>", desc = "Format" },
		},
		config = function()
			local formatter = require("formatter")
			local util = require("formatter.util")

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
				end

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

			local filetypes = {
				css = require("formatter.filetypes.css").prettier,
				html = require("formatter.filetypes.html").prettier,
				scss = prettier,
				yaml = require("formatter.filetypes.yaml").prettier,
				markdown = require("formatter.filetypes.markdown").prettier,
				json = require("formatter.filetypes.json").jq,
				jsonc = require("formatter.filetypes.json").jq,
				typescriptreact = prettier,
				typescript = prettier,
				javascript = prettier,
				javascriptreact = prettier,
				java = {
					function()
						return {
							exe = "astyle",
							args = { "--mode=" .. "java" },
							stdin = true,
						}
					end,
				},
				c = require("formatter.filetypes.c").astyle,
				cpp = require("formatter.filetypes.cpp").astyle,
				cs = require("formatter.filetypes.cs").astyle,
				lua = require("formatter.filetypes.lua").stylua,
				sh = require("formatter.filetypes.sh").shfmt,
				python = require("formatter.filetypes.python").black,
				nix = require("formatter.filetypes.nix").alejandra,
				rust = require("formatter.filetypes.rust").rustfmt,
				sql = require("formatter.filetypes.sql").pgformat,
				go = require("formatter.filetypes.go").gofmt,
			}

			formatter.setup({
				logging = true,
				filetype = filetypes,
			})
		end,
	},
}
