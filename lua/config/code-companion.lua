local system = require("utils.system")

if not system.is_work_device() then
	return
end

-- Retrieves the Claude authentication token from the user's settings file.
-- @return string|nil: The Claude authentication token if found, otherwise nil.
local function get_claude_token()
	local settings_path = os.getenv("HOME") .. "/.claude/settings.json"
	local file = io.open(settings_path, "r")
	if not file then
		return nil
	end

	local content = file:read("*a")
	file:close()

	local ok, settings = pcall(vim.json.decode, content)
	if not ok or not settings then
		return nil
	end

	return settings.env and settings.env.ANTHROPIC_AUTH_TOKEN
end

local claude_token = get_claude_token()

-- Checks if the hai proxy can be reached on its usual port.
-- @return boolean: True if the proxy is available, false otherwise.
local function is_hai_proxy_available()
	local connected = false
	local request_done = false
	vim.net.request("http://127.0.0.1:6655", { retry = 0 }, function(err)
		request_done = true
		if err ~= nil then
			return
		end

		connected = true
	end)
	vim.wait(1000, function()
		return request_done
	end, 25)
	return request_done and connected
end

-- Determines which adapter to use based on the availability of the Claude token and hai proxy status.
-- @return string: The name of the adapter to use.
local function get_adapter()
	if claude_token ~= nil and is_hai_proxy_available() then
		vim.notify("Using Claude Code", vim.log.levels.INFO)
		return "claude_code"
	else
		vim.notify("Using Copilot", vim.log.levels.INFO)
		return "copilot"
	end
end

local adapter = get_adapter()

require("codecompanion").setup({
	extensions = {
		spinner = {},
	},
	adapters = {
		acp = {
			claude_code = function()
				return require("codecompanion.adapters").extend("claude_code", {
					defaults = {
						model = "opus",
					},
					env = {
						CLAUDE_CODE_OAUTH_TOKEN = claude_token,
					},
				})
			end,
		},
	},
	display = {
		chat = {
			window = {
				width = 0.35,
				relative = "editor",
				position = "left",
			},
		},
	},
	interactions = {
		cmd = {
			adapter = adapter,
		},
		chat = {
			adapter = adapter,
		},
		inline = {
			adapter = "copilot", -- Inline does not support acp, use copilot as fallback
		},
		shared = {
			keymaps = {
				always_accept = {
					callback = "keymaps.always_accept",
					modes = { n = "cay" },
				},
				accept_change = {
					callback = "keymaps.accept_change",
					modes = { n = "ca" },
				},
				reject_change = {
					callback = "keymaps.reject_change",
					modes = { n = "cr" },
				},
				next_hunk = {
					callback = "keymaps.next_hunk",
					modes = { n = "]" },
				},
				previous_hunk = {
					callback = "keymaps.previous_hunk",
					modes = { n = "[" },
				},
			},
		},
	},
})
