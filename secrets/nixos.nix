{
  inputs,
  config,
  ...
}:
let
  inherit (inputs) ragenix secrets;
in
{
  imports = [
    ragenix.nixosModules.default
  ];

  environment.systemPackages = [ ragenix.packages.${config.nixpkgs.system}.default ];

  age.secrets.aria2.file = "${secrets}/aria2-rpc-token.age";
}
