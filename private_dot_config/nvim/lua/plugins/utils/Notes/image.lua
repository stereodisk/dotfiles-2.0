return {
	"3rd/image.nvim",
	build = false,
	opts = {
		backend = "kitty",
		processor = "magick_cli",
		integrations = {
			markdown = {
				enabled = true,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = false,
				only_render_image_at_cursor_mode = "popup", -- or "inline"
				floating_windows = true,
				filetypes = { "markdown", "vimwiki" },
			},
			html = {
				enabled = false,
			},
			css = {
				enabled = true,
			},
		},
		max_width = nil,
		max_height = nil,
		max_width_window_percentage = nil,
		max_height_window_percentage = 50,
		scale_factor = 1.0,
		window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
		window_overlap_clear_ft_ignore = { "snacks_notif", "scrollview", "scrollview_sign" },
		editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
		hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
	},
}
