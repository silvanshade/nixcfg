{
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
        monospace-font-name = "PragmataPro Mono Liga 11";
      };
      "org/gnome/desktop/wm/preferences" = {
        titlebar-font = "Fira Sans Semi-Bold 10";
      };
      "org/gnome/mutter" = {
        experimental-features = [ "variable-refresh-rate" ];
      };
    };
  };
}
