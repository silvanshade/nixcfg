{ nixConfig, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings = nixConfig;
  };

  imports = [
    ./host/modules
  ];
}
