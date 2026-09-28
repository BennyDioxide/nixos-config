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
      ../../../modules/home/development/vcs.nix
    ];

    home.stateVersion = "26.11";
    programs.home-manager.enable = true;
  };

  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];
}
