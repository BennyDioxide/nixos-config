{ ... }:

{
  xdg.mimeApps = {
    enable = true;
    # addedAssociations =
    # let
    # in
    # {
    # };

    defaultApplications =
      let
        # browser = [ "brave-browser.desktop" ];
        browser = [ "firefox.desktop" ];
        osuLazer = "osu!.desktop";
      in
      {
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/ftp" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;

        "application/x-osu-beatmap-archive" = osuLazer;
        "application/x-osu-skin-archive" = osuLazer;
        "application/x-osu-beatmap" = osuLazer;
        "application/x-osu-storyboard" = osuLazer;
        "application/x-osu-replay" = osuLazer;

        "x-scheme-handler/discord" = [ "discord.desktop" ];
        "x-scheme-handler/jetbrains" = [ "jetbrains-toolbox.desktop" ];
        "x-scheme-handler/logseq" = [ "logseq.desktop" ];
        "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
      };
  };
}
