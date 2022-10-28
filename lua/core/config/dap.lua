local M = {}

M.dap = function()
	local dap_status_ok, dap = pcall(require, "dap")
	if not dap_status_ok then
		return
	end

	require("base46").load_highlight("dapui")

	local plugin_folder = vim.fn.stdpath("data")
	local mason = plugin_folder .. "/mason/packages"

	-- JavaScript, typescript
	dap.adapters.firefox = {
		type = "executable",
		command = "node",
		args = { mason .. "/firefox-debug-adapter/dist/adapter.bundle.js" },
	}

	dap.configurations.typescript = {
		name = "Debug with Firefox",
		type = "firefox",
		request = "launch",
		reAttach = true,
		url = "http://localhost:3000",
		webRoot = "${workspaceFolder}",
		firefoxExecutable = "/usr/bin/firefox",
	}

	-- C, CPP, Rust
	dap.adapters.cppdbg = {
		id = "cppdbg",
		type = "executable",
		command = mason .. "/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
	}

	dap.configurations.cpp = {
		{
			name = "Launch file",
			type = "cppdbg",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopAtEntry = true,
		},
		{
			name = "Attach to gdbserver :1234",
			type = "cppdbg",
			request = "launch",
			MIMode = "gdb",
			miDebuggerServerAddress = "localhost:1234",
			miDebuggerPath = "/usr/bin/gdb",
			cwd = "${workspaceFolder}",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
		},
	}
	dap.configurations.c = dap.configurations.cpp
	dap.configurations.rust = dap.configurations.cpp

	-- python
	dap.adapters.python = {
		type = "executable",
		command = mason .. "/debugpy/venv/bin/python",
		args = { "-m", "debugpy.adapter" },
	}
	dap.configurations.python = {
		{
			-- The first three options are required by nvim-dap
			type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
			request = "launch",
			name = "Launch file",

			-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

			program = "${file}", -- This configuration will launch the current file if used.
			pythonPath = function()
				-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
				-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
				-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
				local cwd = vim.fn.getcwd()
				if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
					return cwd .. "/venv/bin/python"
				elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
					return cwd .. "/.venv/bin/python"
				else
					return "/usr/bin/python"
				end
			end,
		},
	}

	-- lua
	-- dap.configurations.lua = {
	--   {
	--     type = "nlua",
	--     request = "attach",
	--     name = "Attach to running Neovim instance",
	--   },
	-- }
	--
	-- dap.adapters.nlua = function(callback, config)
	--   callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
	-- end

	--golang
	dap.adapters.go = {
		type = "executable",
		command = "node",
		args = { mason .. "/go-debug-adapter/extension/dist/debugAdapter.js" },
	}
	dap.configurations.go = {
		{
			type = "go",
			name = "Debug",
			request = "launch",
			showLog = false,
			program = "${file}",
			dlvToolPath = mason .. "/delve/dlv", -- Adjust to where delve is installed
		},
	}
end

M.dapvt = function()
	local status_ok, dapvt = pcall(require, "nvim-dap-virtual-text")
	if not status_ok then
		return
	end

	dapvt.setup({
		enabled = true, -- enable this plugin (the default)
		enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
		highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
		highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
		show_stop_reason = true, -- show stop reason when stopped for exceptions
		commented = false, -- prefix virtual text with comment string
		only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
		all_references = false, -- show virtual text on all all references of the variable (not only definitions)
		filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
		-- dapuiexperimental features:
		virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
		all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
		virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
		virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
		-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
	})
end

M.dapui = function()
	local dap_ui_status_ok, dapui = pcall(require, "dapui")
	if not dap_ui_status_ok then
		return
	end

	dapui.setup({
		expand_lines = true,
		icons = { expanded = "", collapsed = "", circular = " " },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		layouts = {
			{
				elements = {
					{ id = "scopes", size = 0.30 },
					{ id = "breakpoints", size = 0.20 },
					{ id = "stacks", size = 0.25 },
					{ id = "watches", size = 0.25 },
				},
				size = 0.25,
				position = "right",
			},
			{
				elements = {
					{ id = "repl", size = 0.35 },
					{ id = "console", size = 0.40 },
				},
				size = 0.25,
				position = "bottom",
			},
		},
		floating = {
			max_height = 0.9,
			max_width = 0.5, -- Floats will be treated as percentage of your screen.
			border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
	})
end

return M
