-- Check for instalation status of plugin.
local fn = vim.fn
local plugins_path = fn.stdpath("data") .. "/site/pack/packer"

local function is_plugin_installed(plugins_name)
	if
		fn.empty(fn.glob(plugins_path .. "/start/" .. plugins_name)) > 0
		and fn.empty(fn.glob(plugins_path .. "/opt/" .. plugins_name)) > 0
	then
		return false
	else
		return true
	end
end

-- Install packer.nvim if it's not installed.
local packer_bootstrap
if not is_plugin_installed("packer.nvim") then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		plugins_path .. "/start/packer.nvim",
	})
	vim.cmd([[packadd packer.nvim]])
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

local use = packer.use
packer.reset()

return require("packer").startup({
	function()
		use({
			"nvim-lua/plenary.nvim",
			module = "plenary",
		})

		use("lewis6991/impatient.nvim")

		use({ "wbthomason/packer.nvim" })

		use({
			"sachnr/base46",
			config = function()
				require("base46").setup({ transparency = true })
			end,
		})

		use({
			"akinsho/bufferline.nvim",
			requires = "nvim-tree/nvim-web-devicons",
			config = function()
				require("config.bufferline")
			end,
		})

		use("famiu/bufdelete.nvim")

		use({
			"feline-nvim/feline.nvim",
			config = function()
				require("config.feline")
			end,
		})

		use({
			"akinsho/toggleterm.nvim",
			config = function()
				require("base46").load_term_colors()
				require("toggleterm").setup({})
			end,
		})

		use({
			"nvim-tree/nvim-web-devicons",
			config = function()
				require("config.devicons")
			end,
		})

		use({
			"lukas-reineke/indent-blankline.nvim",
			opt = true,
			setup = function()
				require("lazy_load").on_file_open("indent-blankline.nvim")
			end,
			config = function()
				require("config.indent-blankline")
			end,
		})

		use({
			"NvChad/nvim-colorizer.lua",
			opt = true,
			setup = function()
				require("lazy_load").on_file_open("nvim-colorizer.lua")
			end,
			config = function()
				require("config.colorizer")
			end,
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			module = "nvim-treesitter",
			setup = function()
				require("lazy_load").on_file_open("nvim-treesitter")
			end,
			cmd = require("lazy_load").treesitter_cmds,
			run = ":TSUpdate",
			config = function()
				require("config.treesitter")
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
				require("lazy_load").on_file_open("gitsigns.nvim")
			end,
			config = function()
				require("config.gitsigns")
			end,
		})

		use({
			"williamboman/mason.nvim",
			config = function()
				require("config.mason")
			end,
		})

		use({
			"neovim/nvim-lspconfig",
			opt = true,
			setup = function()
				require("lazy_load").on_file_open("nvim-lspconfig")
			end,
			config = function()
				require("config.lsp")
			end,
		})

		use({ "rafamadriz/friendly-snippets", module = { "cmp", "cmp_nvim_lsp" }, event = "InsertEnter" })

		use({
			"hrsh7th/nvim-cmp",
			after = "friendly-snippets",
			config = function()
				require("config.cmp")
			end,
		})

		use({
			"L3MON4D3/LuaSnip",
			wants = "friendly-snippets",
			after = "nvim-cmp",
			config = function()
				require("config.luasnip")
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
				require("config.autopair")
			end,
		})

		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("config.null-ls")
			end,
			requires = { "nvim-lua/plenary.nvim" },
		})

		-- formatter
		use({
			"mhartington/formatter.nvim",
			after = "nvim-lspconfig",
			config = function()
				require("config.formatter")
			end,
		})

		use({
			"goolord/alpha-nvim",
			config = function()
				require("config.alpha")
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
				require("config.nvimtree")
			end,
		})

		use({
			"nvim-telescope/telescope.nvim",
			cmd = "Telescope",
			requires = {
				{ "nvim-lua/plenary.nvim" },
			},
			config = function()
				require("config.telescope")
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
				require("config.whichkey")
			end,
		})

		use({
			"kevinhwang91/nvim-hlslens",
			config = function()
				require("config.hlslens")
			end,
		})

		use({
			"petertriho/nvim-scrollbar",
			config = function()
				require("config.scrollbar")
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
			-- run = function()
			-- 	vim.fn["mkdp#util#install"]()
			-- end,
		})

		use({
			"mfussenegger/nvim-dap",
			config = function()
				require("config.dap").dap()
			end,
		})

		use({
			"rcarriga/nvim-dap-ui",
			requires = {
				{ "mfussenegger/nvim-dap" },
				{ "theHamsta/nvim-dap-virtual-text" },
			},
			config = function()
				require("config.dap").dapui()
			end,
		})

		-- nvim jdtls
		use({
			"mfussenegger/nvim-jdtls",
			opt = true,
			setup = function()
				require("lazy_load").on_file_open("nvim-jdtls")
			end,
			disable = false,
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

		if packer_bootstrap then
			require("packer").sync()
			vim.api.nvim_create_autocmd("User", {
				pattern = "PackerComplete",
				callback = function()
					vim.cmd("bw | silent! MasonInstallAll") -- close packer window
					packer.loader("nvim-treesitter")
				end,
			})
		end
	end,
	config = {
		git = {
			clone_timeout = 300,
		},
		display = {
			working_sym = "ﲊ",
			error_sym = "✗ ",
			done_sym = " ",
			removed_sym = " ",
			moved_sym = "",
			open_fn = function()
				local result, win, buf = require("packer.util").float({
					border = {
						{ "╭", "FloatBorder" },
						{ "─", "FloatBorder" },
						{ "╮", "FloatBorder" },
						{ "│", "FloatBorder" },
						{ "╯", "FloatBorder" },
						{ "─", "FloatBorder" },
						{ "╰", "FloatBorder" },
						{ "│", "FloatBorder" },
					},
				})
				vim.api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
				return result, win, buf
			end,
		},
	},
})
