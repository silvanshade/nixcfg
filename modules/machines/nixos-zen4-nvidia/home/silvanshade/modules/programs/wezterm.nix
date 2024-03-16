{
  programs.wezterm.enable = true;

  programs.wezterm.enableZshIntegration = true;

  xdg.configFile = {
    "wezterm/wezterm.lua".source = ../../data/xdg/config/wezterm/wezterm.lua;
  };
}
