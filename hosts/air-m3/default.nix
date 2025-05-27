{ ... }:

let
  username = "bennyyang";
in
{
  imports = [ ./aerospace ];
  users.users."${username}".home = "/Users/${username}";
  system.primaryUser = username;
  system.stateVersion = 5;
}
