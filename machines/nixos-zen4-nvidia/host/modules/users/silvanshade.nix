{ pkgs, ... }:

{
  users.users.silvanshade = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [
      "libvirtd"
      "networkmanager"
      "tss"
      "video"
      "wheel"
    ];
    hashedPassword = "$6$Veb.KQMgFPlH9ArX$D7.hDU0hucdPQnIIDU5C8Vk2LDdGAOn8SfqagnnMF9OoNTgG3Rg2yX5oFlw0LNMCS8swFXKmZQiAhX/V.QBh.1";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPr4wxBzbJoY6uLyAowN9uJfLZOiGPW3EdH6WxtepdQf silvanshade@users.noreply.github.com"
    ];
    shell = pkgs.zsh;
  };
}
