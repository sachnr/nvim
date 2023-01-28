local present, blankline = pcall(require, "indent_blankline")

if not present then
	return
end

local options = {
	char = "▎",
	use_treesitter = true,
	filetype_exclude = {
		"help",
		"terminal",
		"alpha",
		"packer",
		"lspinfo",
		"TelescopePrompt",
		"TelescopeResults",
		"mason",
		"",
	},
	buftype_exclude = { "terminal" },
	show_first_indent_level = false,
	show_current_context = true,
}

blankline.setup(options)
