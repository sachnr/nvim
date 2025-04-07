return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		config = function()
			local mason = require("mason")
			local options = {
				ensure_installed = {
					"tailwindcss-language-server",
				},
				PATH = "prepend",
				max_concurrent_installers = 10,
			}
			mason.setup(options)
		end,
	},
}
