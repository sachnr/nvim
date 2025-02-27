return {
	{
		"echasnovski/mini.colors",
		enabled = true,
		lazy = false,
	},

	{
		"echasnovski/mini.indentscope",
		enabled = false,
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.none(),
				},
				symbol = "│",
			})
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
		end,
	},

	{
		"echasnovski/mini.clue",
		enabled = false,
		event = "VeryLazy",
		config = function()
			local miniclue = require("mini.clue")
			miniclue.setup({
				triggers = {
					-- Leader triggers
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },

					-- Leader triggers
					{ mode = "n", keys = "<LocalLeader>" },
					{ mode = "x", keys = "<LocalLeader>" },

					-- Built-in completion
					{ mode = "i", keys = "<C-x>" },

					-- `g` key
					{ mode = "n", keys = "g" },
					{ mode = "x", keys = "g" },

					-- Marks
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },

					-- Registers
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },

					-- Window commands
					{ mode = "n", keys = "<C-w>" },

					-- `z` key
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
				},

				clues = {
					-- Enhance this by adding descriptions for <Leader> mapping groups
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
				},
			})
		end,
	},

	{
		"echasnovski/mini.comment",
		enabled = false,
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("mini.comment").setup()
		end,
	},
}
