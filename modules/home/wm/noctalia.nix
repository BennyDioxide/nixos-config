{ flake, ... }:
{
  imports = [
    flake.inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell.enable = true;
}
