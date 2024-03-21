{ pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./dunst.nix
    ./eza.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./ssh.nix
    ./starship.nix
    ./vscode.nix
    ./waybar.nix
    ./wezterm.nix
    ./zellij.nix
    ./zsh.nix
  ];

  home.packages = with pkgs;
    let
      development = [
        clang
        clang-tools
        cmake
        gdb
        lld
        lldb
        mold
        ninja
        nodejs_21
        python312
        rustup
      ];

      files-and-disks = [
        gnome.gnome-disk-utility
        gnome.nautilus
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
        psensor
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
        gnome.adwaita-icon-theme
        gnome.gnome-themes-extra
        qt6ct
      ];

      terminal = [
        alacritty.terminfo
        # wezterm.terminfo
        notcurses
      ];

      utilities = [
        copyq
        rofi-wayland
        dconf
        xdg-utils
      ];

      virtualization = [
        # qemu_full
        # qemu-utils
      ];

      web = [
        google-chrome
      ];
    in
    builtins.concatLists [
      development
      files-and-disks
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
