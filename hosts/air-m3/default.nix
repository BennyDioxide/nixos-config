{ pkgs, ... }:

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

  users.users."${username}".home = "/Users/${username}";
  system.primaryUser = username;
  system.stateVersion = 5;
}
