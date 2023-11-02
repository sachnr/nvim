---@diagnostic disable: missing-fields
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			local list = require("nvim-treesitter.parsers").get_parser_configs()
			configs.setup({
				ensure_installed = {
					"bash",
					"c",
					"cmake",
					"cpp",
					"css",
					"dockerfile",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"go",
					"html",
					"java",
					"javascript",
					"json",
					"jsonc",
					"jsdoc",
                    "latex",
					"lua",
					"markdown",
					"markdown_inline",
					"make",
					"norg",
					"nix",
					"python",
					"rust",
					"scss",
					"sql",
					"toml",
					"tsx",
					"typescript",
					"vue",
					"yaml",
					"yuck",
				},
				sync_install = true,
				auto_install = false,
				ignore_install = {},
				highlight = {
					enable = true,
				},
			})
		end,
		-- dependencies = { "nvim-treesitter/nvim-treesitter-context" },
	},
}
