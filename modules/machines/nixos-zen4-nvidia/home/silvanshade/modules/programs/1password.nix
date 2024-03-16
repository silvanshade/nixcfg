{
  # TODO: check if 1password is enabled before writing this
  xdg.configFile = {
    "autostart/1password.desktop".text = ''
      [Desktop Entry]
      Name=1Password (Silent)
      Exec=1password --silent %U
      Terminal=false
      Type=Application
      Icon=1password
      StartupWMClass=1Password
      Comment=Password manager and secure wallet
      MimeType=x-scheme-handler/onepassword;
      Categories=Office;
    '';
  };
}
