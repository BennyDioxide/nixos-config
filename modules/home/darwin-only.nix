{ flake, pkgs, ... }:
{
  home.sessionVariables = {
    LIBRARY_PATH = "$LIBRARY_PATH:${pkgs.libiconv}/lib";
  };

  home.packages = with pkgs; [
    raycast
  ];
}
