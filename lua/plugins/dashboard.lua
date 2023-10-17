return {
	{
		"glepnir/dashboard-nvim",
		enabled = false,
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				shortcut_type = "letter",
				change_to_vcs_root = false,
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{ desc = " Update", group = "DiagnosticHint", action = "Lazy update", key = "u" },
						{
							icon = " ",
							icon_hl = "DiagnosticInfo",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " pinned projects",
							group = "Directory",
							action = "Telescope project",
							key = "p",
						},
						{
							desc = " Old Files",
							group = "Directory",
							action = "Telescope oldfiles",
							key = "o",
						},
						{
							desc = " dotfiles",
							group = "DiagnosticWarn",
							action = "e $MYVIMRC | cd %:p:h",
							key = "d",
						},
					},
				},
				hide = {
					statusline = true,
					tabline = true,
					winbar = true,
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},

	{
		"goolord/alpha-nvim",
		enabled = false,
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local theme = require("alpha.themes.theta")
			local cdir = vim.fn.getcwd()
			local path_ok, plenary_path = pcall(require, "plenary.path")
			if not path_ok then
				return
			end

			-- Header
			local function apply_gradient(text)
				local lines = {}
				for i, line in ipairs(text) do
					local tbl = {
						type = "text",
						val = line,
						opts = {
							hl = "AlphaGradient" .. i,
							shrink_margin = false,
							position = "center",
						},
					}
					table.insert(lines, tbl)
				end

				return {
					type = "group",
					val = lines,
					opts = { position = "center" },
				}
			end

			local days = {
				{
					"███╗   ███╗ ██████╗ ███╗   ██╗██████╗  █████╗ ██╗   ██╗",
					"████╗ ████║██╔═══██╗████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝",
					"██╔████╔██║██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝⠀",
					"██║╚██╔╝██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝⠀⠀",
					"██║ ╚═╝ ██║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║⠀⠀⠀",
					"╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀",
				},
				{
					"████████╗██╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗",
					"╚══██╔══╝██║   ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝",
					"   ██║   ██║   ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝⠀",
					"   ██║   ██║   ██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝⠀⠀",
					"   ██║   ╚██████╔╝███████╗███████║██████╔╝██║  ██║   ██║⠀⠀⠀",
					"   ╚═╝    ╚═════╝ ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀",
				},
				{
					"██╗    ██╗███████╗██████╗ ███╗   ██╗███████╗███████╗██████╗  █████╗ ██╗   ██╗",
					"██║    ██║██╔════╝██╔══██╗████╗  ██║██╔════╝██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝",
					"██║ █╗ ██║█████╗  ██║  ██║██╔██╗ ██║█████╗  ███████╗██║  ██║███████║ ╚████╔╝⠀",
					"██║███╗██║██╔══╝  ██║  ██║██║╚██╗██║██╔══╝  ╚════██║██║  ██║██╔══██║  ╚██╔╝⠀⠀",
					"╚███╔███╔╝███████╗██████╔╝██║ ╚████║███████╗███████║██████╔╝██║  ██║   ██║⠀⠀⠀",
					" ╚══╝╚══╝ ╚══════╝╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀",
				},
				{
					"████████╗██╗  ██╗██╗   ██╗██████╗ ███████╗██████╗  █████╗ ██╗   ██╗",
					"╚══██╔══╝██║  ██║██║   ██║██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗ ██╔╝",
					"   ██║   ███████║██║   ██║██████╔╝███████╗██║  ██║███████║ ╚████╔╝⠀",
					"   ██║   ██╔══██║██║   ██║██╔══██╗╚════██║██║  ██║██╔══██║  ╚██╔╝⠀⠀",
					"   ██║   ██║  ██║╚██████╔╝██║  ██║███████║██████╔╝██║  ██║   ██║⠀⠀⠀",
					"   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀",
				},
				{
					"███████╗██████╗ ██╗██████╗  █████╗ ██╗   ██╗",
					"██╔════╝██╔══██╗██║██╔══██╗██╔══██╗╚██╗ ██╔╝",
					"█████╗  ██████╔╝██║██║  ██║███████║ ╚████╔╝⠀",
					"██╔══╝  ██╔══██╗██║██║  ██║██╔══██║  ╚██╔╝⠀⠀",
					"██║     ██║  ██║██║██████╔╝██║  ██║   ██║⠀⠀⠀",
					"╚═╝     ╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀",
				},
				{
					"███████╗ █████╗ ████████╗██╗   ██╗██████╗ ██████╗  █████╗ ██╗   ██╗",
					"██╔════╝██╔══██╗╚══██╔══╝██║   ██║██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝",
					"███████╗███████║   ██║   ██║   ██║██████╔╝██║  ██║███████║ ╚████╔╝⠀",
					"╚════██║██╔══██║   ██║   ██║   ██║██╔══██╗██║  ██║██╔══██║  ╚██╔╝⠀⠀",
					"███████║██║  ██║   ██║   ╚██████╔╝██║  ██║██████╔╝██║  ██║   ██║⠀⠀⠀",
					"╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀",
				},
				{
					"███████╗██╗   ██╗███╗   ██╗██████╗  █████╗ ██╗   ██╗",
					"██╔════╝██║   ██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝",
					"███████╗██║   ██║██╔██╗ ██║██║  ██║███████║ ╚████╔╝⠀",
					"╚════██║██║   ██║██║╚██╗██║██║  ██║██╔══██║  ╚██╔╝⠀⠀",
					"███████║╚██████╔╝██║ ╚████║██████╔╝██║  ██║   ██║⠀⠀⠀",
					"╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝   ╚═╝⠀⠀⠀",
				},
			}

			local function get_header()
				local day = tonumber(os.date("%w"))
				if day == 0 then
					day = 7
				end
				local header_text = days[day]
				return apply_gradient(header_text)
			end

			-- Info section
			local function get_info()
				local lazy_stats = require("lazy").stats()
				local total_plugins = " " .. lazy_stats.loaded .. "/" .. lazy_stats.count .. " packages"
				local datetime = os.date(" %A %B %d")
				local version = vim.version()

				local info_string = datetime .. "  |  " .. total_plugins

				return {
					type = "text",
					val = info_string,
					opts = {
						hl = "AlphaFolder",
						position = "center",
					},
				}
			end

			-- Links / tools
			local dashboard = require("alpha.themes.dashboard")

			local links = {
				type = "group",
				val = {
					dashboard.button("l", "  Lazy", "<cmd>Lazy<CR>"),
					dashboard.button("m", "  Mason", "<cmd>Mason<CR>"),
				},
				position = "center",
				opts = { hl = "AlphaFolder" },
			}

			-- MRU

			local section_mru = {
				type = "group",
				val = {
					{
						type = "text",
						val = "Recent files",
						opts = {
							hl = "AlphaTitle",
							shrink_margin = false,
							position = "center",
						},
					},
					{ type = "padding", val = 1 },
					{
						type = "group",
						val = function()
							return { theme.mru(0, cdir) }
						end,
						opts = { shrink_margin = false },
					},
				},
			}

			-- Layout
			theme.config.layout = {
				{ type = "padding", val = 6 },
				get_header(),
				{ type = "padding", val = 2 },
				get_info(),
				{ type = "padding", val = 2 },
				section_mru,
				{ type = "padding", val = 2 },
				links,
			}
			require("alpha").setup(theme.config)
		end,
	},
}
