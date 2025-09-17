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
}
