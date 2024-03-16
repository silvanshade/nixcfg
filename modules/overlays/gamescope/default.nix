{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (_final: prev: {
      gamescope = prev.gamescope.overrideAttrs (attrs: {
        version = "3.15.13-master";
        src = pkgs.fetchFromGitHub {
          owner = "ValveSoftware";
          repo = "gamescope";
          rev = "056b79e5f8a40568bb7e7927ce77868f243a3d3e";
          fetchSubmodules = true;
          hash = "sha256-v74UOa4byaiIEKtb3u73pcOziEeEYBRbdhe6BIdN7eE=";
        };
        patches = [
          ./patches/gamescopereaper.patch
          ./patches/install-script-shebang.patch
          ./patches/shaders-path.patch
        ];
        buildInputs = attrs.buildInputs ++ [ pkgs.luajit ];
      });
      # gamescope = prev.gamescope.overrideAttrs (attrs: {
      #   version = "3.15.3-master";
      #   src = /home/silvanshade/Development/silvanshade/gamescope;
      #   patches = [ ];
      #   buildInputs = attrs.buildInputs ++ [ pkgs.luajit ];
      # });
    })
  ];
}
