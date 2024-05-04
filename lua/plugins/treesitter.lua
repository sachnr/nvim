---@diagnostic disable: missing-fields
return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			-- "nvim-treesitter/playground",
		},
		config = function()
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.asm = {
				install_info = {
					url = "https://github.com/rush-rs/tree-sitter-asm.git",
					files = { "src/parser.c" },
					branch = "main",
				},
			}
			local configs = require("nvim-treesitter.configs")
			local list = require("nvim-treesitter.parsers").get_parser_configs()
			configs.setup({
				ensure_installed = {
					"bash",
					"c",
					"cmake",
					"cpp",
					"css",
					"csv",
					"diff",
					"dockerfile",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"go",
					"gosum",
					"gomod",
					"html",
					"java",
					"javascript",
					"json",
					"jsonc",
					"jsdoc",
					"latex",
					"liquid",
					"lua",
					"markdown",
					"markdown_inline",
					"make",
					-- "norg",
					"nix",
					"python",
					"rust",
					"scss",
					"sql",
					"toml",
					"tsx",
					"typescript",
					"vue",
					"vimdoc",
					-- "yaml",
					"yuck",
					"zig",
				},
				sync_install = true,
				auto_install = false,
				ignore_install = {},
				highlight = {
					enable = true,
					ignore = { "*.min.js" },
				},
				playground = {
					enable = false,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
			})
		end,
		-- dependencies = { "nvim-treesitter/nvim-treesitter-context" },
	},
}
