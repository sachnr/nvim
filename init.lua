-- improves startup time
vim.defer_fn(function()
	pcall(require, "impatient")
end, 0)

require("options")
require("plugins")
require("keymaps")
