local chat = require("CopilotChat")
local select = require("CopilotChat.select")

vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
	chat.ask(args.args, { selection = select.buffer })
end, { nargs = "*", range = true })
