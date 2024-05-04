return {
	{
		"github/copilot.vim",
		lazy = false,
		init = function()
			vim.g.copilot_no_tab_map = true

			vim.keymap.set("i", "<M-Tab>", 'copilot#Accept("")', {
				expr = true,
				replace_keycodes = false,
			})
		end,
	},

	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("copilot").setup({
	-- 			suggestion = { enabled = true },
	-- 			panel = { enabled = true },
	-- 		})
	-- 	end,
	-- },

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		lazy = false,
		keys = {
			{
				"<leader>th",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.fzflua").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
		},
		dependencies = {
			{ "github/copilot.vim" },
			-- { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		opts = {
			mappings = {
				complete = {
					detail = "",
					insert = "",
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
