{ pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    driSupport = true;
  };

  hardware.opengl.extraPackages = with pkgs; [
    libvdpau-va-gl
    nvidia-vaapi-driver
    vaapiVdpau
  ];

  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [
    libvdpau-va-gl
    nvidia-vaapi-driver
    vaapiVdpau
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false; # NOTE: power management not working yet if true
    package = pkgs.linuxKernel.packages.linux_zen.nvidia_x11;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  boot.kernelParams = [
    "video=HDMI-A-1:3840x2160@120"
    "video=DP-1:d"
    "video=DP-2:d"
    "video=DP-3:d"
    "nvidia-drm.fbdev=1"
    "nvidia-modeset.hdmi_deepcolor=1"
  ];

  services.xserver.videoDrivers = [
    "nvidia"
  ];

  environment.sessionVariables = {
    __GL_GSYNC_ALLOWED = "1";
    __GL_SYNC_DISPLAY_DEVICE = "HDMI-A-1";
    __GL_SYNC_TO_VBLANK = "1";
    __GL_VRR_ALLOWED = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    SDL_VIDEODRIVER = "wayland";
    VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE = "HDMI-A-1";
  };
}
