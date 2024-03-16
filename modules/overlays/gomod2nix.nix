{ inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.gomod2nix.overlays.default
  ];
}
