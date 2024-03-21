{
  programs.waybar.enable = true;

  xdg.configFile = {
    "waybar/config.jsonc".source = ../../data/xdg/config/waybar/config.jsonc;
    "waybar/style.css".source = ../../data/xdg/config/waybar/style.css;
  };
}
