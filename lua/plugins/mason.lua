return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		config = function()
			local mason = require("mason")
			local options = {
				ensure_installed = {
					-- Language Servers
					"tailwindcss-language-server",
					-- "lua-language-server",
					-- "python-lsp-server",
					-- "clangd",
					-- "jdtls",
					-- "html-lsp",
					-- "json-lsp",
					-- "efm",
					-- "eslint",
					-- "eslint_d",
					-- "vue-language-server",
					-- "css-lsp",
					-- "bash-language-server",
					-- "sqlls",
					-- "gopls",

					-- Formatters
					-- "black",
					-- "stylua",
					-- "shfmt",

					-- debuggers
					-- "cpptools",
				},

				-- - "prepend" (default, Mason's bin location is put first in PATH)
				-- - "append" (Mason's bin location is put at the end of PATH)
				-- - "skip" (doesn't modify PATH)
				PATH = "append",

				ui = {
					keymaps = {
						toggle_server_expand = "<CR>",
						install_server = "i",
						update_server = "u",
						check_server_version = "c",
						update_all_servers = "U",
						check_outdated_servers = "C",
						uninstall_server = "X",
						cancel_installation = "<C-c>",
					},
				},

				max_concurrent_installers = 10,
			}

			vim.api.nvim_create_user_command("MasonUpdate", function()
				vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
			end, {})

			mason.setup(options)
		end,
	},
}
