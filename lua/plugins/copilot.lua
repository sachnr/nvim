return {
	-- {
	-- 	"github/copilot.vim",
	-- 	lazy = false,
	-- 	init = function()
	-- 		vim.g.copilot_no_tab_map = true
	--
	-- 		vim.keymap.set("i", "<M-Tab>", 'copilot#Accept("")', {
	-- 			expr = true,
	-- 			replace_keycodes = false,
	-- 		})
	-- 	end,
	-- },

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		enabled = true,
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = false,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<M-Tab>",
						accept_word = "<M-Right>",
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				panel = { enabled = false },
			})
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		enabled = true,
		cmd = {
			"CopilotChat",
			"CopilotChatBuffer",
			"CopilotChatSave",
			"CopilotChatLoad",
			"CopilotChatReset",
		},
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
			-- { "github/copilot.vim" },
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		config = function()
			require("CopilotChat").setup({
				-- model = "gpt-4",
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
			})

			vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
				require("CopilotChat").ask(args.args, { selection = require("CopilotChat.select").buffer })
			end, { nargs = "*", range = true })

			local commands = {
				"CopilotChatClose",
				"CopilotChatCommit",
				"CopilotChatCommitStaged",
				"CopilotChatDebugInfo",
				"CopilotChatFix",
				"CopilotChatExplain",
				"CopilotChatDocs",
				"CopilotChatOptimize",
				"CopilotChatOpen",
				"CopilotChatTests",
				"CopilotChatToggle",
				"CopilotChatFixDiagnostic",
				"CopilotChatReview",
			}

			for _, command in ipairs(commands) do
				vim.api.nvim_del_user_command(command)
			end
		end,
	},
}
