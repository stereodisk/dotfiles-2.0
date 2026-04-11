return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Fortune header
		local header = {
			type = "text",
			val = function()
				local lines = require("alpha.fortune")()
				local out = {}

				for _, line in ipairs(lines) do
					if line:match("%S") then
						table.insert(out, line)
					end
				end
				return out
			end,
			opts = {
				position = "center",
				hl = "String",
			},
		}

		local mes = os.date("%B"):gsub("^%l", string.upper)
		dashboard.section.tasks = {
			type = "text",
			val = os.date("%I:%M%p, %d - ") .. mes .. os.date(" - %Y"),
			opts = {
				hl = "Keyword",
				position = "center",
			},
		}

		-- Layout
		dashboard.config.layout = {
			{ type = "padding", val = 1 },
			header,
			{ type = "padding", val = 1 },
			dashboard.section.tasks,
		}
		alpha.setup(dashboard.config)
	end,
}
