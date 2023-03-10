local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
	return
end

local options = {
	ensure_installed = {
		"c",
		"cpp",
		"cmake",
		"lua",
		"bash",
		"css",
		"html",
		"dockerfile",
		"java",
		"javascript",
		"json",
		"markdown",
        "markdown_inline",
		"meson",
		"ninja",
		"php",
		"python",
		"r",
		"rasi",
		"regex",
		"rust",
		"ruby",
		"sql",
		"toml",
		"yaml",
		"vue",
		"typescript",
		"gitignore",
		"go",
		"latex",
		"scss",
		"nix",
		"query",
        "yuck"
	},

	highlight = {
		enable = true,
		use_languagetree = true,
	},
}

treesitter.setup(options)
