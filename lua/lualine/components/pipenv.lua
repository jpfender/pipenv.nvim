local M = require("lualine.component"):extend()

local highlight = require("lualine.highlight")
local utils = require("lualine.utils.utils")

function M:init(options)
	M.super.init(self, options)
	self.colors = {}
	self.color = highlight.create_component_highlight_group(
		{ fg = utils.extract_highlight_colors("WarningMsg", "fg") },
		"pipenv",
		self.options
	)
end

function M:update_status()
	if vim.bo.filetype == "python" then
		local venv = require("pipenv").get_current_venv()
		if venv then
			return string.format("%s %s", highlight.component_format_highlight(self.color), venv.name)
		else
			return ""
		end
	else
		return ""
	end
end

return M
