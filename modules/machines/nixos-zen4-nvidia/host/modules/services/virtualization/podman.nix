{ pkgs, ... }:

{
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
    dockerCompat = true;
  };
  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    podman-compose
  ];
}
