local utils = require("utils")

if not utils.is_work_device() then
	return
end

local prompts = {
	Review = "Please review the following code and provide suggestions for improvement.",
	Fix = "Please fix the following code to make it work as intended.",
	Optimize = "Please optimize the selected code to improve performance and readablilty.",
	Documentation = "Please provide documentation for the following code.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
}

require("CopilotChat.integrations.cmp").setup()
require("CopilotChat").setup({
	mappings = {
		complete = {
			insert = '', -- add autocomplete in chat window for prompts
		},
	},
	debug = false,
	model = "gpt-4o",
	question_header = "## User ",
	answer_header = "## Copilot ",
	error_header = "## Error ",
	prompts = prompts,
	auto_follow_cursor = false, -- Don't follow the cursor after getting response
	show_help = false,       -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
	window = {
		layout = "vertical",
		width = 0.3, -- fractional width of parent, or absolute width in columns when > 1
		height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
	},
})

vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CopilotChatToggle<cr>")
vim.keymap.set("n", "<leader>cfd", "<cmd>CopilotChatFixDiagnostic<cr>")
vim.keymap.set("v", "<leader>cr", "<cmd>CopilotChatReview<cr>")
vim.keymap.set("v", "<leader>cf", "<cmd>CopilotChatFix<cr>")
vim.keymap.set("v", "<leader>co", "<cmd>CopilotChatOptimize<cr>")
vim.keymap.set("v", "<leader>cd", "<cmd>CopilotChatDocumentation<cr>")
vim.keymap.set("v", "<leader>ct", "<cmd>CopilotChatTests<cr>")

vim.keymap.set({ "n", "v" }, "<leader>fc", function()
	local actions = require("CopilotChat.actions")
	require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end)
vim.keymap.set("n", "<leader>cq", function()
	local input = vim.fn.input("Quick Chat: ")
	if input ~= "" then
		require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
	end
end)
