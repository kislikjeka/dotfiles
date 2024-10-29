local wezterm = require("wezterm")

local config = {}

local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

-- config.enable_tab_bar = false

config.max_fps = 75
config.animation_fps = 75
--config.cursor_blink_ease_in = 'Constant'
--config.cursor_blink_ease_out = 'Constant'
-- config.default_prog = { "fish", "-l" }
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

config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	{ key = "b", mods = "CTRL", action = wezterm.action({ SendString = "\x1bb" }) },
	-- Make Option-Right equivalent to Alt-f; forward-word
	{ key = "f", mods = "CTRL", action = wezterm.action({ SendString = "\x1bf" }) },
}

-- move between split panes
-- Leader is the same as my old tmux prefix
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
	-- splitting
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "=",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "Enter",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
}

local scheme = wezterm.get_builtin_color_schemes()["Tokyo Night"]
--scheme.brights[1] = scheme.ansi[1]
config.color_schemes = { ["Tokyo Night"] = scheme }
config.color_scheme = "Tokyo Night"

return config
