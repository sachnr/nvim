return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
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
					"meson",
					"ninja",
					"php",
					"python",
					"r",
					"rasi",
					"regex",
					"rust",
					"ruby",
					"sql",
					"toml",
					"yaml",
					"vue",
					"typescript",
					"gitignore",
					"go",
					"latex",
					"scss",
					"nix",
					"query",
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
