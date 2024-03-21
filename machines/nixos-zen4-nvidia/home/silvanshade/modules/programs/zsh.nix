{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
  };

  programs.zsh.initExtra = ''
    if [[ "''${terminfo[kcbt]}" != "" ]]; then
      bindkey "''${terminfo[kcbt]}" reverse-menu-complete   # [Shift-Tab] - Move through the completion menu backwards
    fi

    bindkey '^?' backward-delete-char                       # [Backspace] - Delete backward
    if [[ "''${terminfo[kdch1]}" != "" ]]; then
      bindkey "''${terminfo[kdch1]}" delete-char            # [Delete]    - Delete forward
    else
      bindkey "^[[3~"  delete-char
      bindkey "^[3;5~" delete-char
      bindkey "\e[3~"  delete-char
    fi

    zstyle ':completion:*' menu select
  '';

  programs.zsh.syntaxHighlighting = {
    enable = true;
    highlighters = [
      "main"
      "brackets"
      # NOTE: seems to break cursor display in some cases
      # - https://github.com/sorin-ionescu/prezto/issues/1497
      # - https://github.com/alacritty/alacritty/issues/6323
      # "cursor" # NOTE: seems to break alacritty
    ];
  };
}
