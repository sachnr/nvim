return {
	{
		"folke/which-key.nvim",
		-- keys = { "<leader>", '"', "'", "`", "@" },
        enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			local wk = require("which-key")
			local keys = require("keys")

			local options = {
				window = {
					border = "single", -- none, single, double, shadow
				},
			}

			-- Normal mode Mappings

			local opts = {
				mode = "n", -- NORMAL mode
				prefix = "<leader>",
				buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = true, -- use `nowait` when creating keymaps
			}

			-- Visual mode Mappings
			local vopts = {
				mode = "v", -- NORMAL mode
				prefix = "<leader>",
				buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = true, -- use `nowait` when creating keymaps
			}

			local mappings = keys.whichKey_n
			local vmappings = keys.whichKey_v

			wk.setup(options)
			wk.register(mappings, opts)
			wk.register(vmappings, vopts)
		end,
	},
}
