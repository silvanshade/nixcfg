{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    extraConfig = builtins.readFile ../../../data/xdg/config/hypr/hyprland.conf;
  };

  xdg.configFile = {
    "hypr/scripts/start.sh" = {
      source = ../../../data/xdg/config/hypr/scripts/start.sh;
      executable = true;
    };
    "hypr/scripts/stop.sh" = {
      source = ../../../data/xdg/config/hypr/scripts/stop.sh;
      executable = true;
    };
  };
}
