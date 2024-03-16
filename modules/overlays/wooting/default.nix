{
  nixpkgs.overlays = [
    (_final: prev: {
      wooting-udev-rules = prev.wooting-udev-rules.overrideAttrs {
        src = [ ./wooting.rules ];
      };
    })
  ];
}
