{ pkgs, ... }:

{
  imports = [
    ./1password.nix
    ./alacritty.nix
    ./discord.nix
    ./eza.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./ssh.nix
    ./starship.nix
    ./steam.nix
    ./tig.nix
    # ./vscode.nix
    # ./wezterm.nix
    ./zellij.nix
    ./zsh.nix
  ];

  home.packages = with pkgs;
    let
      development = [
        armTrustedFirmwareTools
        bear
        bloaty
        ccache
        clang_19
        clang-tools_19
        cmake
        gdb
        ghidra
        gnumake
        lld
        lldb
        mold
        muon
        ninja
        nodejs_22
      ];

      development-rust = [
        cargo-about
        # cargo-binutils
        cargo-bloat
        cargo-cache
        cargo-careful
        cargo-deny
        # cargo-depgraph
        cargo-dephell
        cargo-diet
        cargo-duplicates
        cargo-expand
        cargo-feature
        cargo-kcov
        cargo-lock
        cargo-modules
        cargo-nextest
        cargo-outdated
        cargo-show-asm
        cargo-sort
        cargo-tarpaulin
        cargo-udeps
        cargo-unused-features
        cargo-valgrind
        cargo-whatfeatures
        cargo-wizard
        rustup
      ];

      filesystems = [
        gnome-disk-utility
        nautilus
        guestfs-tools
      ];

      fonts = [
        font-manager
      ];

      graphics = [
        gifsicle
        gimp
        imagemagick
        inkscape-with-extensions
      ];

      media = [
        ffmpeg-full
        # gst_all_1.gst-libav
        # gst_all_1.gst-plugins-bad
        # gst_all_1.gst-plugins-base
        # gst_all_1.gst-plugins-good
        # gst_all_1.gst-plugins-rs
        # gst_all_1.gst-plugins-ugly
        # gst_all_1.gst-vaapi
        # gst_all_1.gstreamer
      ];

      monitoring = [
        # psensor # FIXME: deprecated
        systemdgenie
      ];

      networking = [
        networkmanagerapplet
      ];

      social = [
        discord
        element-desktop
        slack
      ];

      sound = [
        helvum
        pavucontrol
        pwvucontrol
      ];

      theming = [
        adwaita-icon-theme
        gnome-themes-extra
        qt6ct
      ];

      terminal = [
        alacritty.terminfo
        notcurses
        # wezterm.terminfo
      ];

      utilities = [
        copyq
        xdg-utils
      ];

      virtualization = [
        # NOTE: qemu is currently installed system-wide
        # qemu_full
        # qemu-utils
      ];

      web = [
        google-chrome
      ];
    in
    builtins.concatLists [
      development
      development-rust
      filesystems
      fonts
      graphics
      media
      monitoring
      networking
      social
      sound
      theming
      terminal
      utilities
      virtualization
      web
    ];

  programs.atuin.enable = true;

  programs.bat.enable = true;

  programs.bottom.enable = true;

  programs.broot.enable = true;

  programs.carapace.enable = true;

  programs.firefox.enable = true;

  programs.gh.enable = true;

  programs.home-manager.enable = true;

  programs.nix-index-database.comma.enable = true;
  programs.nix-index.enable = true;

  programs.man = {
    generateCaches = true;
  };

  programs.mpv.enable = true;

  programs.ripgrep.enable = true;

  programs.wlogout.enable = true;

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zathura.enable = true;
}
