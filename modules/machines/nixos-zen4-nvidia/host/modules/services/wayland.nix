{
  environment.sessionVariables = {
    CLUTTER_BACKEND = "wayland";
    # CLUTTER_DEFAULT_FPS = "120";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # MOZ_ENABLE_WAYLAND = "1";
    # NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland,x11,windows";
    QT_QPA_PLATFORM = "wayland;xcb";
    # WLR_NO_HARDWARE_CURSORS = "1";
  };
}
