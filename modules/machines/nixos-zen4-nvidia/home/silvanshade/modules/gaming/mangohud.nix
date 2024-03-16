{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mangohud
  ];

  home.sessionVariables = {
    MANGOHUD_CONFIGFILE = "\${XDG_CONFIG_HOME}/mangoapp/MangoHud.conf";
  };

  xdg.configFile = {
    "mangohud/MangoHud.conf".text = ''
      fps_limit=117
      gpu_stats
      gpu_temp
      gpu_power
      cpu_stats
      cpu_temp
      cpu_power
      vram
      ram
      swap
      fps
      frametime
      engine_version
      vulkan_driver
      wine
      winesync
      present_mode
      frame_timing
      histogram
      gamemode
      hdr
      refresh_rate
      graphs=gpu_load,cpu_load,vram,ram
      mangoapp_steam
      show_fps_limit
      network=eno2
      text_outline
      output_folder=/home/silvanshade/mangologs
      permit_upload=1
      upload_logs
    '';
  };
}
