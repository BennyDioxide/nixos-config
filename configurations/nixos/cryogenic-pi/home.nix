{
  flake,
  lib,
  pkgs,
  ...
}:
let
  inherit (flake.self) homeModules;
in
{
  home-manager.users.benny = {
    imports = [
      homeModules.editor
      homeModules.font
      homeModules.multimedia
      homeModules.terminal
      homeModules.shell
      homeModules.wm
      ../../../modules/home/development/vcs.nix
    ];

    wayland.windowManager.hyprland.terminal = lib.getExe pkgs.foot;

    home.stateVersion = "26.11";
    programs.home-manager.enable = true;
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
}
