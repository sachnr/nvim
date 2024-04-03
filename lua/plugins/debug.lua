---@diagnostic disable: missing-fields
return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		keys = {
			{ "<F5>", ":lua require('dap').continue()<CR>", { silent = true, desc = "continue" } },
			{ "<F7>", ":lua require('dap').step_over()<CR>", { silent = true } },
			{ "<F8>", ":lua require('dap').step_into()<CR>", { silent = true } },
			{ "<F9>", ":lua require('dap').step_out()<CR>", { silent = true } },
			{ "<leader>db", ":lua require('dap').toggle_breakpoint()<CR>", { silent = true } },
			{ "<leader>dr", ":lua require('dap').repl.open()<CR>", { silent = true } },
			{ "<leader>dR", ":lua require('dap').run_last()<CR>", { silent = true } },
			{ "<F6>", ":lua require('dap').terminate()<CR>", { silent = true } },
			{ "<leader>du", ":lua require('dapui').toggle()<CR>", { silent = true } },
			{ "<leader>dK", ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },
		},
		config = function()
			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

			local dap = require("dap")

			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}
			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = os.getenv("HOME") .. "/links/cpp_debug",
			}

			dap.configurations.zig = {
				{
					name = "(gdb) launch",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
			}
			dap.configurations.cpp = {
				{
					name = "cpp c Debug",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
				},
			}
			dap.configurations.rust = {
				{
					name = "gdb",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug", "file")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = true,
				},
			}

			dap.configurations.c = dap.configurations.cpp
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.35 },
							{ id = "breakpoints", size = 0.15 },
							{ id = "stacks", size = 0.20 },
							{ id = "watches", size = 0.30 },
						},
						position = "left",
						size = 40,
					},
					{ elements = { { id = "repl", size = 1 } }, position = "right", size = 40 },
				},
			})
		end,
	},

	{
		"mxsdev/nvim-dap-vscode-js",
		enabled = false,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node" }, -- which adapters to register in nvim-dap
			})
		end,
		dependencies = {
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps && npm run compile",
			},
		},
	},

	{
		"mfussenegger/nvim-jdtls",
		enabled = false,
	},
}
