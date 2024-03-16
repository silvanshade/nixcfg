{ pkgs, ... }:

{
  environment.systemPackages =
    let
      zed-editor = pkgs.zed-editor.fhsWithPackages (ps: with ps; [
        bear
        ccache
        clang_19
        clang-tools_19
        cmake
        gcc14
        gdb
        lld_19
        lldb_19
        mold
        ninja
        openssl.dev
        pkg-config
        rustup
        zlib
      ]);
    in
    [
      zed-editor
    ];
}
