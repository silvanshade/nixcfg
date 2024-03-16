{ ... }:

{
  imports = [
    ./gdm.nix
  ];

  services.displayManager.defaultSession = "plasma";
}
