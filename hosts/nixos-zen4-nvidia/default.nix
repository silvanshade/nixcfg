{ inputs, nixConfig, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings = nixConfig;
  };

  imports = [
    # inputs.nix-gaming.nixosModules.pipewireLowLatency
    ./hardware-configuration.nix
  ];

  time.timeZone = "America/Denver";

  i18n.defaultLocale = "en_US.UTF-8";

  boot.initrd = {
    verbose = false;
    systemd = {
      enable = true;
      dbus.enable = true;
      network.enable = true;
      services."systemd-udevd" = {
        after = [
          "systemd-modules-load.service"
        ];
      };
    };
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot = {
    # consoleLogLevel = 0;
    kernelParams = [
      # "quiet"
      # "rd.systemd.show_status=auto"
      # "rd.udev.log_level=3"
      # "systemd.show_status=auto"
      # "udev.log_level=3"
      "video=HDMI-A-1:3840x2160@120"
      "video=DP-1:d"
      "video=DP-2:d"
      "video=DP-3:d"
      # "splash"
      "nvidia-drm.fbdev=1"
      # "fbcon=nodefer"
    ];
    # plymouth = {
    #   enable = true;
    #   font = "${inputs.self.packages.${pkgs.system}.pragmata-pro}/share/fonts/opentype/PragmataPro_Mono_R_liga_0830.otf";
    # };
  };

  # console = {
  #   earlySetup = true;
  #   useXkbConfig = true;
  # };

  hardware.enableAllFirmware = true;

  # hardware.bluetooth = {
  #   # enable = true; # implied by services.gnome.core-os-services
  # };

  hardware.cpu.amd.updateMicrocode = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    driSupport = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
      nvidia-vaapi-driver
      vaapiVdpau
    ];
    extraPackages32 = with pkgs; [
      pkgsi686Linux.libvdpau-va-gl
      pkgsi686Linux.nvidia-vaapi-driver
      pkgsi686Linux.vaapiVdpau
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false; # NOTE: power management not working yet if true
    package = pkgs.linuxKernel.packages.linux_zen.nvidia_x11;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  hardware.pulseaudio.enable = false; # NOTE: Needs to be disabled for pipewire.

  hardware.usb-modeswitch.enable = true;

  powerManagement.cpuFreqGovernor = "ondemand";

  networking.hostName = "nixos-zen4";

  # networking.networkmanager.enable = true; # implied by services.gnome.core-os-services

  # virtualisation.docker = {
  #   enable = true;
  #   rootless = {
  #     enable = true;
  #     setSocketVariable = true;
  #   };
  # };
  # virtualisation.libvirtd.enable = true;

  # security.apparmor.enable = true;

  security.rtkit.enable = true;

  security.sudo-rs.enable = true;

  # security.tpm2 = {
  #   enable = true;
  #   pkcs11.enable = true;
  #   tctiEnvironment.enable = true;
  # };

  # services.accounts-daemon.enable = true; # implied by services.gnome.core-os-services

  services.autosuspend = {
    enable = true;
    settings = {
      interval = 30;
      idle_time = 900;
    };
    # FIXME: figure out how to integrate this with hypridle
    checks = {
      # ActiveCalendarEvent.enabled = true; # FIXME: requires `url`
      Load.enabled = true;
      # Mpd.enabled = true;
      NetworkBandwidth = {
        enabled = true;
        interfaces = "eno2";
        threshold_send = 1024;
        threshold_receive = 1024;
      };
      # Smb.enabled = true;
    };
  };

  services.blueman.enable = true;

  services.dbus = {
    enable = true;
    # apparmor = "enabled"; # "required"
  };

  # services.flatpak.enable = true;

  services.fwupd.enable = true;

  services.gnome = {
    core-developer-tools.enable = false;
    core-os-services.enable = true;
    core-shell.enable = true;
    core-utilities.enable = true;
    games.enable = false;
    # at-spi2-core.enable = true;   # implied by services.gnome.core-os-services
    # gnome-keyring.enable = true;  # implied by services.gnome.core-os-services
    # sushi.enable = true;          # implied by services.gnome.core-utilites
    # tracker.enable = true;        # implied by services.gnome.core-os-services
    # tracker-miners.enable = true; # implied by services.gnome.core-os-services
  };

  services.gpm = {
    enable = true;
    protocol = "imps2";
  };

  # gvfs.enable = true; # implied by services.gnome.core-shell

  # services.hardware.bolt.enable = true; # implied by services.gnome.core-os-services

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # lowLatency.enable = true;
  };

  services.xserver.enable = true;

  services.xserver.videoDrivers = [
    "nvidia"
  ];

  services.xserver.xkb = {
    layout = "us";
    model = "apple";
    options = "compose:ralt,terminate:ctrl_alt_bksp";
  };

  services.xserver.exportConfiguration = true;

  services.xserver.updateDbusEnvironment = true;

  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.displayManager = {
    defaultSession = "hyprland";
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  # services.desktopManager.cosmic.enable = true;
  # services.displayManager.cosmic-greeter.enable = true;

  systemd.targets = {
    sleep.enable = true;
    suspend.enable = true;
    hibernate.enable = true;
    hybrid-sleep.enable = true;
  };

  systemd.services.enable-extra-monitors = {
    wantedBy = [
      "display-manager.service"
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/sh -c 'echo on > /sys/class/drm/card0-DP-3/status'";
    };
  };

  systemd.services.usb-reset = {
    description = "Reset USB devices on resume";
    wantedBy = [
      "post-resume.target"
    ];
    after = [
      "post-resume.target"
    ];
    path = with pkgs; [
      bash
      pciutils
      uhubctl
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${./scripts/reset-usb.sh}";
    };
  };

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
  };

  environment.sessionVariables = {
    __GL_GSYNC_ALLOWED = "1";
    __GL_SYNC_DISPLAY_DEVICE = "HDMI-A-1";
    __GL_SYNC_TO_VBLANK = "1";
    __GL_VRR_ALLOWED = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    CLICOLOR = "1";
    CLUTTER_BACKEND = "wayland";
    CLUTTER_DEFAULT_FS = "120";
    EDITOR = "hx";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    GBM_BACKEND = "nvidia-drm";
    GDK_BACKEND = "wayland,x11";
    LIBVA_DRIVER_NAME = "nvidia";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    PAGER = "less";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    SDL_VIDEODRIVER = "wayland";
    VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE = "HDMI-A-1";
    VISUAL = "code --wait";
    WLR_NO_HARDWARE_CURSORS = "1";
    XCURSOR_SIZE = "24";
  };

  environment.systemPackages = with pkgs; [
    bore-cli
    btop
    clinfo
    cntr
    comma
    corectrl
    coreutils-full
    curl
    deadnix
    dust
    fd
    file
    formatjson5
    gibo
    git
    glxinfo
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    gpu-viewer
    hyperfine
    i2c-tools
    jsonfmt
    libva-utils
    lm_sensors
    magic-wormhole-rs
    manix
    mdformat
    mesa-demos
    mosh
    nil
    nix-doc
    nix-melt
    nix-output-monitor
    nix-top
    nix-tree
    nixpkgs-fmt
    nurl
    nvtop
    pciutils
    procs
    sd
    shellcheck
    shfmt
    socat
    statix
    stylua
    taplo
    uhubctl
    usbutils
    vdpauinfo
    vrrtest
    vulkan-tools
    yamlfmt
    xh
    inputs.nixos-milkv-pioneer.packages.${pkgs.system}.milkv-pioneer-bsp-edk2
    inputs.nixos-milkv-pioneer.packages.${pkgs.system}.milkv-pioneer-bsp-linux
    inputs.nixos-milkv-pioneer.packages.${pkgs.system}.milkv-pioneer-bsp-opensbi
    inputs.nixos-milkv-pioneer.packages.${pkgs.system}.milkv-pioneer-bsp-zsbl
  ];

  environment.gnome.excludePackages = (with pkgs; [
    gedit
    gnome-connections
    gnome-console
    gnome-photos
    gnome-text-editor
    gnome-tour
    snapshot
    yelp
  ]) ++ (with pkgs.gnome; [
    epiphany
    evince
    geary
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-terminal
    gnome-weather
    hitori
    iagno
    simple-scan
    tali
    totem
  ]);

  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    fontconfig = {
      enable = true;
      allowBitmaps = true;
      antialias = true;
      cache32Bit = true;
      hinting = {
        enable = true;
        autohint = false;
        style = "slight";
      };
      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
      useEmbeddedBitmaps = true;
      defaultFonts = {
        monospace = [
          "PragmataPro Mono Liga"
          "FiraCode Nerd Font"
        ];
        sansSerif = [
          "Fira Sans"
        ];
        serif = [
          "Roboto Slab"
        ];
      };
    };
    packages = with pkgs; [
      andika
      ankacoder
      anonymousPro
      azeret-mono
      bakoma_ttf
      behdad-fonts
      brill
      bront_fonts
      cantarell-fonts
      cascadia-code
      ccsymbols
      charis-sil
      cm_unicode
      corefonts
      cozette
      culmus
      dejavu_fonts
      dosemu_fonts
      dotcolon-fonts
      doulos-sil
      emacs-all-the-icons-fonts
      eurofurence
      fira-code-nerdfont
      font-awesome
      freefont_ttf
      google-fonts
      gyre-fonts
      hannom
      helvetica-neue-lt-std
      hubot-sans
      ibm-plex
      inconsolata-nerdfont
      input-fonts
      inriafonts
      # iosevka
      ipaexfont
      ipafont
      ir-standard-fonts
      joypixels
      kacst
      khmeros
      kochi-substitute
      # NOTE: causes build to freeze?
      # kochi-substitute-naga10
      kreative-square-fonts
      lalezar-fonts
      league-of-moveable-type
      lohit-fonts.assamese
      lohit-fonts.bengali
      lohit-fonts.devanagari
      lohit-fonts.gujarati
      lohit-fonts.gurmukhi
      lohit-fonts.kannada
      lohit-fonts.kashmiri
      lohit-fonts.konkani
      lohit-fonts.maithili
      lohit-fonts.malayalam
      lohit-fonts.marathi
      lohit-fonts.nepali
      lohit-fonts.odia
      lohit-fonts.sindhi
      lohit-fonts.tamil
      lohit-fonts.tamil-classical
      lohit-fonts.telugu
      liberation-sans-narrow
      liberation_ttf
      libertine
      libertinus
      libre-bodoni
      libre-caslon
      line-awesome
      migmix
      migu
      mona-sans
      monaspace
      mplus-outline-fonts.osdnRelease
      nahid-fonts
      nanoemoji
      nerdfonts
      newcomputermodern
      nika-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      noto-fonts-lgc-plus
      open-fonts
      open-sans
      orbitron
      oxygenfonts
      powerline-fonts
      inputs.self.packages.${pkgs.system}.pragmata-pro
      proggyfonts
      redhat-official-fonts
      roboto
      roboto-mono
      roboto-serif
      rubik
      sahel-fonts
      samim-fonts
      sarabun-font
      shabnam-fonts
      spleen
      stix-otf
      stix-two
      swaycons
      takao
      tamzen
      terminus-nerdfont
      textfonts
      tlwg
      ttf-tw-moe
      typodermic-free-fonts
      typodermic-public-domain
      ucs-fonts
      ultimate-oldschool-pc-font-pack
      unfonts-core
      unscii
      uw-ttyp0
      wine64Packages.fonts
      wineWowPackages.fonts
      wineWow64Packages.fonts
      xits-math
      vazir-fonts
      vdrsymbols
      vistafonts
      vistafonts-chs
      zilla-slab
    ];
  };

  programs._1password.enable = true;

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [
      "silvanshade"
    ];
  };

  programs.gamemode.enable = true;

  # NOTE: Gamescope fails modeset on HDMI-A-1 so just disable it for now.
  # programs.gamescope = {
  #   enable = true;
  #   capSysNice = true;
  #   args = [
  #     "--output-width 3840"
  #     "--output-height 2160"
  #     "--nested-refresh 120"
  #     "--expose-wayland"
  #     "--rt"
  #     "--prefer-vk-device 10de:2684"
  #     "--framerate-limit 117"
  #     "--borderless"
  #   ];
  # };

  programs.hyprland.enable = true;

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    # NOTE: Gamescope fails modeset on HDMI-A-1 so just disable it for now.
    # gamescopeSession = {
    #   enable = true;
    #   args = [
    #     "--output-width 3840"
    #     "--output-height 2160"
    #     "--nested-refresh 120"
    #     "--expose-wayland"
    #     "--rt"
    #     "--prefer-vk-device 10de:2684"
    #     "--framerate-limit 117"
    #     "--immediate-flips"
    #     "--adaptive-sync"
    #   ];
    # };
  };

  programs.virt-manager.enable = true;

  programs.zsh.enable = true;

  users.mutableUsers = false;

  users.users.silvanshade = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [
      "libvirtd"
      "networkmanager"
      "tss"
      "video"
      "wheel"
    ];
    hashedPassword = "$6$Veb.KQMgFPlH9ArX$D7.hDU0hucdPQnIIDU5C8Vk2LDdGAOn8SfqagnnMF9OoNTgG3Rg2yX5oFlw0LNMCS8swFXKmZQiAhX/V.QBh.1";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPr4wxBzbJoY6uLyAowN9uJfLZOiGPW3EdH6WxtepdQf silvanshade@users.noreply.github.com"
    ];
    shell = pkgs.zsh;
  };
}
