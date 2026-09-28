{ flake, ... }:
let
  inherit (flake.self) homeModules;
in
{
  home-manager.users.benny = {
    imports = [
      homeModules.editor
      homeModules.multimedia
      homeModules.terminal
      homeModules.shell
      homeModules.wm
    ];

    home.stateVersion = "26.11";
    programs.home-manager.enable = true;
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
}
