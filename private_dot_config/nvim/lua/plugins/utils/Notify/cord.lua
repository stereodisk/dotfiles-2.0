-- Tooltip
---@return string
local function fortune()
	local f = io.popen("fortune")
	local tooltip = ""

	if f ~= nil then
		tooltip = f:read("*a")
		f:close()
	end

	return tooltip
end

return {
	"vyfor/cord.nvim",
	build = ":Cord update",
	event = "VeryLazy",
	opts = {
		editor = {
			tooltip = fortune(),
		},

		timestamp = {
			enabled = false,
		},

		display = {
			theme = "classic",
			flavor = "dark",
		},

		text = {
			workspace = "ᓚᘏᗢ",
		},
	},
}
