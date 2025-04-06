{ ... }:

let
  username = "bennyyang";
in
{
  imports = [ ./aerospace ];
  users.users."${username}".home = "/Users/${username}";
  system.stateVersion = 5;
}
