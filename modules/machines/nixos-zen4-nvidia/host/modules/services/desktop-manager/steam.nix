{
  programs.steam.gamescopeSession = {
    enable = true;
    args = [
      "--rt"
      "--output-width"
      "3840"
      "--output-height"
      "2160"
      "--nested-refresh"
      "120"
      "--adaptive-sync"
      "--hdr-enabled"
      "--hdr-itm-enable"
      "--hdr-itm-sdr-nits"
      "300"
      "--hdr-sdr-content-nits"
      "300"
      "--mangoapp"
    ];
    env = {
      # TODO: might be enabled by default now?
      ENABLE_GAMESCOPE_WSI = "1";
      MANGOHUD_CONFIGFILE = "/home/silvanshade/.config/mangohud/MangoHud.conf";
      # NOTE: fixes freezing on nvidia
      VKD3D_DISABLE_EXTENSIONS = "VK_KHR_present_wait";
    };
  };
}
