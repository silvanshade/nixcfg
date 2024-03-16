{ config, ... }:

rec {
  programs.git.enable = true;

  programs.git.extraConfig = {
    branch.sort = "-committerdate";
    column.ui = "auto";
    commit = {
      gpgSign = true;
    };
    core = {
      editor = "code --wait";
      excludesfile = "${config.home.homeDirectory}/.gitignore";
      fsmonitor = true;
    };
    fetch = {
      prune = true;
    };
    gpg = {
      format = "ssh";
    };
    gpg.ssh = {
      allowedSignersFile = "${config.home.homeDirectory}/.config/git/allowed_signers";
      program = "op-ssh-sign";
    };
    init = {
      defaultBranch = "main";
    };
    rebase.updateRefs = true;
    user = {
      name = "silvanshade";
      email = "silvanshade@users.noreply.github.com";
      signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPr4wxBzbJoY6uLyAowN9uJfLZOiGPW3EdH6WxtepdQf";
    };
  };

  xdg.configFile = {
    "git/allowed_signers".text = ''
      silvanshade@users.noreply.github.com ${programs.git.extraConfig.user.signingkey}
    '';
  };
}
