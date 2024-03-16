rec {
  description = "silvanshade's nix configuration";

  nixConfig = {
    system-features = [
      "gccarch-x86-64-v4"
      "gccarch-znver4"
      "nixos-test"
      "benchmark"
      "big-parallel"
      "kvm"
    ];
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
      "/var/cache/clang-thinlto"
    ];
    extra-substituters = [
      "https://cache.nixos.org"
      "https://cuda-maintainers.cachix.org"
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  inputs = {
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };
    gomod2nix = {
      url = "github:nix-community/gomod2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };
    nix-index-db = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      # inputs.nixpkgs.follows = "nixpkgs"; # NOTE: non-existent
    };
    # nixos-milkv-pioneer = {
    #   url = "github:milkv-community/nixos-milkv-pioneer";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixpkgs = {
      # url = "github:NixOS/nixpkgs/nixos-unstable";
      url = "github:silvanshade/nixpkgs/silvanshade/nixos-unstable";
    };
    nixpkgs-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-xthead-toolchains = {
      url = "github:milkv-community/nixpkgs-xthead-toolchains";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , systems
    , chaotic
    , treefmt-nix
    , ...
    }:
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);
      eachSystemPkgs = overrides: f: eachSystem (system:
        let
          pkgs = import nixpkgs ({ inherit system; } // overrides);
        in
        f pkgs);
      treefmtEval = eachSystem (system: treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix);
    in
    {
      formatter = eachSystem (system: treefmtEval.${system}.config.build.wrapper);

      checks = eachSystem (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });

      packages = eachSystemPkgs { config.allowUnfree = true; } (pkgs: {
        pragmata-pro = pkgs.callPackage ./packages/pragmata-pro.nix { };
      });

      nixosConfigurations = {
        nixos-zen4-nvidia = nixpkgs.lib.nixosSystem
          {
            system = "x86_64-linux";
            specialArgs = { inherit inputs nixConfig; };
            modules = [
              ./modules/nixpkgs.nix
              chaotic.nixosModules.default
              ./modules/overlays
              ./modules/machines/nixos-zen4-nvidia
              ./modules/home-manager.nix
            ];
          };
      };

      devShells = {
        x86_64-linux = with self.nixosConfigurations.nixos-zen4-nvidia; {
          default = pkgs.mkShell {
            CCACHE_MAXSIZE = "0";
            CCACHE_COMPILERCHECK = "content";
            CCACHE_NOHASHDIR = "1";
            CCACHE_SLOPPINESS = "include_file_ctime,include_file_mtime,locale,modules,pch_defines,random_seed,system_headers,time_macros";
            CCACHE_DIR = "$HOME/.cache/ccache";
            nativeBuildInputs = with pkgs; [
              ccache
              clang_19
            ];
          };
        };
      };

      flake = {
        config = {
          ccache =
            let
              common = ''
                export CCACHE_MAXSIZE=0
                export CCACHE_COMPILERCHECK=content
                export CCACHE_NOHASHDIR=1
                export CCACHE_SLOPPINESS=include_file_ctime,include_file_mtime,locale,modules,pch_defines,random_seed,system_headers,time_macros
              '';
            in
            {
              dev = ''
                ${common}
                export CCACHE_DIR="''${XDG_CACHE_DIR:-$HOME/.cache}/ccache"
              '';
              nix = ''
                ${common}
                export CCACHE_DIR="/var/cache/ccache"
                export CCACHE_UMASK=007
                if [ ! -d "$CCACHE_DIR" ]; then
                  echo "====="
                  echo "Directory '$CCACHE_DIR' does not exist"
                  echo "Please create it with:"
                  echo "  sudo mkdir -m0770 '$CCACHE_DIR'"
                  echo "  sudo chown root:nixbld '$CCACHE_DIR'"
                  echo "====="
                  exit 1
                fi
                if [ ! -w "$CCACHE_DIR" ]; then
                  echo "====="
                  echo "Directory '$CCACHE_DIR' is not accessible for user $(whoami)"
                  echo "Please verify its access permissions"
                  echo "====="
                  exit 1
                fi
              '';
            };
        };
      };
    };
}
