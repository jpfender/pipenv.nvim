local M = require("lualine.component"):extend()

function M:init(options)
	M.super.init(self, options)
end

function M:update_status()
	if vim.bo.filetype == "python" then
		local venv = require("pipenv").get_current_venv()
		if venv then
			return string.format("%s", venv.name)
		else
			return ""
		end
	else
		return ""
	end
end

return M
