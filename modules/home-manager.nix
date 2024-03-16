{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
  home-manager.users.silvanshade = import ./machines/nixos-zen4-nvidia/home/silvanshade;
}
