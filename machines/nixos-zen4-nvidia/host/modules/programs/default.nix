{ inputs, pkgs, ... }:

{
  programs._1password.enable = true;

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [
      "silvanshade"
    ];
  };

  programs.hyprland.enable = true;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs;
    let
      benchmarking = [
        hyperfine
      ];

      containers = [
        cntr
      ];

      core = [
        comma
        coreutils-full
        moreutils
      ];

      editing = [
        helix
        repgrep
        sd
      ];

      files-and-search = [
        eza
        fd
        dust
        file
        ripgrep-all
      ];

      hardware-tools-general = [
        ethtool
        i2c-tools
        lm_sensors
        pciutils
        uhubctl
        usbutils
      ];

      hardware-tools-graphics = [
        clinfo
        glxinfo
        gpu-viewer
        libva-utils
        mesa-demos
        vdpauinfo
        vrrtest
        vulkan-tools
      ];

      linting-and-formatting = [
        deadnix
        formatjson5
        jsonfmt
        mdformat
        nixpkgs-fmt
        shellcheck
        shfmt
        statix
        stylua
        taplo
        yamlfmt
      ];

      monitoring = [
        bandwhich
        btop
        htop
        iperf
        nvtopPackages.nvidia
        procs
      ];

      networking = [
        bore-cli
        croc
        curl
        jq
        magic-wormhole-rs
        mosh
        socat
        xh
      ];

      nix-tools = [
        gomod2nix
        nil
        nix-doc
        nix-melt
        nix-output-monitor
        nix-top
        nix-tree
        nurl
        manix
      ];

      version-control = [
        gibo
        git
        stgit
      ];

    in
    builtins.concatLists [
      benchmarking
      containers
      core
      editing
      files-and-search
      hardware-tools-general
      hardware-tools-graphics
      linting-and-formatting
      monitoring
      networking
      nix-tools
      version-control
    ] ++ (with inputs.nixos-milkv-pioneer.packages.${pkgs.system}; [
      milkv-pioneer-bsp-edk2
      milkv-pioneer-bsp-linux
      milkv-pioneer-bsp-opensbi
      milkv-pioneer-bsp-zsbl
    ]);
}
