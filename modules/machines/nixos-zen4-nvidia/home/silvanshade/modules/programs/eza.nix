{
  programs.eza.enable = true;

  programs.zsh.shellAliases = {
    "e" = "exa --all --color=auto --classify --icons --long --extended --git --group";
    "eh" = "e --hyperlink";
    "et" = "e --tree";
  };
}
