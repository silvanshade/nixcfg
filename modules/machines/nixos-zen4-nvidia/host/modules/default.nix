{ ... }:

{
  imports = [
    ./boot
    ./development
    ./dbus
    ./emulation
    ./gaming
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

  services.seatd.enable = true;
}
