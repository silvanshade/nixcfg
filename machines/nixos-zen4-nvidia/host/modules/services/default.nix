{ ... }:

{
  imports = [
    ./authentication
    ./desktop-manager
    ./display-manager
    ./gnome
    ./pxe
    ./virtualization
  ] ++ [
    ./ssh.nix
    ./xserver.nix
    ./wayland.nix
  ];
}
