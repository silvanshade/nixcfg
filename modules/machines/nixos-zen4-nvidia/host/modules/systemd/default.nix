{ ... }:

{
  imports = [
    ./services
    ./targets
  ];

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
}
