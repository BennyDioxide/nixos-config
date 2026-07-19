{
  config,
  ...
}:
{
  services.flameshot = {
    enable = true;

    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;

        # Auto save to this path
        savePath = "${config.home.homeDirectory}/Pictures/Screenshots";
        savePathFixed = true;
        saveAsFileExtension = ".jpg";
        filenamePattern = "%F_%H-%M";
        drawThickness = 1;
        copyPathAfterSave = true;
      };
    };
  };
}
