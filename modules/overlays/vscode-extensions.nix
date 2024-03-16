{ inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.nixpkgs-vscode-extensions.overlays.default
  ];
}
