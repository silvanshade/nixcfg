{ inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.nixpkgs-xthead-toolchains.overlays.default
  ];
}
