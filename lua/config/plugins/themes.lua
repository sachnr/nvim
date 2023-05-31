return {
	{
		dir = "~/Downloads/base46/",
		enabled = true,
		lazy = false,
		priority = 1000,
		opts = {
			bold = true,
      simple_lualine = true,
			underline = true,
	},
	},

	{ "sainnhe/gruvbox-material", enabled = false, lazy = false, priority = 1000 },

	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				bold_vert_split = true,
				disable_italics = true,
				highlight_groups = {
					-- indent blankline
					IndentBlanklineChar = { fg = "surface" },
					IndentBlanklineSpaceChar = { fg = "surface" },
					IndentBlanklineSpaceCharBlankline = { fg = "surface" },

					-- Neotree
					NeoTreeBufferNumber = { fg = "muted" },
					NeoTreeCursorLine = { bg = "overlay" },
					NeoTreeDimText = { fg = "subtle" },
					NeoTreeDirectoryIcon = { fg = "rose" },
					NeoTreeDirectoryName = { fg = "rose" },
					NeoTreeDotfile = { fg = "muted", italic = true },
					NeoTreeFileIcon = { fg = "rose" },
					NeoTreeFileName = { fg = "text" },
					NeoTreeFileNameOpened = { fg = "text" },
					NeoTreeFilterTerm = { fg = "text" },
					NeoTreeFloatBorder = { link = "FloatNormal" },
					NeoTreeFloatTitle = { fg = "text ", bold = true },
					NeoTreeTitleBar = { bg = "nc" },
					NeoTreeGitAdded = { fg = "text" },
					NeoTreeGitConflict = { fg = "love" },
					NeoTreeGitDeleted = { fg = "love", blend = 10 },
					NeoTreeGitIgnored = { fg = "subtle", blend = 10 },
					NeoTreeGitModified = { fg = "gold", blend = 10 },
					NeoTreeGitUnstaged = { fg = "gold" },
					NeoTreeGitUntracked = { fg = "text" },
					NeoTreeGitStaged = { fg = "text" },
					NeoTreeHiddenByName = { fg = "overlay", italic = true },
					NeoTreeIndentMarker = { fg = "surface" },
					NeoTreeExpander = { fg = "rose" },
					NeoTreeNormal = { bg = "nc" },
					NeoTreeNormalNC = { bg = "nc" },
					NeoTreeSignColumn = { link = "SignColumn" },
					NeoTreeStatusLine = { bg = "nc" },
					NeoTreeStatusLineNC = { bg = "nc" },
					NeoTreeVertSplit = { fg = "surface" },
					NeoTreeWinSeparator = { fg = "surface", bg = "nc" },
					NeoTreeEndOfBuffer = { fg = "text" },
					NeoTreeRootName = { fg = "text", bold = true, italic = false },
					NeoTreeSymbolicLinkTarget = { fg = "foam", italic = true },
					NeoTreeWindowsHidden = { fg = "muted" },
					NeoTreeTabActive = { fg = "text", bg = "base", bold = true },
					NeoTreeTabInactive = { fg = "muted", bg = "base" },
					NeoTreeTabSeparatorInactive = { fg = "base", bg = "base" },
					NeoTreeTabSeparatorActive = { fg = "base", bg = "base" },
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
