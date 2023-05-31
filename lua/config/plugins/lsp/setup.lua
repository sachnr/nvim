local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("config.plugins.lsp.handlers")
local opts = require("config.plugins.lsp.settings")
local on_attach = opts.on_attach
local capablities = opts.capablities

local servers = {
	"html",
	"bashls",
	"jsonls",
	"cssls",
	"ccls",
	-- "vuels",
	"pylsp",
	"sqlls",
	-- "gopls",
	"tsserver",
	"yamlls",
  "nil_ls",
}

local neoconf_ok, neoconf = pcall(require, "neoconf")
if neoconf_ok then
	neoconf.setup({
		import = {
			vscode = false, -- local .vscode/settings.json
			coc = false, -- global/local coc-settings.json
			nlsp = false, -- global/local nlsp-settings.nvim json settings
		},
		live_reload = false,
		plugins = {
			lua_ls = {
				enabled = true,
			},
		},
	})
end

local neodev_ok, neodev = pcall(require, "neodev")
if neodev_ok then
	neodev.setup()
end

local ok, rust_tools = pcall(require, "rust-tools")
if ok then
	local mason = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
	local codelldb_path = mason .. "adapter/codelldb"
	local liblldb_path = mason .. "lldb/lib/liblldb.so"
	rust_tools.setup({
		tools = {
			hover_actions = {
				border = "single",
			},
		},
		server = {
			on_attach = function(client, bufnr)
				local keys = require("keys")
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				keys.lsp_attach(bufnr)
				local opt = { silent = true, noremap = true, buffer = bufnr }
				local set = vim.keymap.set
				set(
					"n",
					"K",
					rust_tools.hover_actions.hover_actions,
					vim.tbl_deep_extend("force", opt, { desc = "Hover" })
				)
				set(
					"n",
					"ga",
					rust_tools.code_action_group.code_action_group,
					vim.tbl_deep_extend("force", opt, { desc = "code_action" })
				)
			end,
			capablities = capablities,
			-- cmd = {
			-- 	"rustup",
			-- 	"run",
			-- 	"stable",
			-- 	"rust-analyzer",
			-- },
		},
		dap = {
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	})
end

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capablities,
	})
end

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capablities,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})
