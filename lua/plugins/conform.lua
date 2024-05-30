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
					css = { { "prettierd", "prettier" } },
					go = { "gofmt" },
					html = { { "prettierd", "prettier" } },
					javascript = { { "prettierd", "prettier" } },
					javascriptreact = { { "prettierd", "prettier" } },
					json = { { "prettierd", "prettier" } },
					jsonc = { { "prettierd", "prettier" } },
					liquid = { { "prettierd", "prettier" } },
					lua = { "stylua" },
					markdown = { { "prettierd", "prettier" } },
					nix = { "nixfmt" },
					norg = { "norgfmt" },
					python = { "black" },
					rust = { { "leptosfmt", "rustfmt" } },
					scss = { { "prettierd", "prettier" } },
					sh = { "shfmt" },
					sql = { "pg_format" },
					toml = { "taplo" },
					template = { { "prettierd", "prettier" } },
					typescript = { { "prettierd", "prettier" } },
					typescriptreact = { { "prettierd", "prettier" } },
					vue = { { "prettierd", "prettier" } },
					yaml = { { "prettierd", "prettier" } },
					zig = { "zigfmt" },
				},
			})
		end,
	},
}
