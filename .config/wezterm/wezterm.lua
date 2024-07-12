local wezterm = require("wezterm")

config = {}

config.enable_tab_bar = false

config.max_fps = 75
config.animation_fps = 75
--config.cursor_blink_ease_in = 'Constant'
--config.cursor_blink_ease_out = 'Constant'

config.window_background_opacity = 0.96

config.font_size = 15
config.line_height = 1.2
config.underline_thickness = 1
config.underline_position = -4.0
config.freetype_load_target = "Normal"
config.bold_brightens_ansi_colors = false
--config.freetype_render_target = 'Normal'
--config.freetype_load_flags = 'NO_HINTING'

config.audible_bell = "Disabled"

config.warn_about_missing_glyphs = false
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
	weight = "Medium",
})

config.default_cursor_style = "BlinkingBlock"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = true
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

local scheme = wezterm.get_builtin_color_schemes()["Tokyo Night"]
--scheme.brights[1] = scheme.ansi[1]
config.color_schemes = { ["Tokyo Night"] = scheme }
config.color_scheme = "Tokyo Night"

return config
