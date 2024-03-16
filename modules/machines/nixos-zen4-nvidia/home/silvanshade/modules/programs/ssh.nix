{
  programs.ssh.enable = true;

  programs.ssh.userKnownHostsFile = "${../../data/xdg/home/ssh/known_hosts}";
}
