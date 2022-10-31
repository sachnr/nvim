local line_ok, feline = pcall(require, "feline")
if not line_ok then
	return
end

local ok, base46 = pcall(require, "base46")
if not ok then
	return
end

local colors = base46.get_theme_tb("base_30")

local base46_theme = {
	white = colors.white,
	darker_black = colors.darker_black,
	black = colors.black,
	bg = colors.black2,
	one_bg = colors.one_bg,
	one_bg2 = colors.one_bg2,
	one_bg3 = colors.one_bg3,
	grey = colors.grey,
	grey_fg = colors.grey_fg,
	light_grey = colors.light_grey,
	green = colors.green,
	yellow = colors.yellow,
	purple = colors.purple,
	dark_purple = colors.dark_purple,
	orange = colors.orange,
	cyan = colors.cyan,
	teal = colors.teal,
	blue = colors.blue,
	nord_blue = colors.nord_blue,
	red = colors.red,
}

local mode_alias = {
	["n"] = "NORMAL",
	["no"] = "N-PENDING",
	["nov"] = "N-PENDING",
	["noV"] = "N-PENDING",
	["no"] = "N-PENDING",
	["niI"] = "NORMAL",
	["niR"] = "NORMAL",
	["niV"] = "NORMAL",
	["v"] = "VISUAL",
	["vs"] = "VISUAL",
	["V"] = "V-LINE",
	["Vs"] = "V-LINE",
	[""] = "V-BLOCK",
	["s"] = "V-BLOCK",
	["s"] = "SELECT",
	["S"] = "S-LINE",
	[""] = "S-BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["ix"] = "INSERT",
	["R"] = "REPLACE",
	["Rc"] = "REPLACE",
	["Rv"] = "V-REPLACE",
	["Rx"] = "REPLACE",
	["c"] = "COMMAND",
	["cv"] = "COMMAND",
	["ce"] = "COMMAND",
	["r"] = "PROMPT",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
	["nt"] = "N-TERMINAL",
	["null"] = "NONE",
}

local vi_mode_colors = {
	NORMAL = "blue",
	INSERT = "dark_purple",
	VISUAL = "cyan",
	OP = "blue",
	BLOCK = "blue",
	REPLACE = "orange",
	["V-REPLACE"] = "orange",
	ENTER = "teal",
	MORE = "teal",
	SELECT = "nordblue",
	COMMAND = "green",
	SHELL = "green",
	TERM = "green",
	NONE = "red",
}

