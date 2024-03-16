{ pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs; [
    elisa
    kate
    konsole
  ];
  environment.sessionVariables = {
    ENABLE_HDR_WSI = "1";
    KWIN_DRM_ALLOW_NVIDIA_COLORSPACE = "1";
    # KWIN_DRM_NO_AMS = "1"; # NOTE: Plasma won't boot with this on recent nvidia drivers
    KWIN_FORCE_SW_CURSOR = "1";
  };
  environment.systemPackages = with pkgs; [
    vulkan-hdr-layer-kwin6
  ];
}
