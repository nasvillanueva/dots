-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").moon

config.colors = theme.colors()

config.enable_tab_bar = false

config.use_ime = true
config.use_dead_keys = false

config.font = wezterm.font("JetBrainsMono Nerd Font")

config.disable_default_key_bindings = true
config.keys = {
  {
    key = "q",
    mods = "CMD",
    action = wezterm.action.CloseCurrentTab({ confirm = false }),
  },
  {
    key = "c",
    mods = "CMD",
    action = wezterm.action.CopyTo("Clipboard"),
  },
  {
    key = "v",
    mods = "CMD",
    action = wezterm.action.PasteFrom("Clipboard"),
  },
}

config.enable_kitty_keyboard = true
config.disable_default_mouse_bindings = true
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

config.audible_bell = "Disabled"
config.enable_scroll_bar = false

config.scrollback_lines = 10000

config.window_decorations = "RESIZE"

config.term = "wezterm"

config.window_padding = {
  left = "2cell",
  right = "2cell",
  top = "0.8cell",
  bottom = "0.8cell",
}

return config
