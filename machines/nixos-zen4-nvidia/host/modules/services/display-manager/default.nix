{ ... }:

{
  imports = [
    ./cosmic-greeter.nix
    ./gdm.nix
    ./sddm.nix
  ];

  services.xserver.displayManager.defaultSession = "hyprland";
}
