{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dunst
  ];

  xdg.configFile = {
    "dunst/dunstsrc".source = ../../data/xdg/config/dunst/dunstsrc;
  };
}
