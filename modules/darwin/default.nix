{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.darwinModules.common
    inputs.ragenix.darwinModules.default
  ];
}
