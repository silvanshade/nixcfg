{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto-ccache-znver4;
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_cachyos;
  chaotic.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
}
