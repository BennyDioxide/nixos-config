{
  flake,
  config,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) ragenix secrets;
in
{
  imports = [
    ragenix.nixosModules.default
  ];

  age.secrets.freshrss = {
    file = "${secrets}/freshrss.default.age";
    owner = config.services.freshrss.user;
  };
  age.secrets.aria2.file = "${secrets}/aria2-rpc-token.age";
  age.secrets.steam.file = "${secrets}/steam-api-key.age";
}
