local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.enable_tab_bar = false
config.term = "wezterm"
config.font = wezterm.font_with_fallback({
  "PragmataPro Mono Liga",
  "Iosevka",
  "Fira Code",
})

return config
