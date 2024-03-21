{
  programs.gpg.enable = true;

  programs.gpg.publicKeys = [
    {
      source = ../../data/gpg/public_keys/llvm.asc;
      trust = "ultimate";
    }
  ];
}
