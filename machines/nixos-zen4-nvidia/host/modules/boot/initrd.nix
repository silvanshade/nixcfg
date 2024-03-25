{
  boot.initrd = {
    verbose = false;
    systemd = {
      enable = true;
      dbus.enable = true;
    };
  };
}
