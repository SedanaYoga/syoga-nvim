-- local home = os.getenv("HOME")
local dashboard_status_ok, dashboard = pcall(require, "dashboard")
if not dashboard_status_ok then
	return
end

-- macos
-- dashboard.preview_command = "cat | lolcat -F 0.3"
--
-- dashboard.preview_file_path = home .. "/.config/nvim/static/neovim.cat"
-- dashboard.preview_file_height = 11
-- dashboard.preview_file_width = 70

dashboard.custom_center = {
	{
		icon = "  ",
		desc = "Find File                           ",
		shortcut = "SPC f",
		action = "Telescope find_files",
	},
	{
		icon = "  ",
		desc = "Find word                           ",
		action = "Telescope live_grep",
		shortcut = "SPC r",
	},
}
