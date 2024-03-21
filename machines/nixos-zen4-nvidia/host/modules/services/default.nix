{ ... }:

{
  imports = [
    ./authentication
    ./desktop-manager
    ./display-manager
    ./gnome
    ./ssh.nix
    ./xserver.nix
    ./wayland.nix
  ];
}