local provider = {
	-- 1
	vim_mode = {
		provider = function()
			local current_text = " " .. mode_alias[vim.fn.mode()] .. " "
			return current_text
		end,
		hl = function()
			return {
				fg = "black",
				bg = require("feline.providers.vi_mode").get_mode_color(),
				style = "bold",
			}
		end,
		left_sep = {
			str = "block",
			hl = function()
				return {
					fg = require("feline.providers.vi_mode").get_mode_color(),
					bg = "black",
				}
			end,
			always_visible = true,
		},
		right_sep = "slant_right_2",
	},

	gitBranch = {
		provider = "git_branch",
		hl = {
			fg = "light_grey",
			bg = "bg",
			style = "bold",
		},
		left_sep = {
			str = "██",
			hl = {
				fg = "bg",
				bg = "bg",
			},
			always_visible = true,
		},
		right_sep = "block",
	},
	gitDiffAdded = {
		provider = "git_diff_added",
		hl = {
			fg = "green",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "block",
		icon = "+",
	},
	gitDiffRemoved = {
		provider = "git_diff_removed",
		hl = {
			fg = "red",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "block",
		icon = "-",
	},
	gitDiffChanged = {
		provider = "git_diff_changed",
		hl = {
			fg = "yellow",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = {
			str = "██",
			hl = {
				fg = "bg",
				bg = "bg",
			},
			always_visible = true,
		},
		icon = "~",
	},

	fileinfo = {
		provider = {
			name = "file_info",
			opts = {
				type = "unique",
				file_modified_icon = " ",
			},
		},
		hl = {
			fg = "white",
			bg = "one_bg2",
			style = "bold",
		},
		left_sep = {
			str = "██",
			hl = {
				fg = "one_bg2",
				bg = "black",
			},
			always_visible = true,
		},
		right_sep = {
			str = "██",
			hl = {
				fg = "one_bg2",
				bg = "black",
			},
		},
		icon = " ",
	},

	separator1 = {
		provider = "",
		left_sep = {
			str = "",
			hl = {
				fg = "bg",
				bg = "bg",
			},
			always_visible = true,
		},
	},

	separator2 = {
		provider = "",
		left_sep = {
			str = "",
			hl = {
				fg = "bg",
				bg = "bg",
			},
			always_visible = true,
		},
	},

	separator3 = {
		provider = "",
		left_sep = {
			str = "",
			hl = {
				fg = "bg",
				bg = "bg",
			},
			always_visible = true,
		},
	},

	separator4 = {
		provider = "",
		left_sep = {
			str = "",
			hl = {
				fg = "bg",
				bg = "bg",
			},
			always_visible = true,
		},
	},

	diagnostic = {
		provider = "",
		left_sep = {
			str = "██",
			hl = {
				fg = "bg",
				bg = "bg",
			},
			always_visible = true,
		},
		right_sep = {
			str = " ",
			hl = {
				fg = "light_grey",
				bg = "bg",
			},
			always_visible = true,
		},
	},

	diagnostic_errors = {
		provider = "diagnostic_errors",
		hl = {
			fg = "red",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "block",
	},

	diagnostic_warnings = {
		provider = "diagnostic_warnings",
		hl = {
			fg = "yellow",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "block",
	},

	diagnostic_hints = {
		provider = "diagnostic_hints",
		hl = {
			fg = "teal",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = "block",
	},

	diagnostic_info = {
		provider = "diagnostic_info",
		hl = {
			fg = "purple",
			bg = "bg",
		},
		left_sep = "block",
		right_sep = {
			str = "██",
			hl = {
				fg = "bg",
				bg = "bg",
			},
			always_visible = true,
		},
	},

	lsp_client_names = {
		provider = "lsp_client_names",
		hl = {
			fg = "white",
			bg = "one_bg2",
			style = "bold",
		},
		left_sep = {
			str = "██",
			hl = {
				fg = "one_bg2",
				bg = "one_bg2",
			},
			always_visible = true,
		},
		right_sep = {
			str = "██",
			hl = {
				fg = "one_bg2",
				bg = "one_bg2",
			},
			always_visible = true,
		},
	},

	position = {
		provider = "position",
		hl = {
			fg = "light_grey",
			bg = "bg",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},

	line_percentage = {
		provider = "line_percentage",
		hl = {
			fg = "white",
			bg = "one_bg2",
			style = "bold",
		},
		left_sep = {
			str = "██",
			hl = {
				fg = "one_bg2",
				bg = "black",
			},
			always_visible = true,
		},
		right_sep = "block",
		icon = "  ",
	},

	scroll_bar = {
		provider = {
			name = "scroll_bar",
			reverse = false,
		},
		hl = {
			fg = "green",
			bg = "one_bg2",
			style = "bold",
		},
		left_sep = "block",
		right_sep = "block",
	},
}

local left = {
	provider.vim_mode,
	provider.gitBranch,
	provider.gitDiffAdded,
	provider.gitDiffRemoved,
	provider.gitDiffChanged,
	provider.fileinfo,
	provider.separator4,
	provider.position,
}

local middle = {}

local right = {
	provider.separator3,
	provider.lsp_client_names,
  provider.diagnostic,
	provider.diagnostic_errors,
	provider.diagnostic_warnings,
	provider.diagnostic_info,
	provider.diagnostic_hints,
	provider.line_percentage,
	provider.scroll_bar,
}

local components = {
	active = {
		left,
		middle,
		right,
	},
	inactive = {
		left,
		middle,
		right,
	},
}

feline.setup({
	components = components,
	theme = base46_theme,
	vi_mode_colors = vi_mode_colors,
	force_inactive = {
		filetypes = {
			"^NvimTree$",
			"^packer$",
			"^startify$",
			"^fugitive$",
			"^fugitive$",
			"^fugitiveblame$",
			"^qf$",
			"^help$",
		},
		buftypes = {
			"^terminal$",
		},
		bufnames = {},
	},
})
