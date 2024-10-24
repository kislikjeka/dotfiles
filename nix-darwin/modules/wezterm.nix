{ pkgs, ... }:
{
  enable = true;
  enableZshIntegration = true;
  extraConfig = ''
    local config = {}

    --config.enable_tab_bar = false

    config.max_fps = 75
    config.animation_fps = 75
    --config.cursor_blink_ease_in = 'Constant'
    --config.cursor_blink_ease_out = 'Constant'
    config.window_background_opacity = 0.96

    config.font_size = 15
    config.line_height = 1.2
    config.underline_thickness = 1
    config.front_end = "WebGpu"
    config.underline_position = -4.0
    config.freetype_load_target = "Normal"
    config.bold_brightens_ansi_colors = false
    --config.freetype_render_target = 'Normal'
    --config.freetype_load_flags = 'NO_HINTING'

    config.audible_bell = "Disabled"

    config.warn_about_missing_glyphs = false
    config.font = wezterm.font 'JetBrains Mono'
    config.default_cursor_style = "BlinkingBlock"

    config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      }

    config.color_scheme = "Tokyo Night"

    return config
  '';
}
