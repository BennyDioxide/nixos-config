{ lib, ... }:

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
        inherit (lib) genAttrs' nameValuePair;
        # browser = [ "brave-browser.desktop" ];
        browser = [ "firefox.desktop" ];
        osuLazer = "osu!.desktop";
      in
      {
        "text/html" = browser;
        "application/xhtml+xml" = browser;

        "x-scheme-handler/jetbrains" = [ "jetbrains-toolbox.desktop" ];
        "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
      }
      // genAttrs' [
        "about"
        "ftp"
        "http"
        "https"
      ] (s: nameValuePair "x-scheme-handler/${s}" browser)
      // genAttrs' [
        "htm"
        "html"
        "shtml"
        "xhtml"
        "xht"
      ] (s: nameValuePair "application/x-extension-${s}" browser)
      // genAttrs' [
        "beatmap-archive"
        "skin-archive"
        "beatmap"
        "storyboard"
        "replay"
      ] (s: nameValuePair "application/x-osu-${s}" osuLazer)
      // genAttrs' [
        "discord"
        "logseq"
        "vlc"
      ] (s: nameValuePair "x-scheme-handler/${s}" [ "${s}.desktop" ]);
  };
}
