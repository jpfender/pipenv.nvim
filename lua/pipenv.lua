local M = {}

local Job = require("plenary.job")

local ORIGINAL_PATH = vim.fn.getenv("PATH")

local current_venv = nil

local set_venv = function(venv)
	local venv_bin_path = venv.path .. "/bin"
	vim.fn.setenv("PATH", venv_bin_path .. ":" .. ORIGINAL_PATH)
	vim.fn.setenv("VIRTUAL_ENV", venv.path)
	current_venv = venv
end

M.get_current_venv = function()
	return current_venv
end

M.set_pipenv = function()
	if vim.bo.filetype == "python" then
		local cur_path = vim.fn.expand("%:p:h")
		Job:new({
			command = "sh",
			args = { "-c", "cd " .. cur_path .. "; pipenv --venv" },
			rg = cur_path,
			on_exit = vim.schedule_wrap(function(job, return_val)
				if return_val == 0 then
					local venv_path = job:result()[1]
					local i, j = string.find(venv_path, "/[^/]+-")
					local venv_name = string.sub(venv_path, i + 1, j - 1)
					local venv = {
						name = venv_name,
						path = venv_path,
					}
					set_venv(venv)
				end
			end),
		}):start()
	else
		current_venv = nil
	end
end

return M
