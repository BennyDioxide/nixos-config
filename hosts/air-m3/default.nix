{ config, pkgs, ... }:

let
  username = "bennyyang";
in
{
  imports = [
    ./aerospace
    ./sketchybar
  ];

  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs-macport;
  launchd.user.agents.emacs.environment.TERMINFO_DIRS =
    map (path: path + "/share/terminfo") config.environment.profiles
    ++ [ "/usr/share/terminfo" ];
  environment.enableAllTerminfo = true;

  users.users."${username}".home = "/Users/${username}";
  system.primaryUser = username;
  system.stateVersion = 5;
}
