local system = {}

-- Get the path of a mason package by its name
function system.get_mason_dir(package_name)
	return vim.fn.stdpath("data") .. "/mason/packages/" .. package_name
end

-- Get the path of a mason binary by its package name
function system.get_mason_binary(package_name)
	return system.get_mason_dir(package_name) .. "/" .. package_name
end

-- Get the path of the Python interpreter used by debugpy
function system.get_python_path()
	local cwd = vim.fn.getcwd()
	if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
		return cwd .. "/venv/bin/python"
	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	else
		return system.get_mason_dir("debugpy") .. "/venv/bin/python"
	end
end

function system.get_username()
	local f = io.popen("whoami")
	local username = ""
	if f ~= nil then
		username = f:read("*a")
		username = username:gsub("%s+", "")
		f:close()
	end
	return username:lower()
end

function system.is_work_device()
	local username = system.get_username()
	local name_regex = "d%d%d%d%d%d%d" -- matches d followed by 6 digits, e.g. d123456
	return string.match(username, name_regex)
end

function system.is_git_repo()
	local git_dir = vim.fn.getcwd() .. "/.git"
	return vim.fn.isdirectory(git_dir) == 1
end

function system.ensure_directory_exists(dir)
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end
end

-- Checks if a file exists and creates it if it does not.
-- Returns true if the file was created, otherwise false.
function system.ensure_file_exists(filepath)
	local dir = vim.fn.fnamemodify(filepath, ":h")
	system.ensure_directory_exists(dir)

	if vim.fn.filereadable(filepath) == 0 then
		local file = io.open(filepath, "w")
		if file ~= nil then
			file:close()
		end
		return true
	else
		return false
	end
end

function system.append_file(path, content)
	local file = io.open(path, "a+")
	if file ~= nil then
		file:seek("end")
		file:write(content)
		file:close()
	end
end

-- Opens a browser at the given URL
function system.open_browser(url)
	local browser_cmd = ""
	if vim.fn.has("mac") == 1 then
		browser_cmd = "open " .. url
	elseif vim.fn.has("unix") == 1 then
		browser_cmd = "xdg-open " .. url
	else
		print("Unsupported system")
		return
	end

	vim.fn.system(browser_cmd)
end

return system
