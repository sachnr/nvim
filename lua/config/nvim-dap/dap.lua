local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

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

-- C, CPP, Rust
-- dap.adapters.cppdbg = {
-- 	id = "cppdbg",
-- 	type = "executable",
-- 	command = mason .. "/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
-- }
--
-- dap.configurations.cpp = {
-- 	{
-- 		name = "Launch file",
-- 		type = "cppdbg",
-- 		request = "launch",
-- 		program = function()
-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
-- 		end,
-- 		cwd = "${workspaceFolder}",
-- 		stopAtEntry = true,
-- 	},
-- 	{
-- 		name = "Attach to gdbserver :1234",
-- 		type = "cppdbg",
-- 		request = "launch",
-- 		MIMode = "gdb",
-- 		miDebuggerServerAddress = "localhost:1234",
-- 		miDebuggerPath = "/usr/bin/gdb",
-- 		cwd = "${workspaceFolder}",
-- 		program = function()
-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
-- 		end,
-- 	},
-- }
-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp

-- python
-- dap.adapters.python = {
-- 	type = "executable",
-- 	command = mason .. "/debugpy/venv/bin/python",
-- 	args = { "-m", "debugpy.adapter" },
-- }
-- dap.configurations.python = {
-- 	{
-- 		-- The first three options are required by nvim-dap
-- 		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
-- 		request = "launch",
-- 		name = "Launch file",
--
-- 		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--
-- 		program = "${file}", -- This configuration will launch the current file if used.
-- 		pythonPath = function()
-- 			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
-- 			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
-- 			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
-- 			local cwd = vim.fn.getcwd()
-- 			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
-- 				return cwd .. "/venv/bin/python"
-- 			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
-- 				return cwd .. "/.venv/bin/python"
-- 			else
-- 				return "/usr/bin/python"
-- 			end
-- 		end,
-- 	},
-- }

-- lua
dap.configurations.lua = {
	{
		type = "nlua",
		request = "attach",
		name = "Attach to running Neovim instance",
	},
}

dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

--golang
-- dap.adapters.go = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { mason .. "/go-debug-adapter/extension/dist/debugAdapter.js" },
-- }
-- dap.configurations.go = {
-- 	{
-- 		type = "go",
-- 		name = "Debug",
-- 		request = "launch",
-- 		showLog = false,
-- 		program = "${file}",
-- 		dlvToolPath = mason .. "/delve/dlv", -- Adjust to where delve is installed
-- 	},
-- }
