local theme = require("kanagawa.colors").setup().theme

local kanagawa = {}

kanagawa.normal = {
	a = { bg = theme.ui.bg_p1, fg = theme.syn.fun, gui = "bold" },
	b = { bg = theme.ui.bg_p1, fg = theme.syn.fun },
	c = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
}

kanagawa.insert = {
	a = { bg = theme.ui.bg_p1, fg = theme.diag.ok, gui = "bold" },
	b = { bg = theme.ui.bg_p1, fg = theme.diag.ok },
}

kanagawa.command = {
	a = { bg = theme.ui.bg_p1, fg = theme.syn.operator, gui = "bold" },
	b = { bg = theme.ui.bg_p1, fg = theme.syn.operator },
}

kanagawa.visual = {
	a = { bg = theme.ui.bg_p1, fg = theme.syn.keyword, gui = "bold" },
	b = { bg = theme.ui.bg_p1, fg = theme.syn.keyword },
}

kanagawa.replace = {
	a = { bg = theme.ui.bg_p1, fg = theme.syn.constant, gui = "bold" },
	b = { bg = theme.ui.bg_p1, fg = theme.syn.constant },
}

kanagawa.inactive = {
	a = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim, gui = "bold" },
	b = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim, gui = "bold" },
	c = { bg = theme.ui.bg_p1, fg = theme.ui.fg_dim },
}
  return kanagawa

