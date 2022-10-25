local present, devicons = pcall(require, "nvim-web-devicons")
if not present then
	return
end

require("base46").load_highlight("devicons")

devicons.setup()
