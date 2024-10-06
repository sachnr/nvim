return {
	{
		"stevearc/conform.nvim",
		keys = { {
			"<leader>f",
			function()
				require("conform").format({})
			end,
			desc = "Format",
		} },
		config = function()
			require("conform").setup({
				formatters = {
					leptosfmt = {
						command = "leptosfmt",
						args = { "--stdin", "--rustfmt", "$FILENAME" },
						stdin = "true",
					},
					wgslfmt = {
						command = "wgslfmt",
						args = { "$FILENAME" },
						stdin = "false",
					},
					norgfmt = {
						command = "norg-fmt",
						args = { "$FILENAME" },
						stdin = "false",
					},
				},
				formatters_by_ft = {
					c = { "clang-format" },
					cpp = { "clang-format" },
					css = { "prettierd", "prettier", stop_after_first = true },
					go = { "gofmt" },
					html = { "prettierd", "prettier", stop_after_first = true },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettierd", "prettier", stop_after_first = true },
					jsonc = { "prettierd", "prettier", stop_after_first = true },
					liquid = { "prettierd", "prettier", stop_after_first = true },
					lua = { "stylua" },
					markdown = { "prettierd", "prettier", stop_after_first = true },
					nix = { "nixfmt" },
					norg = { "norgfmt" },
					python = { "black" },
					rust = { "leptosfmt", "rustfmt", stop_after_first = true },
					scss = { "prettierd", "prettier", stop_after_first = true },
					sh = { "shfmt" },
					sql = { "pg_format" },
					toml = { "taplo" },
					template = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					vue = { "prettierd", "prettier", stop_after_first = true },
					yaml = { "prettierd", "prettier", stop_after_first = true },
					zig = { "zigfmt" },
				},
			})
		end,
	},
}
