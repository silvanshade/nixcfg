{ inputs, lib, pkgs, ... }:

{
  nix.package = lib.mkDefault pkgs.nixVersions.nix_2_20;

  imports = [
    inputs.nix-index-db.hmModules.nix-index
    ./modules
  ];

  home.stateVersion = "24.05";
  home.homeDirectory = "/home/silvanshade";
  home.username = "silvanshade";
}
