local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- load packer init options
local init_options = {
	auto_clean = true,
	compile_on_sync = true,
	git = { clone_timeout = 6000 },
	display = {
		working_sym = "ﲊ",
		error_sym = "✗ ",
		done_sym = " ",
		removed_sym = " ",
		moved_sym = "",
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
}

packer.init(init_options)

local use = packer.use

use({
	"nvim-lua/plenary.nvim",
	module = "plenary",
})

use("lewis6991/impatient.nvim")

use({
	"wbthomason/packer.nvim",
	cmd = require("core.lazy_load").packer_cmds,
	config = function()
		require("core.plugins")
	end,
})

use({
	"sachnr/base46",
	config = function()
		local ok, base46 = pcall(require, "base46")
		if ok then
			base46.load_theme()
		end
	end,
})

use({
	"akinsho/bufferline.nvim",
	requires = "nvim-tree/nvim-web-devicons",
	config = function()
		require("core.config.bufferline")
	end,
})

use("famiu/bufdelete.nvim")

use({
	"feline-nvim/feline.nvim",
	config = function()
		require("core.config.feline")
	end,
})

-- use({
-- 	"akinsho/toggleterm.nvim",
-- 	config = function()
-- 		require("base46").load_term_colors()
-- 		require("toggleterm").setup({})
-- 	end,
-- })

use({
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("core.config.devicons")
	end,
})

use({
	"lukas-reineke/indent-blankline.nvim",
	opt = true,
	setup = function()
		require("core.lazy_load").on_file_open("indent-blankline.nvim")
	end,
	config = function()
		require("core.config.indent-blankline")
	end,
})

use({
	"NvChad/nvim-colorizer.lua",
	opt = true,
	setup = function()
		require("core.lazy_load").on_file_open("nvim-colorizer.lua")
	end,
	config = function()
		require("core.config.colorizer")
	end,
})

use({
	"nvim-treesitter/nvim-treesitter",
	module = "nvim-treesitter",
	setup = function()
		require("core.lazy_load").on_file_open("nvim-treesitter")
	end,
	cmd = require("core.lazy_load").treesitter_cmds,
	run = ":TSUpdate",
	config = function()
		require("core.config.treesitter")
	end,
})

use({
	"nvim-treesitter/nvim-treesitter-context",
	after = "nvim-treesitter",
	config = function()
		require("treesitter-context").setup()
	end,
})

use({
	"lewis6991/gitsigns.nvim",
	setup = function()
		require("core.lazy_load").on_file_open("gitsigns.nvim")
	end,
	config = function()
		require("core.config.gitsigns")
		require("scrollbar.handlers.gitsigns").setup()
	end,
})

use({
	"williamboman/mason.nvim",
	config = function()
		require("core.config.mason")
	end,
})

use({
	"neovim/nvim-lspconfig",
	opt = true,
	setup = function()
		require("core.lazy_load").on_file_open("nvim-lspconfig")
	end,
	config = function()
		require("core.config.lsp")
	end,
})

use({ "rafamadriz/friendly-snippets", module = { "cmp", "cmp_nvim_lsp" }, event = "InsertEnter" })

use({
	"hrsh7th/nvim-cmp",
	after = "friendly-snippets",
	config = function()
		require("core.config.cmp")
	end,
})

use({
	"L3MON4D3/LuaSnip",
	wants = "friendly-snippets",
	after = "nvim-cmp",
	config = function()
		require("core.config.luasnip")
	end,
})

use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })
use({ "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" })
use({ "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" })
use({ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" })
use({ "hrsh7th/cmp-path", after = "cmp-buffer" })

use({
	"windwp/nvim-autopairs",
	after = "nvim-cmp",
	config = function()
		require("core.config.autopair")
	end,
})

-- use({
-- 	"RRethy/vim-illuminate",
-- 	after = "nvim-autopairs",
-- 	config = function()
-- 		require("core.config.illuminate")
-- 	end,
-- })

-- formatter
use({
	"mhartington/formatter.nvim",
	after = "nvim-lspconfig",
	config = function()
		require("formatter").setup({
			logging = true,
			filetype = require("core.config.formatter").filetypes,
		})
	end,
})

use({
	"goolord/alpha-nvim",
	config = function()
		require("core.config.alpha")
	end,
})

use({
	"numToStr/Comment.nvim",
	module = "Comment",
	keys = { "gc", "gb" },
	config = function()
		require("Comment").setup()
	end,
})

-- file managing , picker etc
use({
	"nvim-tree/nvim-tree.lua",
	ft = "alpha",
	cmd = { "NvimTreeToggle", "NvimTreeFocus" },
	config = function()
		require("core.config.nvimtree")
	end,
})

use({
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	requires = {
		{ "nvim-lua/plenary.nvim" },
	},
	config = function()
		require("core.config.telescope")
	end,
})

use({ "ghassan0/telescope-glyph.nvim" })
use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
use({ "nvim-telescope/telescope-ui-select.nvim" })
use({ "nvim-telescope/telescope-dap.nvim" })

use({
	"windwp/nvim-ts-autotag",
	ft = { "html", "javascriptreact" },
	after = "nvim-treesitter",
	config = function()
		local present, autotag = pcall(require, "nvim-ts-autotag")

		if present then
			autotag.setup()
		end
	end,
})

use({
	"folke/which-key.nvim",
	config = function()
		require("core.config.whichkey")
	end,
})

use({
	"kevinhwang91/nvim-hlslens",
	config = function()
		require("core.config.hlslens")
	end,
})

use({
	"petertriho/nvim-scrollbar",
	config = function()
		require("core.config.scrollbar")
	end,
})

use({
	"folke/trouble.nvim",
	requires = "kyazdani42/nvim-web-devicons",
	config = function()
		require("trouble").setup({})
	end,
})

use({
	"ahmedkhalf/project.nvim",
	after = "telescope.nvim",
	config = function()
		require("project_nvim").setup({
			patterns = {
				".git",
				"Makefile",
				"build/env.sh",
				"pom.xml",
				"rc.lua",
			},
			silent_chdir = false,
		})
		require("telescope").load_extension("projects")
	end,
})

use({
	"iamcco/markdown-preview.nvim",
	run = function()
		vim.fn["mkdp#util#install"]()
	end,
})

use({
	"mfussenegger/nvim-dap",
	config = function()
		require("core.config.dap").dap()
	end,
})

use({
	"rcarriga/nvim-dap-ui",
	requires = {
		{ "mfussenegger/nvim-dap" },
		{ "theHamsta/nvim-dap-virtual-text" },
	},
	config = function()
		require("core.config.dap").dapui()
	end,
})

-- nvim jdtls
use({
	"mfussenegger/nvim-jdtls",
	opt = true,
	setup = function()
		require("core.lazy_load").on_file_open("nvim-jdtls")
	end,
	disable = false,
})

--transparency
use({
	"xiyaowong/nvim-transparent",
	config = function()
		require("transparent").setup({
			enable = true, -- boolean: enable transparent
		})
	end,
})

use("LudoPinelli/comment-box.nvim")

-- browser sync
use({
	"ray-x/web-tools.nvim",
	event = "VimEnter",
	config = function()
		require("web-tools").setup({})
	end,
})

-- use({
-- 	"alexghergh/nvim-tmux-navigation",
-- 	config = function()
-- 		require("nvim-tmux-navigation").setup({
-- 			disable_when_zoomed = false, -- defaults to false
-- 			keybindings = {
-- 				left = "<C-h>",
-- 				down = "<C-j>",
-- 				up = "<C-k>",
-- 				right = "<C-l>",
-- 			},
-- 		})
-- 	end,
-- })

use({
	"beauwilliams/focus.nvim",
	cmd = require("core.lazy_load").focus_cmds,
	module = "focus",
	config = function()
		require("focus").setup({ enable = true, hybridnumber = true, excluded_filetypes = { "toggleterm" } })
	end,
})
