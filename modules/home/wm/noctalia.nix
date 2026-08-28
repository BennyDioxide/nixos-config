{ flake, pkgs, ... }:
{

  programs.noctalia.enable = true;
  programs.noctalia.package =
    flake.inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  programs.ghostty.settings.theme = "noctalia";
}
