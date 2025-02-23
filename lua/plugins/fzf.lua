return {
	{
		"ibhagwan/fzf-lua",
        enabled = false,
		keys = require("keys").fzflua(),
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf-lua").setup({
				keymap = {
					fzf = {
						["ctrl-q"] = "select-all+accept",
					},
				},
			})
		end,
	},
}
