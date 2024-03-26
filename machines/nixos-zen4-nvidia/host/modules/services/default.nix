{ ... }:

{
  imports = [
    ./authentication
    ./desktop-manager
    ./display-manager
    ./gnome
    ./virtualization
  ] ++ [
    ./ssh.nix
    ./xserver.nix
    ./wayland.nix
  ];
}
