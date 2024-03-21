{ ... }:

{
  imports = [
    ./graphics
  ] ++ [
    ./auto.nix
    ./bluetooth.nix
    ./clock.nix
    ./cpu.nix
    ./firmware.nix
    ./keyboard.nix
    ./sound.nix
    ./usb.nix
  ];
}
