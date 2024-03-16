{
  hardware.wooting.enable = true;
  services.xserver.xkb = {
    layout = "us";
    model = "pc104";
    options = "compose:ralt,terminate:ctrl_alt_bksp";
  };
}
