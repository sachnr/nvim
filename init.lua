-- improves startup time
vim.defer_fn(function()
	pcall(require, "impatient")
end, 0)

require("core.options")
require("core.plugins")
require("core.keymaps")
