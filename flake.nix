rec {
  description = "silvanshade's nix configuration";

  nixConfig = {
    accept-flake-config = true;
    extra-access-tokens = [
      "!include /home/silvanshade/.config/nix-access-tokens/github"
    ];
    extra-experimental-features = [
      "flakes"
      "nix-command"
    ];
    extra-sandbox-paths = [
      "/var/cache/ccache"
    ];
    extra-substituters = [
      "https://cache.nixos.org"
      # "https://cosmic.cachix.org/"
      "https://cuda-maintainers.cachix.org"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      # "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      # "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  inputs = {
    flake-compat = {
      url = "github:inclyc/flake-compat";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixos-cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nix-gaming = {
    #   url = "github:fufexan/nix-gaming";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      # inputs.nixpkgs.follows = "nixpkgs"; # NOTE: non-existent
    };
    nixos-milkv-pioneer = {
      url = "github:milkv-community/nixos-milkv-pioneer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs = {
      url = "github:silvanshade/nixpkgs/nixos-unstable";
    };
    nur = {
      url = "github:nix-community/NUR";
      # inputs.nixpkgs.follows = "nixpkgs"; # NOTE: non-existent
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ systems, ... }:
    let
      eachSystem = inputs.nixpkgs.lib.genAttrs (import systems);
      eachSystemPkgs = overrides: f: eachSystem (system:
        let
          pkgs = import inputs.nixpkgs ({ inherit system; } // overrides);
        in
        f pkgs);
      treefmtEval = eachSystem (system: inputs.treefmt-nix.lib.evalModule inputs.nixpkgs.legacyPackages.${system} ./treefmt.nix);
    in
    {
      formatter = eachSystem (system: treefmtEval.${system}.config.build.wrapper);

      checks = eachSystem (system: {
        formatting = treefmtEval.${system}.config.build.check inputs.self;
      });

      packages = eachSystemPkgs { config.allowUnfree = true; } (pkgs: {
        pragmata-pro = pkgs.callPackage ./pkgs/pragmata-pro.nix { };
      });

      nixosConfigurations = {
        nixos-zen4-nvidia = inputs.nixpkgs.lib.nixosSystem
          {
            system = "x86_64-linux";
            specialArgs = { inherit inputs nixConfig; };
            modules = [
              (_: {
                system.stateVersion = "24.05";
                nixpkgs = {
                  config = {
                    allowUnfree = true;
                    cudaSupport = true;
                  };
                  config = {
                    input-fonts.acceptLicense = true;
                    joypixels.acceptLicense = true;
                  };
                };
              })
              # inputs.nixos-cosmic.nixosModules.default
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit inputs; };
              }
              ./hosts/nixos-zen4-nvidia
              {
                home-manager.users.silvanshade = import ./hosts/nixos-zen4-nvidia/users/silvanshade;
              }
            ];
          };
      };
    };
}
