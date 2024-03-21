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
      coreutils
      kmod
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [
        "sleep 15"
        "rmmod xhci_pci"
        "sleep 5"
        "modprobe xhci_pci"
      ];
    };
  };
}

