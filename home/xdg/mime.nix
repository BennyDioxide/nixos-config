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
        genAttrs' =
          list: namef: attrf:
          with lib;
          listToAttrs (map (item: nameValuePair (namef item) (attrf item)) list);
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
      ] (x: "x-scheme-handler/${x}") (_: browser)
      // genAttrs' [
        "htm"
        "html"
        "shtml"
        "xhtml"
        "xht"
      ] (x: "application/x-extension-${x}") (_: browser)
      // genAttrs' [
        "beatmap-archive"
        "skin-archive"
        "beatmap"
        "storyboard"
        "replay"
      ] (x: "application/x-osu-${x}") (_: osuLazer)
      // genAttrs' [
        "discord"
        "logseq"
        "vlc"
      ] (x: "x-scheme-handler/${x}") (x: [ "${x}.desktop" ]);
  };
}
