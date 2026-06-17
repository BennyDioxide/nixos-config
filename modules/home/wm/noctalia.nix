{ flake, ... }:
{
  imports = [
    flake.inputs.noctalia.homeModules.default
  ];

  programs.noctalia.enable = true;
}
