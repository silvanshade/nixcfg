{ ... }:

{
  imports = [
    ./boot
    ./dbus
    ./hardware
    ./kernel
    ./programs
    ./security
    ./services
    ./systemd
    ./themes
    ./users
    ./xdg
  ] ++ [
    ./environment.nix
    ./networking.nix
  ];
}
