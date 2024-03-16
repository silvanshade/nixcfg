{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc14
    # pkgsCross.riscv64.gcc14
    # pkgsCross.riscv64.buildPackages.gcc14
  ];
}
