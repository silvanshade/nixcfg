{
  # programs.zellij.enable = true;
  programs.zellij.enable = false;

  programs.zellij.enableZshIntegration = true;

  xdg.configFile = {
    "zellij/config.kdl".source = ../../data/xdg/config/zellij/config.kdl;
  };
}
