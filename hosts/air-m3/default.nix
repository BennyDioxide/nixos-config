{ ... }:

let
  username = "bennyyang";
in
{
  imports = [
    ./aerospace
    ./sketchybar
  ];
  users.users."${username}".home = "/Users/${username}";
  system.primaryUser = username;
  system.stateVersion = 5;
}
