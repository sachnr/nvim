local function run_clang()
	local filepath = vim.fn.expand("%")
	require("plenary.job")
		:new({
			command = "clang",
			args = { "-S", "-march=x86-64", "-x", "c", "-O0", "-o", "-", filepath },
			on_exit = function(job, code, _)
				if code == 0 then
					vim.schedule(function()
						local buf = vim.api.nvim_create_buf(false, true)
						vim.api.nvim_buf_set_lines(buf, 0, -1, true, job:result())
						vim.bo[buf].ft = "asm"
						vim.bo[buf].modifiable = false
						vim.api.nvim_buf_set_keymap(buf, "n", "q", ":bdelete <CR>", { silent = true, noremap = true })
						vim.cmd("topleft vsplit | buffer " .. buf)
					end)
				else
					print("Compile Failed")
				end
			end,
		})
		:start()
end

vim.api.nvim_create_user_command("GenerateAssembly", function()
	run_clang()
end, { nargs = 0 })

local function BuildAndDebug()
	local cwd = vim.fn.getcwd()
	local job = require("plenary.job")
	local dap = require("dap")

	local cmake = job:new({
		command = "cmake",
		args = { "-S", cwd, "-B", "build" },
		on_start = function()
			vim.notify("Compiling a debug build for debugging. This might take some time...")
		end,
	})

	local dap_config = {
		name = "cpp c Debug",
		type = "cppdbg",
		request = "launch",
		program = "${workspaceFolder}/build/debug/target",
		cwd = "${workspaceFolder}",
		stopAtEntry = false,
	}

	local build = job:new({
		command = "cmake",
		args = { "--build", "build" },
		on_exit = function(_, code, _)
			if code == 0 then
				print("Compilation Successful running debugger")
				vim.schedule(function()
					dap.run(dap_config)
				end)
			else
				print("Compilation Error")
			end
		end,
	})

	cmake:and_then_on_success(build)
	cmake:start()
end

vim.api.nvim_create_user_command("DebugWithGdb", function()
	BuildAndDebug()
end, { nargs = 0 })
