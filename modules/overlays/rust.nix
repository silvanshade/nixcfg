{ inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    (_final: prev: {
      # FIXME: https://github.com/NixOS/nixpkgs/pull/146274
      rust = prev.rust // {
        toRustTarget = platform:
          if platform.isWasi then
            "${platform.parsed.cpu.name}-wasi"
          else
            platform.rust.rustcTarget or (prev.rust.toRustTarget platform);
      };
    })
  ];
}
