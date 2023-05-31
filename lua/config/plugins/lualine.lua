return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		config = function()
			local lualine = require("lualine")

			-- colrs
			local get_hex = function(hlgroup_name, attr)
				local hlgroup_ID = vim.fn.synIDtrans(vim.fn.hlID(hlgroup_name))
				local hex = vim.fn.synIDattr(hlgroup_ID, attr)
				return hex ~= "" and hex or "NONE"
			end
			local colors = {
				error = get_hex("DiagnosticError", "fg"),
				warn = get_hex("DiagnosticWarn", "fg"),
				info = get_hex("DiagnosticInfo", "fg"),
				hint = get_hex("DiagnosticHint", "fg"),
			}

			local function getLspName()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return "  " .. client.name
					end
				end
				return "  " .. msg
			end

			local function getIndentInfo()
				if vim.bo.expandtab then
					return " Spaces:" .. vim.bo.shiftwidth
				else
					return " Tabs:" .. vim.bo.tabstop
				end
			end

			local options = {
				icons_enabled = true,
        globalstatus = true,
				theme = "base46",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {
						"packer",
						"qf",
						"help",
						"quickfix",
						"prompt",
						"alpha",
						"dap-repl",
						"Trouble",
						"lspsagaoutline",
					},
					winbar = {
						"quickfix",
						"prompt",
						"NvimTree",
						"packer",
						"qf",
						"help",
						"alpha",
						"dap-repl",
						"Trouble",
						"lspsagaoutline",
					},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			}

			local sections = {
				lualine_a = {
					{
						"mode",
					},
				},
				lualine_b = {
					{
						"filename",
						file_status = true,
						newfile_status = false,
						path = 1,

						shorting_target = 40,
						symbols = {
							modified = "[+]",
							readonly = "[-]",
							unnamed = "[No Name]",
							newfile = "[New]",
						},
					},
				},
				lualine_c = { "branch", "diff" },
				lualine_x = {
					-- {
					-- 	require("auto-session-library").current_session_name,
					-- 	icon = "󰃖",
					-- },
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = { fg = "#ff9e64" },
					},
					"location",
				},
				lualine_y = {
					"searchcount",
					{ getIndentInfo },
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						separator = "",
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
							other = " ",
						},
						diagnostics_color = {
							error = { fg = colors.error, gui = "bold" },
							warn = { fg = colors.warn, gui = "bold" },
							info = { fg = colors.info, gui = "bold" },
							hint = { fg = colors.hint, gui = "bold" },
						},
						colored = true,
					},
				},
				lualine_z = {
					{ getLspName },
				},
			}
			local inactive_sections = {
				lualine_a = { {
					function()
						return vim.api.nvim_win_get_number(0)
					end,
				} },
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			}
			local tabline = {}
			local winbar = {}
			local inactive_winbar = {}
			local extensions = {
				"toggleterm",
				"nvim-dap-ui",
				"neo-tree",
				"symbols-outline",
			}

			lualine.setup({
				options = options,
				sections = sections,
				inactive_sections = inactive_sections,
				tabline = tabline,
				winbar = winbar,
				inactive_winbar = inactive_winbar,
				extensions = extensions,
			})
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
}
