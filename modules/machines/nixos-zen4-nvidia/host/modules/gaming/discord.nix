{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-discord-ipc-bridge
  ];
}
