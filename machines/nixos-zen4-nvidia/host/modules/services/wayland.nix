{
  environment.sessionVariables = {
    CLUTTER_BACKEND = "wayland";
    CLUTTER_DEFAULT_FS = "120";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
