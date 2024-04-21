return {
	-- {
	-- 	"github/copilot.vim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		vim.keymap.set("i", "<C-y>", 'copilot#Accept("\\<CR>")', {
	-- 			expr = true,
	-- 			replace_keycodes = false,
	-- 		})
	-- 		vim.g.copilot_no_tab_map = true
	-- 	end,
	-- },

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		lazy = false,
		keys = { { "<Leader>tc", mode = "n", "<cmd> CopilotChat <CR>", desc = "Copilot Chat" } },
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			mappings = {
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<Tab>",
				},
				close = {
					normal = "q",
					insert = "",
				},
				reset = {
					normal = "<C-l>",
					insert = "",
				},
				submit_prompt = {
					normal = "<C-y>",
					insert = "<C-y>",
				},
				accept_diff = {
					normal = "ga",
					insert = "",
				},
				yank_diff = {
					normal = "gy",
				},
				show_diff = {
					normal = "gd",
				},
				show_system_prompt = {
					normal = "gp",
				},
				show_user_selection = {
					normal = "gs",
				},
			},
			debug = true,
		},
	},
}
