{
  hardware.pulseaudio.enable = false; # NOTE: Needs to be disabled for pipewire.

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
}
