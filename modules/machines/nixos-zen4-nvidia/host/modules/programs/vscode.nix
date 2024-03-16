{ pkgs, ... }:

{
  environment.systemPackages =
    let
      # vscode = pkgs.vscode-with-extensions.override {
      #   vscodeExtensions = with pkgs.vscode-marketplace; [
      #     chrislajoie.vscode-modelines
      #     eamodio.gitlens
      #     editorconfig.editorconfig
      #     esbenp.prettier-vscode
      #     github.copilot
      #     github.copilot-chat
      #     github.github-vscode-theme
      #     github.vscode-github-actions
      #     github.vscode-pull-request-github
      #     jnoortheen.nix-ide
      #     llvm-vs-code-extensions.vscode-clangd
      #     maelvalais.autoconf
      #     mesonbuild.mesonbuild
      #     modular-mojotools.vscode-mojo
      #     ms-vscode-remote.remote-containers
      #     ms-vscode-remote.vscode-remote-extensionpack
      #     ms-vscode.cmake-tools
      #     ms-vscode.cpptools
      #     ms-vscode.cpptools-extension-pack
      #     ms-vscode.cpptools-themes
      #     ms-vscode.hexeditor
      #     rust-lang.rust-analyzer
      #     stkb.rewrap
      #     tamasfe.even-better-toml
      #     timonwong.shellcheck
      #     twxs.cmake
      #     usernamehw.errorlens
      #     vadimcn.vscode-lldb
      #   ];
      # };
      vscode = pkgs.vscode.fhsWithPackages (ps: with ps; [
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
      vscode
    ];
}
