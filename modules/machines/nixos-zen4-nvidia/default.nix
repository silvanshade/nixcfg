{ nixConfig, pkgs, ... }:

{
  nix = {
    package = pkgs.nixVersions.stable;
    settings = nixConfig;
  };

  imports = [
    ./host/modules
  ];
}
