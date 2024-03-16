{ inputs, config, ... }:

{
  nixpkgs.overlays = [
    # FIXME: limit this change to only `linuxPackages_cachyos-lto-ccache-znver4`
    (_final: prev: {
      makeModulesClosure = args: (prev.makeModulesClosure args).overrideAttrs (attrs: {
        allowedReferences = attrs.allowedReferences ++ [
          # NOTE: without this allowance, nvidia drivers will fail to build with open modules
          config.boot.kernelPackages.kernel.dev
        ];
      });
    })
    (final: _prev: {
      linuxPackages_cachyos-lto-ccache-znver4 = final.pkgsAMD64Microarchs.znver4.linuxPackages_cachyos-lto.override (linuxPackagesArgs: {
        linuxPackagesFor = kernel: linuxPackagesArgs.linuxPackagesFor (
          let
            llvmPackages_latest = final.llvmPackages_19.override {
              bootBintools = null;
              bootBintoolsNoLibc = null;
            };
            cflags = [
              "-march=znver4"
              "-Wl,-z,pack-relative-relocs"
              "-Wl,--thinlto-cache-dir=/var/cache/clang-thinlto"
              "-Wno-unused-command-line-argument"
            ];
          in
          (kernel.override (kernelArgs: {
            stdenv = kernelArgs.stdenv.override (stdenvArgs: {
              inherit llvmPackages_latest;
              overrideCC = stdenv': cc': stdenvArgs.overrideCC
                (
                  final.withCFlags cflags stdenv'
                )
                (final.buildPackages.ccacheWrapper.override {
                  cc = cc';
                  extraConfig = inputs.self.flake.config.ccache.nix;
                });
            });
          })
          ).overrideAttrs
            (kernelAttrs:
              let
                inherit (final.linuxPackages_cachyos-lto-ccache-znver4.kernel.stdenv) cc;
              in
              {
                makeFlags = kernelAttrs.makeFlags ++ [
                  "KCFLAGS+=-O3"
                  "KCFLAGS+=-march=znver4"
                  "KBUILD_LDFLAGS+=-zpack-relative-relocs"
                  "KBUILD_LDFLAGS+=--thinlto-cache-dir=/var/cache/clang-thinlto"
                  "CC=${cc}/bin/clang"
                  "CXX=${cc}/bin/clang++"
                  "HOSTCC=${cc}/bin/clang"
                  "HOSTCXX=${cc}/bin/clang++"
                ];
              })
        );
      });
    })
  ];
}
