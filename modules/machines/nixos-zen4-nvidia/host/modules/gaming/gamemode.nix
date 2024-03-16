{
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        desiredgov = "performance";
        inhibit_screensaver = 1;
        renice = 20;
      };
      gpu = {
        gpu_device = 0;
        apply_gpu_optimisations = "accept-responsibility";
        nv_powermizer_mode = 2;
      };
      custom = {
        start = "powerprofilesctl set performance";
        end = "powerprofilesctl set balanced";
      };
    };
  };
}
