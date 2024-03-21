{ config, ... }:

{
  home.file = {
    "${config.home.homeDirectory}/.gitignore" = {
      source = ../../data/xdg/home/.gitignore;
    };
    "${config.home.homeDirectory}/.vscode/argv.json" = {
      source = ../../data/xdg/home/vscode/argv.json;
    };
    "${config.home.homeDirectory}/.local/bin/zellij-copyq.sh" = {
      source = ../../data/xdg/local/bin/zellij-copyq.sh;
      executable = true;
    };
  };
}
