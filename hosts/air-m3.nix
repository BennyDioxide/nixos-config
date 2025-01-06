{ ... }:

let
  username = "bennyyang";
in
{
  users.users."${username}".home = "/Users/${username}";
  system.stateVersion = 5;
}
