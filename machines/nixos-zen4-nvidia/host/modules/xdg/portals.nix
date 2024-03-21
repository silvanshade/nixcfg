{ pkgs, ... }:

{
  xdg.portal.enable = true;

  xdg.portal.xdgOpenUsePortal = true;

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];

  # xdg.portal.config.cosmic = {
  #   default = [
  #     "gnome-keyring"
  #     "hyprland"
  #     "gtk"
  #   ];
  #   "org.freedesktop.impl.portal.Secret" = [
  #     "gnome-keyring"
  #   ];
  # };

  xdg.portal.config.hyprland = {
    default = [
      "gnome-keyring"
      "hyprland"
      "gtk"
    ];
    "org.freedesktop.impl.portal.Secret" = [
      "gnome-keyring"
    ];
  };
}
