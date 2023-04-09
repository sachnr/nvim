return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			local dap = require("dap")
			local plugin_folder = vim.fn.stdpath("data")
			local mason = plugin_folder .. "/mason/packages"

			for _, language in ipairs({ "typescript", "javascript" }) do
				dap.configurations[language] = {
					{
						{
							type = "pwa-node",
							request = "launch",
							name = "Debug Jest Tests",
							-- trace = true, -- include debugger info
							runtimeExecutable = "node",
							runtimeArgs = {
								"./node_modules/jest/bin/jest.js",
								"--runInBand",
							},
							rootPath = "${workspaceFolder}",
							cwd = "${workspaceFolder}",
							console = "integratedTerminal",
							internalConsoleOptions = "neverOpen",
						},
					},
				}
			end
		end,
		dependencies = {
			{
				"theHamsta/nvim-dap-virtual-text",
				config = true,
			},
			{
				"rcarriga/nvim-dap-ui",
				config = true,
			},
			{
				"mxsdev/nvim-dap-vscode-js",
				config = function()
					require("dap-vscode-js").setup({
						debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
						adapters = { "pwa-node" }, -- which adapters to register in nvim-dap
					})
				end,
			},
		},
	},

	{
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps && npm run compile",
	},
}
