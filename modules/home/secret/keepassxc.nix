{
  xdg.autostart.enable = true;
  programs.keepassxc = {
    enable = true;
    autostart = true;
    settings = {
      General.ConfigVersion = 2;
      General.MinimizeAfterUnlock = true;
      FdoSecrets.Enabled = true;
      Browser.Enabled = true;
      Security.NoConfirmMoveEntryToRecycleBin = false;
      GUI = {
        ApplicationTheme = "auto";
        ColorPasswords = true;
        MinimizeOnClose = true;
        MinimizeOnStartup = true;
        MonospaceNotes = true;
        ShowTrayIcon = true;
        TrayIconAppearance = "monochrome-light";
      };
    };
  };
}
