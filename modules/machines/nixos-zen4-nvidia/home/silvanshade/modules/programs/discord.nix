{
  xdg.configFile = {
    "autostart/discord.desktop".text = ''
      [Desktop Entry]
      Categories=Network;InstantMessaging
      Exec=discord --start-minimized %U
      GenericName=All-in-one cross-platform voice and text chat for gamers
      Icon=discord
      MimeType=x-scheme-handler/discord
      Name=Discord
      Type=Application
    '';
  };
}
