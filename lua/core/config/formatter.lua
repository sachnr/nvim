local present, formatter = pcall(require, "formatter")
if not present then
	return
end

local util = require("formatter.util")

local M = {}

M.prettier = function(parser)
	if not parser then
		return {
			exe = "prettier",
			args = {
				"--stdin-filepath",
				util.escape_path(util.get_current_buffer_file_path()),
			},
			stdin = true,
			try_node_modules = true,
		}
	end

	return {
		exe = "prettier",
		args = {
			"--stdin-filepath",
			util.escape_path(util.get_current_buffer_file_path()),
			"--parser",
			parser,
		},
		stdin = true,
		try_node_modules = true,
	}
end

M.astyle = function(mode)
	return {
		exe = "astyle",
		args = { "--mode=" .. mode },
		stdin = true,
	}
end

M.stylua = function()
	return {
		exe = "stylua",
		args = {
			"--search-parent-directories",
			"--stdin-filepath",
			util.escape_path(util.get_current_buffer_file_path()),
			"--",
			"-",
		},
		stdin = true,
	}
end

M.shfmt = function()
	local shiftwidth = vim.opt.shiftwidth:get()
	local expandtab = vim.opt.expandtab:get()

	if not expandtab then
		shiftwidth = 0
	end

	return {
		exe = "shfmt",
		args = { "-i", shiftwidth },
		stdin = true,
	}
end

M.black = function()
	return {
		exe = "black",
		args = { "-q", "-" },
		stdin = true,
	}
end

M.eslintd = function()
	return {
		exe = "eslint_d",
		args = {
			"--stdin",
			"--stdin-filename",
			util.escape_path(util.get_current_buffer_file_path()),
			"--fix-to-stdout",
		},
		stdin = true,
		try_node_modules = true,
	}
end

M.alejandra = function()
	return {
		exe = "alejandra",
		stdin = true,
		args = { "--quiet" },
	}
end

M.filetypes = {
	css = M.prettier("css"),
	html = M.prettier("html"),
	scss = M.prettier("scss"),
	yaml = M.prettier("yaml"),
	markdown = M.prettier("markdown"),
	typescriptreact = M.prettier("typescript"),
	typescript = M.prettier("typescript"),
	javascript = M.eslintd,
	javascriptreact = M.eslintd,
	json = M.prettier("json"),
	jsonc = M.prettier("json5"),
	java = M.astyle("java"),
	c = M.astyle("c"),
	cpp = M.astyle("cpp"),
	cs = M.astyle("cs"),
	lua = M.stylua,
	sh = M.shfmt,
	python = M.black,
	nix = M.alejandra,
}

return M
