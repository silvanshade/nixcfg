{ config, inputs, lib, pkgs, ... }:

{
  nix.package = lib.mkDefault pkgs.nixVersions.nix_2_20;

  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.nix-index-db.hmModules.nix-index
  ];

  home.stateVersion = "24.05";

  home.homeDirectory = "/home/silvanshade";
  home.username = "silvanshade";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    GST_PLUGIN_PATH = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-base
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-plugins-rs
      gst-libav
      gst-vaapi
    ]);
    # NOTE: nuclear option
    GTK_THEME = "Adwaita-dark";
  };

  home.file = {
    "${config.home.homeDirectory}/.gitignore" = {
      source = ./xdg/home/.gitignore;
    };
    "${config.home.homeDirectory}/.vscode/argv.json" = {
      source = ./xdg/home/vscode/argv.json;
    };
    "${config.home.homeDirectory}/.local/bin/zellij-copyq.sh" = {
      source = ./xdg/local/bin/zellij-copyq.sh;
      executable = true;
    };
  };

  xdg.enable = true;
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.portal.enable = true;

  xdg.configFile = {
    # "ccache/ccache.conf".source = ./xdg/config/ccache/ccache.conf;

    "dunst/dunstsrc".source = ./xdg/config/dunst/dunstsrc;

    "git/allowed_signers".text = ''
      silvanshade@users.noreply.github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPr4wxBzbJoY6uLyAowN9uJfLZOiGPW3EdH6WxtepdQf
    '';

    "hypr/scripts/start.sh" = {
      source = ./xdg/config/hypr/scripts/start.sh;
      executable = true;
    };

    "hypr/scripts/stop.sh" = {
      source = ./xdg/config/hypr/scripts/stop.sh;
      executable = true;
    };

    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";

    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";

    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";

    "waybar/config.jsonc".source = ./xdg/config/waybar/config.jsonc;

    "waybar/style.css".source = ./xdg/config/waybar/style.css;

    "wezterm/wezterm.lua".source = ./xdg/config/wezterm/wezterm.lua;

    "zellij/config.kdl".source = ./xdg/config/zellij/config.kdl;
  };

  xdg.portal = {
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  xdg.portal.config.hyprland = {
    default = [
      "hyprland"
      "gtk"
    ];
    "org.freedesktop.impl.portal.Secret" = [
      "gnome-keyring"
    ];
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-theme = "Adwaita";
        document-font-name = "Roboto Slab 11";
        font-antialiasing = "rgba";
        font-hinting = "slight";
        font-name = "Fira Sans Light 10";
        gtk-theme = "Adwaita-dark";
        icon-theme = "Adwaita";
        # monospace-font-name = "Fira Code 11";
        monospace-font-name = "PragmataPro Mono Liga 11";
      };
      "org/gnome/desktop/wm/preferences" = {
        titlebar-font = "Fira Sans Semi-Bold 10";
      };
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = "adwaita-dark";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Adwaita";
    size = 32;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
    extraConfig = builtins.readFile ./xdg/config/hypr/hyprland.conf;
  };

  services.mpris-proxy.enable = true;

  systemd.user.services = {
    polkit-authentication-agent = {
      Unit = {
        BindsTo = [ "hyprland-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };
      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "always";
      };
      Install.WantedBy = [ "hyprland-session.target" ];
    };
  };

  home.packages = with pkgs; [
    alacritty.terminfo
    # ccache
    clang
    clang-tools
    cmake
    copyq
    dconf
    discord
    dunst
    element-desktop
    ffmpeg-full
    font-manager
    # gcc_multi
    gdb
    # gef
    gifsicle
    gimp
    google-chrome
    # gnome.gnome-disk-utility
    gparted
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-rs
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
    gst_all_1.gstreamer
    guestfs-tools
    helvum
    heroic
    hyprdim
    imagemagick
    inkscape-with-extensions
    jq
    lld
    lldb
    lutris
    mold
    networkmanagerapplet
    ninja
    nodejs_21
    notcurses
    pavucontrol
    psensor
    pwvucontrol
    python312
    qt6ct
    rofi-wayland
    qemu_full
    qemu-utils
    rustup
    slack
    wezterm.terminfo
    xdg-utils
  ];

  programs.alacritty.enable = true;

  programs.atuin.enable = true;

  programs.bat.enable = true;

  programs.bottom.enable = true;

  programs.broot.enable = true;

  programs.carapace.enable = true;

  programs.eza.enable = true;

  programs.firefox.enable = true;

  programs.gh.enable = true;

  programs.git = {
    enable = true;
    extraConfig = {
      commit.gpgSign = true;
      core = {
        editor = "code --wait";
        excludesfile = "${config.home.homeDirectory}/.gitignore";
        fsmonitor = true;
      };
      fetch = {
        prune = true;
      };
      gpg.format = "ssh";
      gpg.ssh = {
        allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
        program = "op-ssh-sign";
      };
      init.defaultBranch = "main";
      user = {
        name = "silvanshade";
        email = "silvanshade@users.noreply.github.com";
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPr4wxBzbJoY6uLyAowN9uJfLZOiGPW3EdH6WxtepdQf";
      };
    };
  };

  programs.gpg = {
    enable = true;
    publicKeys = [
      {
        source = ./gpg/public_keys/llvm.asc;
        trust = "ultimate";
      }
    ];
  };

  programs.helix.enable = true;

  programs.home-manager.enable = true;

  programs.nix-index-database.comma.enable = true;
  programs.nix-index.enable = true;

  programs.man = {
    generateCaches = true;
  };

  programs.mpv.enable = true;

  programs.ripgrep.enable = true;

  programs.ssh = {
    enable = true;
    userKnownHostsFile = "${./xdg/home/ssh/known_hosts}";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.vscode = {
    enable = true;
  };

  programs.waybar.enable = true;

  programs.wlogout.enable = true;

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zathura.enable = true;

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    initExtra = ''
      if [[ "''${terminfo[kcbt]}" != "" ]]; then
        bindkey "''${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - Move through the completion menu backwards
      fi

      bindkey '^?' backward-delete-char                       # [Backspace] - Delete backward
      if [[ "''${terminfo[kdch1]}" != "" ]]; then
        bindkey "''${terminfo[kdch1]}" delete-char            # [Delete]    - Delete forward
      else
        bindkey "^[[3~"  delete-char
        bindkey "^[3;5~" delete-char
        bindkey "\e[3~"  delete-char
      fi

      zstyle ':completion:*' menu select
    '';
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        # NOTE: seems to break cursor display in some cases
        # - https://github.com/sorin-ionescu/prezto/issues/1497
        # - https://github.com/alacritty/alacritty/issues/6323
        # "cursor" # NOTE: seems to break alacritty
      ];
    };
    shellAliases = {
      "exx" = "exa --color=auto --classify=auto --hyperlink --icons=auto --long --extended --git --smart-group";
    };
  };
}
