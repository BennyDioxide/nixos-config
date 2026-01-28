{ pkgs, ... }:
{

  imports = [
    ./graphics.nix
    ./gtk.nix
    ./wine
    ./wm
    ./xdg
    ./editor/vscode.nix
    ./editor/zed.nix
    ./productivity/music.nix
    ./productivity/activitywatch.nix
    ./productivity/graphics.nix
    ./productivity/financial.nix
  ];
  systemd.user.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = 1;
    NIX_BUILD_SHELL = "zsh";
    LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
    GTK_USE_PORTAL = 1;
    # QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
  };

  home.packages = with pkgs; [
    appimage-run

    organicmaps

    # Not providing macOS ver for some reason
    rustdesk-flutter
    kdePackages.filelight
    # kiwix

    # lilypond # Broken font
    # macOS framework issues
  ];

  programs.mpv-handler.enable = true;
}
