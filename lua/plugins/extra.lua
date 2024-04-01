return {
	{
		"eandrju/cellular-automaton.nvim",
		event = "VeryLazy",
		config = function()
			local config = {
				fps = 30,
				name = "slide",
			}
			config.update = function(grid)
				for i = 1, #grid do
					local prev = grid[i][#grid[i]]
					for j = 1, #grid[i] do
						grid[i][j], prev = prev, grid[i][j]
					end
				end
				return true
			end
			require("cellular-automaton").register_animation(config)
		end,
	},
}
