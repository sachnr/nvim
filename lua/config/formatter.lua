local present, formatter = pcall(require, "formatter")
if not present then
	return
end

local util = require("formatter.util")

local filetypes = {
	css = require("formatter.filetypes.css").prettier,
	html = require("formatter.filetypes.html").prettier,
	scss = {
		function()
			return {
				exe = "prettier",
				args = {
					"--stdin-filepath",
					util.escape_path(util.get_current_buffer_file_path()),
					"--parser",
					"scss",
				},
				stdin = true,
				try_node_modules = true,
			}
		end,
	},
	yaml = require("formatter.filetypes.yaml").prettier,
	markdown = require("formatter.filetypes.markdown").prettier,
	json = require("formatter.filetypes.json").jq,
	jsonc = require("formatter.filetypes.json").jq,
	typescriptreact = require("formatter.filetypes.typescriptreact").prettier,
	typescript = require("formatter.filetypes.typescript").prettier,
	javascript = require("formatter.filetypes.javascript").prettier,
	javascriptreact = require("formatter.filetypes.javascriptreact").prettier,
	java = {
		function()
			return {
				exe = "astyle",
				args = { "--mode=" .. "java" },
				stdin = true,
			}
		end,
	},
	c = require("formatter.filetypes.c").astyle,
	cpp = require("formatter.filetypes.cpp").astyle,
	cs = require("formatter.filetypes.cs").astyle,
	lua = require("formatter.filetypes.lua").stylua,
	sh = require("formatter.filetypes.sh").shfmt,
	python = require("formatter.filetypes.python").black,
	nix = require("formatter.filetypes.nix").alejandra,
	rust = require("formatter.filetypes.rust").rustfmt,
}

formatter.setup({
	logging = true,
	filetype = filetypes,
})
