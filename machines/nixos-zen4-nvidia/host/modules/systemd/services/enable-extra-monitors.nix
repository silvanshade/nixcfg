{ pkgs, ... }:

{
  systemd.services.enable-extra-monitors = {
    wantedBy = [
      "multi-user.target"
    ];
    before = [
      "multi-user.target"
    ];
    path = with pkgs; [
      bash
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/sh -c 'echo on > /sys/class/drm/card0-DP-3/status'";
    };
  };
}
