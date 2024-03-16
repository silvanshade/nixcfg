{ ... }:

{
  imports = [
    ./authentication
    ./desktop-manager
    ./display-manager
    ./pxe
    ./virtualization
  ] ++ [
    ./fwupd.nix
    ./power-profiles-daemon.nix
    ./ssh.nix
    ./xserver.nix
    ./wayland.nix
  ];
}
