{ ... }:

{
  imports = [
    ./graphics
  ] ++ [
    ./auto.nix
    ./bluetooth.nix
    ./clock.nix
    ./cpu.nix
    ./display.nix
    ./firmware.nix
    ./irq.nix
    ./keyboard
    ./sound.nix
    ./usb.nix
  ];
}
