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
      ExecStart = pkgs.writeScript "enable-extra-monitors.sh" ''
        #!/bin/sh
        # echo on > /sys/class/drm/card1-DP-3/status
      '';
    };
  };
}
