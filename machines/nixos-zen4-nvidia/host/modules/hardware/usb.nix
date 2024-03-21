{
  boot.kernelParams = [
    "usbcore.autosuspend=-1"
  ];

  services.hardware.bolt.enable = true;
}
