{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # NOTE: installs xdg autostart files
    polkit_gnome
  ];
}
