{ pkgs, ... }:
{
  systemd.services.usb-reset = {
    description = "Reset USB devices on resume";
    wantedBy = [
      "post-resume.target"
    ];
    after = [
      "post-resume.target"
    ];
    path = with pkgs; [
      bash
      coreutils
      kmod
      uhubctl
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeScript "reset-usb.sh" ''
        #!/bin/sh
        sleep 15
        rmmod xhci_pci
        rmmod xhci_hcd
        sleep 5
        modprobe xhci_pci
        uhubctl --vendor 2188:0031 --action cycle
      '';
    };
  };
}

