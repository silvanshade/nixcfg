{ inputs, ... }:

{
  nixpkgs.overlays = [
    (final: prev:
      let
        inherit (final) ceph;
        cephSupport = false;
        glusterfsSupport = false;
        smbdSupport = false;
        configureFlags = [
          "--enable-avx2"
          "--enable-avx512bw"
          "--enable-avx512f"
        ];
        stdenv =
          let
            stdenvClangWithMold = final.useMoldLinker (prev.withCFlags [
              "-O3"
              "-pipe"
              "-Wl,-z,pack-relative-relocs"
              "-Wno-unused-command-line-argument"
              "-flto=thin"
              "-Wl,--thinlto-cache-dir=/var/cache/clang-thinlto"
            ]
              (prev.impureUseNativeOptimizations final.silvanshade.llvmPackages.stdenv));
          in
          prev.overrideCC stdenvClangWithMold (prev.buildPackages.ccacheWrapper.override {
            inherit (stdenvClangWithMold) cc;
            extraConfig = inputs.self.flake.config.ccache.nix;
          });
      in
      {
        qemu_full = (prev.qemu_full.override {
          inherit ceph cephSupport glusterfsSupport smbdSupport stdenv;
        }).overrideAttrs (prev: {
          env = prev.env // {
            CC = "clang";
            CXX = "clang++";
          };
          configureFlags = prev.configureFlags ++ configureFlags;
        });
        qemu-utils = (prev.qemu-utils.override {
          inherit ceph cephSupport glusterfsSupport smbdSupport stdenv;
        }).overrideAttrs (prev: {
          env = prev.env // {
            CC = "clang";
            CXX = "clang++";
          };
          configureFlags = prev.configureFlags ++ configureFlags;
        });
      })
  ];
}
