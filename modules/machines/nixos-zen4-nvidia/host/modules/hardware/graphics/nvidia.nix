{ config, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # hardware.graphics.extraPackages = with pkgs; [
  #   libvdpau-va-gl
  #   mangohud
  #   nvidia-vaapi-driver
  #   vaapiVdpau
  # ];

  # hardware.graphics.extraPackages32 = with pkgs.pkgsi686Linux; [
  #   libvdpau-va-gl
  #   mangohud
  #   nvidia-vaapi-driver
  #   vaapiVdpau
  # ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true; # FIXME: causes closure issue?
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "565.57.01";
      sha256_64bit = "sha256-buvpTlheOF6IBPWnQVLfQUiHv4GcwhvZW3Ks0PsYLHo=";
      sha256_aarch64 = "sha256-aDVc3sNTG4O3y+vKW87mw+i9AqXCY29GVqEIUlsvYfE=";
      openSha256 = "sha256-/tM3n9huz1MTE6KKtTCBglBMBGGL/GOHi5ZSUag4zXA=";
      settingsSha256 = "sha256-H7uEe34LdmUFcMcS6bz7sbpYhg9zPCb/5AmZZFTx1QA=";
      persistencedSha256 = "sha256-hdszsACWNqkCh8G4VBNitDT85gk9gJe1BlQ8LdrYIkg=";
    };
    # package = config.boot.kernelPackages.nvidia_x11;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  services.xserver.videoDrivers = [
    "nvidia"
  ];

  environment.sessionVariables = {
    __GL_GSYNC_ALLOWED = "1";
    __GL_SYNC_DISPLAY_DEVICE = "HDMI-A-1";
    # __GL_SYNC_TO_VBLANK = "1";
    __GL_VRR_ALLOWED = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    DXVK_HDR = 1;
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE = "HDMI-A-1";
  };
}
