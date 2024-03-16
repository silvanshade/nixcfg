# { inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    # (final: prev: {
    #   silvanshade = {
    #     llvmPackages = prev.llvmPackages_19.override {
    #       stdenv =
    #         let
    #           stdenvClangWithMold = final.useMoldLinker (prev.withCFlags [
    #             "-O3"
    #             "-pipe"
    #             "-Wl,-z,pack-relative-relocs"
    #             "-Wno-unused-command-line-argument"
    #             "-flto=thin"
    #             "-Wl,--thinlto-cache-dir=/var/cache/clang-thinlto"
    #           ]
    #             (prev.impureUseNativeOptimizations prev.llvmPackages_19.stdenv));
    #         in
    #         prev.overrideCC stdenvClangWithMold (prev.buildPackages.ccacheWrapper.override {
    #           inherit (stdenvClangWithMold) cc;
    #           extraConfig = inputs.self.flake.config.ccache.nix;
    #         });
    #     };
    #   };
    # })
  ];
}
