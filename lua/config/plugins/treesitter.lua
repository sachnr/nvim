return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"cmake",
					"lua",
					"bash",
					"css",
					"html",
					"dockerfile",
					"java",
					"javascript",
					"json",
					"markdown",
					"markdown_inline",
					"python",
					"rust",
					"sql",
					"toml",
					"yaml",
					"vue",
					"typescript",
					"gitignore",
					"go",
					"scss",
					"nix",
					"yuck",
				},
				highlight = {
					enable = true,
					use_languagetree = true,
				},
			})
		end,
	},

	{ "nvim-treesitter/playground", cmd = { "TSHighlightCapturesUnderCursor", "TSPlaygroundToggle" } },
}
