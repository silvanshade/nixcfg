{ lib, stdenvNoCC, ... }:

let
  version = "0.830";
  url = "file:///opt/share/nix/assets/PragmataPro${version}.tar.zst";
in
stdenvNoCC.mkDerivation {
  pname = "pragmata-pro";
  inherit version;

  src = builtins.fetchTarball {
    inherit url;
    sha256 = "1g32lq7jx3j74v0w17mlj0jyg1yqx2q1bhlhj1mvmsri1rqlm76n";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 "OTF-CFF fonts (optional)"/*.otf -t $out/share/fonts/opentype

    runHook postInstall
  '';

  meta = {
    description = "PragmataPro™ is a condensed monospaced font optimized for screen, designed by Fabrizio Schiavi to be the ideal font for coding, math and engineering";
    homepage = "https://fsd.it/shop/fonts/pragmatapro/";
    license = lib.licenses.unfree;
    platforms = lib.platforms.all;
  };
}
