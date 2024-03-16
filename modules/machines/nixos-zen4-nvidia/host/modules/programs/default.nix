{ pkgs, ... }:

{
  imports = [
    ./vscode.nix
    ./zed-editor.nix
  ];

  programs._1password.enable = true;

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [
      "silvanshade"
    ];
  };

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

      development = [
        go
        python312
      ];

      documentation = [
        tealdeer
      ];

      file-tools = [
        file
        helix
        hexyl
        jless
        repgrep
        ripgrep-all
        sd
      ];

      filesystems = [
        eza
        fd
        dua
        dust
      ];

      hardware-tools-general = [
        dmidecode
        ethtool
        i2c-tools
        lm_sensors
        lshw
        pciutils
        thunderbolt
        uhubctl
        usb-modeswitch
        usbutils
      ];

      hardware-tools-graphics = [
        clinfo
        glxinfo
        gpu-viewer
        libva-utils
        # mangohud
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
        # procmux # TODO: Define package
        # tcpterm # TODO: Define package
        termshark
        trippy
        viddy
      ];

      networking = [
        bore-cli
        croc
        curl
        jq
        magic-wormhole-rs
        mosh
        netop
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
        b4
        gibo
        git
        stgit
        tig
      ];

      virtualization = [
        # qemu_full
        # qemu-utils
      ];
    in
    builtins.concatLists [
      benchmarking
      containers
      core
      development
      documentation
      file-tools
      filesystems
      hardware-tools-general
      hardware-tools-graphics
      linting-and-formatting
      monitoring
      networking
      nix-tools
      version-control
      virtualization
    ]
    # ++ (with inputs.nixos-milkv-pioneer.packages.${pkgs.system}; [
    #   milkv-pioneer-bsp-edk2
    #   milkv-pioneer-bsp-linux
    #   milkv-pioneer-bsp-opensbi
    #   milkv-pioneer-bsp-zsbl
    # ])
  ;
}
