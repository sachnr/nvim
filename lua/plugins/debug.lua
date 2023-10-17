return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		config = function()
			local dap = require("dap")
			local plugin_folder = vim.fn.stdpath("data")
			local mason = plugin_folder .. "/mason/packages"

			dap.adapters.go = {
				type = "executable",
				command = "node",
				args = {
					os.getenv("HOME")
						.. "/.local/share/nvim/mason/packages/go-debug-adapter/extension/dist/debugAdapter.js",
				},
			}
			dap.configurations.go = {
				{
					type = "go",
					name = "Debug",
					request = "launch",
					showLog = false,
					program = "${file}",
					dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
				},
			}

			dap.adapters.lldb = {
				type = "executable",
				command = "/etc/profiles/per-user/sachnr/bin/lldb-vscode", -- adjust as needed, must be absolute path
				name = "lldb",
			}
			dap.configurations.rust = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},

					-- 💀
					-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
					--
					--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--
					-- Otherwise you might get the following error:
					--
					--    Error on launch: Failed to attach to the target process
					--
					-- But you should be aware of the implications:
					-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
					-- runInTerminal = false,
				},
			}
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
					---@diagnostic disable-next-line: missing-fields
					require("dap-vscode-js").setup({
						debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
						adapters = { "pwa-node" }, -- which adapters to register in nvim-dap
					})
				end,
			},
		},
	},

    "mfussenegger/nvim-jdtls",

	{
		"microsoft/vscode-js-debug",
        enabled = false,
		build = "npm install --legacy-peer-deps && npm run compile",
	},
}
