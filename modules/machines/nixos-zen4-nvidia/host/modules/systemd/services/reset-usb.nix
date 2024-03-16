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
        rmmod usbhid
        rmmod xhci_pci
        rmmod xhci_hcd
        modprobe xhci_hcd
        modprobe xhci_pci
        modprobe usbhid
      '';
    };
  };
}

