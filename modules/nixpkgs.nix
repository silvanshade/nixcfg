{
  imports = [
    {
      system.stateVersion = "24.05";
      nixpkgs = {
        config = {
          allowUnfree = true;
          allowUnsupportedSystems = true;
          cudaSupport = true;
          # enableParallelBuildingByDefault = true;
        };
        config = {
          input-fonts.acceptLicense = true;
          joypixels.acceptLicense = true;
        };
        # config.replaceStdenv = { pkgs, ... } @ args: flake.${pkgs.system}.nixCaching.stdenv;
      };
    }
  ];
}
